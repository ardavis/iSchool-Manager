//
//  ProjectsTableViewController.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/16/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@class Course, Project;

@interface ProjectsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate> 

- (IBAction)reloadProjects:(id)sender;

@property (nonatomic, strong) NSMutableArray* projects;
@property (nonatomic, strong) Course *course;

@end
