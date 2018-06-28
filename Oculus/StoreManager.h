//
//  StoreManager.h
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
#import "OCAppSection.h"
#import "OCApp.h"

@interface StoreManager : NSObject

- (NSArray *) getAdditionalDetailsTitles;
@property (strong, nonatomic) FIRFirestore *db;
typedef void(^AppSectionDownloadBlock)(NSArray *sections, NSError *error);
- (void)downloadAppSections:(NSNumber *)priority completion:(AppSectionDownloadBlock)completionHandler;
typedef void(^AppDownloadBlock)(OCApp *app, NSError *error);
- (void)downloadApp:(NSString *)appId completion:(AppDownloadBlock)completionHandler;
typedef void(^AppSearchBlock)(NSArray *apps, NSError *error);
- (void) searchStore:(NSDictionary *)constraints completion:(AppSearchBlock) completionHandler;
- (OCApp *) createApp:(NSDictionary *)rawData;

@end
