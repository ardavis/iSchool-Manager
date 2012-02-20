//
//  ProjectDetailViewController.m
//  iSchoolManager
//
//  Created by Andrew Davis on 2/19/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "MyModels.h"
#import <RestKit/RestKit.h>

@interface ProjectDetailViewController ()
- (void)configureView;
@end

@implementation ProjectDetailViewController
@synthesize projectTitle = _projectTitle;
@synthesize projectDueDate = _projectDueDate;
@synthesize projectDescription = _projectDescription;
@synthesize course = _course;
@synthesize project = _project;
@synthesize projectStatus = _projectStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)configureView
{
    Course *myCourse = self.course;
    Project *myProject = self.project;
    
    static NSDateFormatter *formatter = nil;
    
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    
    
    if (myCourse && myProject) {
        
        self.title = myCourse.number;
        
        self.projectTitle.text = myProject.title;
        self.projectDescription.text = myProject.desc;
        
        if (myProject.completedAt == NULL)
        {
            self.projectStatus.selectedSegmentIndex = INCOMPLETE;
            if (myProject.dueDate == NULL)
            {
                self.projectDueDate.text = @"TBD";
            }
            else
            {
                NSLog(@"Due Date: %@", [formatter stringFromDate:(NSDate *)myProject.dueDate]);
                NSDate *date = [formatter dateFromString:myProject.dueDate]; 
                [formatter setDateFormat:@"E, MMM dd 'at' h:mm a"]; // Mon, Feb 20 at 3:35 PM
                self.projectDueDate.text = [NSString stringWithFormat:@"Due on: %@", [formatter stringFromDate:(NSDate *)date]];
            }
        }
        else
        {
            self.projectStatus.selectedSegmentIndex = COMPLETE;
            self.projectDueDate.text = @"Completed";
        }
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}


- (void)viewDidUnload
{
    [self setProjectTitle:nil];
    [self setProjectDueDate:nil];
    [self setProjectDescription:nil];
    [self setProjectStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)statusChanged:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == INCOMPLETE)
    {
        self.project.completedAt = @"";
    }
    else if (sender.selectedSegmentIndex == COMPLETE)
    {
        NSDate* currentDate = [NSDate date];
        NSString* dateInString = [currentDate description];
        self.project.completedAt = dateInString;
    }
    
    NSInteger cID = [[self.course courseID] intValue];
    NSInteger pID = [[self.project projectID] intValue];
    
    NSString *putURL = [NSString stringWithFormat:@"/users/1/courses/%d/projects/%d", cID, pID];
    NSLog(@"Project ID: %@", self.project.projectID);
    NSLog(@"Project Course ID: %@", self.project.courseID);
    NSLog(@"Project Title: %@", self.project.title);
    NSLog(@"Project Desc: %@", self.project.desc);
    [[RKObjectManager sharedManager] putObject:self.project delegate:(id)self block:^(RKObjectLoader* loader) { 
        loader.resourcePath = putURL;
        loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForKeyPath:putURL]; 
    }]; 
}
@end
