//
//  AddCourseViewController.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCourseViewControllerDelegate;

@class Course;

@interface AddCourseViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <AddCourseViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputCourseName;
@property (weak, nonatomic) IBOutlet UITextField *inputCourseNumber;
@property (strong, nonatomic) Course *course;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@end

@protocol AddCourseViewControllerDelegate <NSObject>

- (void)addCourseViewControllerDidCancel:(AddCourseViewController *)controller;

- (void)addCourseViewControllerDidFinish:(AddCourseViewController *)controller course:(Course *)course;

@end
