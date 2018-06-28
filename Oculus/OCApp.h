//
//  OCApp.h
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCApp : NSObject

@property NSString *objectId;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSString *name;
@property NSString *category;
@property NSDictionary *genres;
@property NSNumber *price;
@property NSNumber *salePrice;
@property NSString *image;
@property NSArray *images;
@property NSString *video;
@property NSNumber *isPack;
@property NSArray *packApps;
@property NSNumber *rating;
@property NSNumber *ratingCount;
@property NSString *intensity;
@property NSString *details;
@property NSString *esrbRating;
@property NSDictionary *esrbRatingDetails;
@property NSString *refundPolicy;
@property NSDictionary *platforms;
@property NSNumber *isInternetRequired;
@property NSNumber *storageSize;
@property NSDictionary *requirements;
@property NSDictionary *gameModes;
@property NSDate *releaseDate;
@property NSDictionary *languages;
@property NSString *termsURL;
@property NSString *privacyPolicyURL;

@end
