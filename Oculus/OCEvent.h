//
//  OCEvent.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCEvent : NSObject

@property NSString *objectId;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSString *name;
@property NSDate *startDate;
@property NSDate *endDate;
@property NSString *venue;
@property NSString *image;
@property NSString *details;
@property NSNumber *interestedCount;

@end
