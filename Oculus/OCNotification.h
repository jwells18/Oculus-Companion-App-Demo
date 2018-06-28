//
//  OCNotification.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCNotification : NSObject

@property NSString *objectId;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSString *userId;
@property NSString *userImage;
@property NSString *title;
@property NSString *message;
@property NSString *eventId;
@property NSNumber *isUnread;

@end
