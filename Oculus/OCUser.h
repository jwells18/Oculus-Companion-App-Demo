//
//  OCUser.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCUser : NSObject

@property NSString *objectId;
@property long long *createdAt;
@property long long *updatedAt;
@property NSString *name;
@property NSString *image;

@end
