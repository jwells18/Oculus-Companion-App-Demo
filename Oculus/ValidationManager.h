//
//  ValidationManager.h
//  Oculus
//
//  Created by Justin Wells on 6/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationManager : NSObject

- (BOOL)validateEmail:(NSString*)emailString;
- (BOOL)validatePassword:(NSString *)passwordString;

@end
