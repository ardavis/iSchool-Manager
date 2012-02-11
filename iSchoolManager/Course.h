//
//  Course.h
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject {
    NSString* _name;
    NSString* _number;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;

@end
