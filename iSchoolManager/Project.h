//
//  Project.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/16/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject {
    NSString* projectID;
    NSString* courseID;
    NSString* title;
    NSString* desc;
    NSString* dueDate;
    NSString* completedAt;
}

@property (nonatomic, retain) NSString *projectID;
@property (nonatomic, retain) NSString *courseID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *dueDate;
@property (nonatomic, retain) NSString *completedAt;

@end
