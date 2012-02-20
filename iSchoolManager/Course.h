//
//  Course.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject {
    NSString* courseID;
    NSString* name;
    NSString* number;
    NSString* userID;
}

@property (nonatomic, retain) NSString *courseID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *userID;

@end
