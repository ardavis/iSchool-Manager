//
//  AddCourseViewController.m
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import "AddCourseViewController.h"
#import "CoursesTableViewController.h"
#import "MyModels.h"

@implementation AddCourseViewController

@synthesize inputCourseName = _inputCourseName, inputCourseNumber = _inputCourseNumber;
@synthesize course = _course;
@synthesize delegate = _delegate;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.inputCourseName) || (textField == self.inputCourseNumber)) {
        [textField resignFirstResponder];
    }
    return YES;
}

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

- (void)viewDidUnload
{
    [self setInputCourseName:nil];
    [self setInputCourseNumber:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)done:(id)sender 
{
    self.course = [[Course alloc] init];
    self.course.name = self.inputCourseName.text;
    self.course.number = self.inputCourseNumber.text;
    
    NSLog(@"New Course Name: %@", self.course.name);
    NSLog(@"New Course Number: %@", self.course.number); 
    NSLog(@"Course %@", self.course);
    
    [[self delegate] addCourseViewControllerDidFinish:self course:self.course];
}

- (IBAction)cancel:(id)sender 
{
    [[self delegate] addCourseViewControllerDidCancel:self];
}

@end
