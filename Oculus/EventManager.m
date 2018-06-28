//
//  EventManager.m
//  Oculus
//
//  Created by Justin Wells on 6/24/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "EventManager.h"

@implementation EventManager

- (instancetype)init {
    self = [super init];
    
    //Setup Firestore
    self.db = [FIRFirestore firestore];
    
    return self;
}

- (void)downloadEvent:(NSString *)eventId completion:(EventDownloadBlock)completionHandler{
    FIRCollectionReference *eventsRef = [self.db collectionWithPath:@"Events"];
    FIRQuery *query = [eventsRef queryWhereField:@"objectId" isEqualTo:eventId];
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        NSMutableArray *events = [[NSMutableArray alloc] init];
        if(error){
            NSLog(@"Error downloading events: %@", error);
            completionHandler(nil, error);
        }
        else{
            for (FIRDocumentSnapshot *document in snapshot.documents){
                OCEvent *event = [self createEvent: document.data];
                [events addObject:event];
            }
            completionHandler(events, nil);
        }
    }];
}

- (void)downloadEvents:(NSDate *)targetDate completion:(EventDownloadBlock)completionHandler{
    FIRCollectionReference *eventsRef = [self.db collectionWithPath:@"Events"];
    FIRQuery *query = [[[eventsRef queryOrderedByField:@"startDate"] queryWhereField:@"startDate" isGreaterThan:targetDate] queryLimitedTo:8];
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        NSMutableArray *events = [[NSMutableArray alloc] init];
        if(error){
            NSLog(@"Error downloading events: %@", error);
            completionHandler(nil, error);
        }
        else{
            for (FIRDocumentSnapshot *document in snapshot.documents){
                OCEvent *event = [self createEvent: document.data];
                [events addObject:event];
            }
            completionHandler(events, nil);
        }
    }];
}

- (OCEvent *) createEvent:(NSDictionary *)rawData{
    OCEvent *event = [[OCEvent alloc] init];
    event.objectId = [rawData objectForKey:@"objectId"];
    event.createdAt = [rawData objectForKey:@"createdAt"];
    event.updatedAt = [rawData objectForKey:@"updatedAt"];
    event.name = [rawData objectForKey:@"name"];
    event.startDate = [rawData objectForKey:@"startDate"];
    event.endDate = [rawData objectForKey:@"endDate"];
    event.venue = [rawData objectForKey:@"venue"];
    event.image = [rawData objectForKey:@"image"];
    event.details = [rawData objectForKey:@"details"];
    event.interestedCount = [rawData objectForKey:@"interestedCount"];
    
    return event;
}

@end
