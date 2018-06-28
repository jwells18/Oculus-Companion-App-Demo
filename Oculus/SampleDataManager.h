//
//  SampleDataManager.h
//  Oculus
//
//  Created by Justin Wells on 6/23/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
#import "DateManager.h"

@interface SampleDataManager : NSObject

@property (strong, nonatomic) FIRFirestore *db;
@property (strong, nonatomic) DateManager *dateManager;
- (void) uploadSampleApps;
- (void) uploadSampleAppSections;
- (void) uploadSampleEvents;
- (void) uploadSampleNotifications;

@end
