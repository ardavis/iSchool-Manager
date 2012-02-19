//
//  ProjectsTableViewController.m
//  iSchoolManager
//
//  Created by Andrew Davis on 2/16/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import "ProjectsTableViewController.h"
#import "AddProjectViewController.h"
#import <RestKit/RestKit.h>
#import "MyModels.h"

@interface ProjectsTableViewController () <AddProjectViewControllerDelegate>
- (void)loadProjects;
- (void)reload;
@end

@implementation ProjectsTableViewController

@synthesize projects = _projects, course = _course;
@synthesize incompleteProjects = _incompleteProjects;
@synthesize completeProjects = _completeProjects;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadView
{
    [super loadView];
    [self loadProjects];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSMutableArray*)objects {
    self.projects = objects;
    self.incompleteProjects = [[NSMutableArray alloc] initWithCapacity:self.projects.count];
    self.completeProjects = [[NSMutableArray alloc] initWithCapacity:self.projects.count];
    for (Project* myProject in self.projects)
    {
        NSLog(@"All Projects: %@", self.projects);
        if (myProject.completedAt == NULL)
        {
            // Incomplete
            [self.incompleteProjects addObject:myProject];
        }
        else
        {
            // Complete
            [self.completeProjects addObject:myProject];
        }
        
        NSLog(@"Incomplete Projects %@", self.incompleteProjects);
        NSLog(@"Complete Projects %@", self.completeProjects);
        NSLog(@"Incomplete Count %i", self.incompleteProjects.count);
        NSLog(@"Complete Count %i", self.completeProjects.count);
    }
    
    [self.tableView reloadData];
    
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    NSLog(@"Hit error: %@", error);
}

- (void)loadProjects {
    
    // Load the object model via RestKit
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    objectManager.client.baseURL = @"http://school_manager.dev";
    
    // Setup the URL
    NSString *url = [NSString stringWithFormat:@"/users/1/courses/%d/projects", [[self.course courseID] intValue]];
    
    //    [objectManager loadObjectsAtResourcePath:@"/courses" delegate:self];
    [objectManager loadObjectsAtResourcePath:url delegate:self block:^(RKObjectLoader* loader) {
        
        // School Manager returns projects as a naked array in JSON, so we instruct the loader
        // to user the appropriate object mapping
        if ([objectManager.acceptMIMEType isEqualToString:RKMIMETypeJSON]) {
            loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Project class]];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.incompleteProjects.count;
    }
    else
    {
        return self.completeProjects.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Incomplete";
    }
    else if (section == 1)
    {
        return @"Complete";
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProjectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    static NSDateFormatter *formatter = nil;
    
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    if (indexPath.section == 0)
    {
        // Incomplete
        Project *project = (Project *)[self.incompleteProjects objectAtIndex:indexPath.row];

        NSDate *date = [formatter dateFromString:project.dueDate]; 
        [formatter setDateFormat:@"E, MMM dd 'at' h:mm a"]; // Mon, Feb 20 at 3:35 PM
        
        cell.textLabel.text = project.title;
        
        // Determine detailTextLabel
        if (project.dueDate == NULL)
        {
            cell.detailTextLabel.text = @"TBD";
        }
        else 
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Due: %@", [formatter stringFromDate:date]];
        }
    }
    else if (indexPath.section == 1)
    {
        // Complete
        Project *project = (Project *)[self.completeProjects objectAtIndex:indexPath.row];
        
        NSDate *completedDate = [formatter dateFromString:project.completedAt];
        [formatter setDateFormat:@"E, MMM dd 'at' h:mm a"]; // Mon, Feb 20 at 3:35 PM

        cell.textLabel.text = project.title;
        
        // Determine detailTextLabel
        if (project.completedAt == NULL)
        {
            // Don't set the detailTextLabel.
            cell.detailTextLabel.text = @"";
        }
        else 
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Completd on: %@", [formatter stringFromDate:completedDate]];
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - AddCourse Delegates

- (void)addProjectViewControllerDidCancel:(AddProjectViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addProjectViewControllerDidFinish:(AddProjectViewController *)controller project:(Project *)project
{
    if ([project.title length])
    {
        NSString *postURL = [NSString stringWithFormat:@"/users/1/courses/%d/projects", [project.courseID intValue]];
        
        // Add the new project
        [[RKObjectManager sharedManager] postObject:project delegate:self block:^(RKObjectLoader* loader) { 
            loader.resourcePath = postURL;
            loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForKeyPath:postURL]; 
        }]; 
        
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    // Reload the Data
    [self reload];
}

#pragma segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowAddProjectView"])
    {
        // Get reference to the destination view controller
        AddProjectViewController *vc = (AddProjectViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];        
        
        vc.delegate = self;
        vc.course = self.course;
    }
}

#pragma mark course

- (void)setCourse:(Course *)course {
    _course = course;
    self.title = course.number;
}

- (IBAction)reloadProjects:(id)sender {
    [self reload];
}

- (void)reload
{
    [self loadProjects];
    [self.tableView reloadData];
}

@end
