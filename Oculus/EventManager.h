//
//  EventManager.h
//  Oculus
//
//  Created by Justin Wells on 6/24/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
#import "OCEvent.h"

@interface EventManager : NSObject

@property (strong, nonatomic) FIRFirestore *db;
typedef void(^EventDownloadBlock)(NSArray *events, NSError *error);
- (void)downloadEvent:(NSString *)eventId completion:(EventDownloadBlock)completionHandler;
- (void) downloadEvents:(NSDate *)targetDate completion:(EventDownloadBlock) completionHandler;

@end
