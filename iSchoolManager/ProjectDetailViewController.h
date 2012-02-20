//
//  ProjectDetailViewController.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/19/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Course, Project;

@interface ProjectDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *projectDueDate;
@property (weak, nonatomic) IBOutlet UILabel *projectDescription;
@property (strong, nonatomic) Course *course;
@property (strong, nonatomic) Project *project;
@property (weak, nonatomic) IBOutlet UISegmentedControl *projectStatus;


- (IBAction)statusChanged:(id)sender;

@end
