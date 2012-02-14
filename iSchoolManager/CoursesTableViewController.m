//
//  CoursesViewController.m
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "AddCourseViewController.h"
#import "Course.h"
#import <RestKit/RestKit.h>


@interface CoursesTableViewController () <AddCourseViewControllerDelegate>
- (void)loadCourses;
- (void)reload;
@end

@implementation CoursesTableViewController

@synthesize courses = _courses;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (void)loadView
{
    [super loadView];
    [self loadCourses];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSMutableArray*)objects {
    self.courses = objects;
    for (int i = 0; i < self.courses.count; i++) {
        Course *myCourse = [self.courses objectAtIndex:i];
        NSLog(@"Course #%i Name - %@", i, myCourse.name);
        NSLog(@"Course #%i Number - %@", i, myCourse.number);
        NSLog(@"Course #%i ID - %@", i, myCourse.courseID);
    }
    [self.tableView reloadData];
    
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    NSLog(@"Hit error: %@", error);
}

- (void)loadCourses {

    // Load the object model via RestKit
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    objectManager.client.baseURL = @"http://school_manager.dev";

    [objectManager loadObjectsAtResourcePath:@"/courses" delegate:self];
//    [objectManager loadObjectsAtResourcePath:@"/courses" delegate:self block:^(RKObjectLoader* loader) {
//        // School Manager returns statuses as a naked array in JSON, so we instruct the loader
//        // to user the appropriate object mapping
//        if ([objectManager.acceptMIMEType isEqualToString:RKMIMETypeJSON]) {
//            loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Course class]];
//        }
//    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CourseCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Course *course = (Course *)[self.courses objectAtIndex:indexPath.row];
    
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = course.number;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the course from the data source
        
        NSLog(@"All Courses: %@", self.courses);
        
        for (int i = 0; i < self.courses.count; i++) {
            Course *myCourse = [self.courses objectAtIndex:i];
            NSLog(@"Course #%i Name - %@", i, myCourse.name);
            NSLog(@"Course #%i Number - %@", i, myCourse.number);
            NSLog(@"Course #%i ID - %@", i, myCourse.courseID);
        }
        
        NSLog(@"Swiped Row: %i", indexPath.row);
        
        Course *course = [self.courses objectAtIndex:indexPath.row];
        NSLog(@"Course Name: %@", course.name);
        NSLog(@"Course Number: %@", course.number);
        NSLog(@"Course ID: %@", course.courseID);
        
        [[RKObjectManager sharedManager] deleteObject:course delegate:self];
 
    }   
}

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

- (void)addCourseViewControllerDidFinish:(AddCourseViewController *)controller course:(Course *)course
{
    if ([course.name length] || [course.number length]) {
        
        // Add the new course
        [[RKObjectManager sharedManager] postObject:course delegate:self block:^(RKObjectLoader* loader) { 
            loader.resourcePath = @"/users/23/courses";
            loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForKeyPath:@"/users/23/courses"]; 
        }]; 
        
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    // Reload the data
    [self reload];
}

- (void)addCourseViewControllerDidCancel:(AddCourseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"ShowAddCourseView"]) 
    {
        // Get reference to the destination view controller
        AddCourseViewController *vc = (AddCourseViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];        
        
        vc.delegate = self;
    }
}

- (void)reload
{
    [self loadCourses];
    [self.tableView reloadData];
}

- (IBAction)reloadCourses:(id)sender {
    [self reload];
}

@end
