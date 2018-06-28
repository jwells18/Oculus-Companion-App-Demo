//
//  OCAppSection.h
//  Oculus
//
//  Created by Justin Wells on 6/24/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCAppSection : NSObject

@property NSString *objectId;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSString *name;
@property NSDictionary *apps;
@property NSNumber *priority;
@property NSDictionary *searchConstraints;

@end
