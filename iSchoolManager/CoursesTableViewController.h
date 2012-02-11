//
//  CoursesViewController.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface CoursesTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate> 

- (IBAction)reloadCourses:(id)sender;

@property (nonatomic, strong) NSMutableArray* courses;


@end
