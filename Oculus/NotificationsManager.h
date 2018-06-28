//
//  NotificationsManager.h
//  Oculus
//
//  Created by Justin Wells on 6/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
#import "OCNotification.h"

@interface NotificationsManager : NSObject

@property (strong, nonatomic) FIRFirestore *db;
typedef void(^NotificationDownloadBlock)(NSArray *notifications, NSError *error);
- (void)downloadNotifications:(NSDate *)startDate uid:(NSString *)uid completion:(NotificationDownloadBlock)completionHandler;

@end
