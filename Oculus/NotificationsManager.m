//
//  NotificationsManager.m
//  Oculus
//
//  Created by Justin Wells on 6/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "NotificationsManager.h"

@implementation NotificationsManager

- (instancetype)init {
    self = [super init];
    
    //Setup Firestore
    self.db = [FIRFirestore firestore];
    
    return self;
}

- (void)downloadNotifications:(NSDate *)startDate uid:(NSString *)uid completion:(NotificationDownloadBlock)completionHandler{
    
    FIRCollectionReference *notificationsRef = [[[self.db collectionWithPath:@"Notifications"] documentWithPath:uid] collectionWithPath:@"Notifications"];
    
    FIRQuery *query = [[[notificationsRef queryOrderedByField:@"createdAt" descending:true] queryWhereField:@"createdAt" isLessThan:startDate] queryLimitedTo:8];
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        NSMutableArray *notifications = [[NSMutableArray alloc] init];
        if(error){
            NSLog(@"Error downloading notifications: %@", error);
            completionHandler(nil, error);
        }
        else{
            for (FIRDocumentSnapshot *document in snapshot.documents){
                OCNotification *notification = [self createNotification: document.data];
                [notifications addObject:notification];
            }
            completionHandler(notifications, nil);
        }
    }];
}

- (OCNotification *) createNotification:(NSDictionary *)rawData{
    OCNotification *notification = [[OCNotification alloc] init];
    notification.objectId = [rawData objectForKey:@"objectId"];
    notification.createdAt = [rawData objectForKey:@"createdAt"];
    notification.updatedAt = [rawData objectForKey:@"updatedAt"];
    notification.userId = [rawData objectForKey:@"userId"];
    notification.userImage = [rawData objectForKey:@"userImage"];
    notification.title = [rawData objectForKey:@"title"];
    notification.message = [rawData objectForKey:@"message"];
    notification.eventId = [rawData objectForKey:@"eventId"];
    notification.isUnread = [rawData objectForKey:@"isUnread"];
    
    return notification;
}

@end
