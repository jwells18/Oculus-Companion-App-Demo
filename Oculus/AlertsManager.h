//
//  AlertsManager.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertsManager : NSObject

- (UIAlertController *) createFeatureUnavailableAlert;
- (UIAlertController *) createErrorAlert:(NSString *)title message:(NSString *)message;
- (UIAlertController *) createNotificationsMoreAlert;
- (UIAlertController *) createLogoutAlert;

@end
