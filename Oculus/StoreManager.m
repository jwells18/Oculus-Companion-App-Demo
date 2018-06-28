//
//  StoreManager.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreManager.h"

@implementation StoreManager

- (instancetype)init {
    self = [super init];
    
    //Setup Firestore
    self.db = [FIRFirestore firestore];
    
    return self;
}

- (NSArray *) getAdditionalDetailsTitles{
    NSArray *additionalDetailsTitles = @[@"gameModes", @"category", @"genres", @"released", @"languages", @"termsOfService", @"privacyPolicy"];
    return additionalDetailsTitles;
}

- (void)downloadAppSections:(NSNumber *)priority completion:(AppSectionDownloadBlock)completionHandler{
    FIRCollectionReference *appsRef = [self.db collectionWithPath:@"AppSections"];
    FIRQuery *query = [[[appsRef queryOrderedByField:@"priority" descending:false] queryWhereField:@"priority" isGreaterThan:priority] queryLimitedTo:8];
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        NSMutableArray *sections = [[NSMutableArray alloc] init];
        if(error){
            NSLog(@"Error downloading apps: %@", error);
            completionHandler(nil, error);
        }
        else{
            for (FIRDocumentSnapshot *document in snapshot.documents){
                OCAppSection *section = [self createAppSection: document.data];
                [sections addObject:section];
            }
            completionHandler(sections, nil);
        }
    }];
}

- (void)downloadApp:(NSString *)appId completion:(AppDownloadBlock)completionHandler{
    FIRCollectionReference *appsRef = [self.db collectionWithPath:@"Apps"];
    FIRQuery *query = [appsRef queryWhereField:@"objectId" isEqualTo:appId];
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error downloading apps: %@", error);
            completionHandler(nil, error);
        }
        else{
            OCApp *app;
            for (FIRDocumentSnapshot *document in snapshot.documents){
                app = [self createApp: document.data];
            }
            completionHandler(app, nil);
        }
    }];
}

- (void) searchStore:(NSDictionary *)constraints completion:(AppSearchBlock) completionHandler{
    //TODO: Add constraints for search
    FIRCollectionReference *appsRef = [self.db collectionWithPath:@"Apps"];
    FIRQuery *query = [appsRef queryOrderedByField:@"createdAt"];
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        NSMutableArray *apps = [[NSMutableArray alloc] init];
        if(error){
            NSLog(@"Error downloading apps: %@", error);
            completionHandler(nil, error);
        }
        else{
            for (FIRDocumentSnapshot *document in snapshot.documents){
                OCApp *app = [self createApp: document.data];
                [apps addObject:app];
            }
            completionHandler(apps, nil);
        }
    }];
}

- (OCAppSection *) createAppSection:(NSDictionary *)rawData{
    OCAppSection *section = [[OCAppSection alloc] init];
    section.objectId = [rawData objectForKey:@"objectId"];
    section.createdAt = [rawData objectForKey:@"createdAt"];
    section.updatedAt = [rawData objectForKey:@"updatedAt"];
    section.name = [rawData objectForKey:@"name"];
    section.apps = [rawData objectForKey:@"apps"];
    section.priority = [rawData objectForKey:@"priority"];
    
    return section;
}

- (OCApp *) createApp:(NSDictionary *)rawData{
    OCApp *app = [[OCApp alloc] init];
    app.objectId = [rawData objectForKey:@"objectId"];
    app.createdAt = [rawData objectForKey:@"createdAt"];
    app.updatedAt = [rawData objectForKey:@"updatedAt"];
    app.name = [rawData objectForKey:@"name"];
    app.category = [rawData objectForKey:@"category"];
    app.genres = [rawData objectForKey:@"genres"];
    app.price = [rawData objectForKey:@"price"];
    app.salePrice = [rawData objectForKey:@"salePrice"];
    app.image = [rawData objectForKey:@"image"];
    app.images = [rawData objectForKey:@"images"];
    app.video = [rawData objectForKey:@"video"];
    app.isPack = [rawData objectForKey:@"isPack"];
    app.packApps = [rawData objectForKey:@"packApps"];
    app.rating = [rawData objectForKey:@"rating"];
    app.ratingCount = [rawData objectForKey:@"ratingCount"];
    app.intensity = [rawData objectForKey:@"intensity"];
    app.details = [rawData objectForKey:@"details"];
    app.esrbRating = [rawData objectForKey:@"esrbRating"];
    app.esrbRatingDetails = [rawData objectForKey:@"esrbRatingDetails"];
    app.refundPolicy = [rawData objectForKey:@"refundPolicy"];
    app.platforms = [rawData objectForKey:@"platforms"];
    app.isInternetRequired = [rawData objectForKey:@"isInternetRequired"];
    app.storageSize = [rawData objectForKey:@"storageSize"];
    app.requirements = [rawData objectForKey:@"requirements"];
    app.gameModes = [rawData objectForKey:@"gameModes"];
    app.releaseDate = [rawData objectForKey:@"releaseDate"];
    app.languages = [rawData objectForKey:@"languages"];
    app.termsURL = [rawData objectForKey:@"termsURL"];
    app.privacyPolicyURL = [rawData objectForKey:@"privacyPolicyURL"];
    
    return app;
}


@end
