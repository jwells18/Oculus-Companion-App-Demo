//
//  ValidationManager.m
//  Oculus
//
//  Created by Justin Wells on 6/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "ValidationManager.h"

@implementation ValidationManager

- (BOOL)validateEmail:(NSString*)emailString{
    BOOL stricterFilter = false; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
}

- (BOOL)validatePassword:(NSString *)passwordString{
    return (passwordString.length > 5);
}

@end
