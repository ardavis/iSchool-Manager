//
//  AddProjectViewController.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/18/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddProjectViewControllerDelegate;

@class Course, Project;

@interface AddProjectViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <AddProjectViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputProjectTitle;
@property (weak, nonatomic) IBOutlet UITextView *inputProjectDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *inputProjectDueDate;
@property (strong, nonatomic) Course *course;
@property (strong, nonatomic) Project *project;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@protocol AddProjectViewControllerDelegate <NSObject>

- (void)addProjectViewControllerDidCancel:(AddProjectViewController *)controller;

- (void)addProjectViewControllerDidFinish:(AddProjectViewController *)controller project:(Project *)project;

@end
