//
//  AddProjectViewController.m
//  iSchoolManager
//
//  Created by Andrew Davis on 2/18/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import "AddProjectViewController.h"
#import "ProjectsTableViewController.h"
#import "MyModels.h"

@implementation AddProjectViewController

@synthesize course = _course;
@synthesize project = _project;
@synthesize delegate = _delegate;
@synthesize inputProjectTitle = _inputProjectTitle;
@synthesize inputProjectDesc = _inputProjectDesc;
@synthesize inputProjectDueDate = _inputProjectDueDate;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.inputProjectTitle) {
        [textField resignFirstResponder];
    }
    return YES;
}

//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    // provide my own Done/Save button to dismiss the keyboard
//    UINavigationBar *saveNavigationBar;
//    saveNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    saveNavigationBar.barStyle = UIBarStyleBlackOpaque;
//    UINavigationItem *doneItem = [[UINavigationItem alloc] init];   
//    doneItem.title = @"Project Description";
//    
//    UIBarButtonItem *doneItemButton = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
//                                       target:self action:@selector(saveAction:)];
//    UIBarButtonItem *cancelItemButton = [[UIBarButtonItem alloc]
//                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self 
//                                         action:@selector(cancelAction:)];
//    
//    [doneItem setRightBarButtonItem:doneItemButton animated:NO];
//    [doneItem setLeftBarButtonItem:cancelItemButton animated:NO];
//    [saveNavigationBar pushNavigationItem:doneItem animated:NO];
//    
//    [self.view addSubview:saveNavigationBar];
//}

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setInputProjectTitle:nil];
    [self setInputProjectDesc:nil];
    [self setInputProjectDueDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    [[self delegate] addProjectViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    self.project = [[Project alloc] init];
    self.project.title = self.inputProjectTitle.text;
    self.project.desc = self.inputProjectDesc.text;
    self.project.dueDate = [NSString stringWithFormat:@"%@", self.inputProjectDueDate.date];
    self.project.courseID = self.course.courseID;
    
    [[self delegate] addProjectViewControllerDidFinish:self project:self.project];
}
@end
