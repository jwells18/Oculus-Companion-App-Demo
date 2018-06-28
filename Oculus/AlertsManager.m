//
//  AlertsManager.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AlertsManager.h"
#import "AppDelegate.h"
@import Firebase;

@implementation AlertsManager

- (UIAlertController *) createFeatureUnavailableAlert{
    //Show Alert that this feature is not available
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"sorry", nil)
                                          message:NSLocalizedString(@"featureUnavailableMessage", nil)
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    return alertController;
}

- (UIAlertController *) createErrorAlert:(NSString *)title message:(NSString *)message{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    return alertController;
}

- (UIAlertController *) createNotificationsMoreAlert{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *markUnreadAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"markAsUnread", nil) style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *unsubscribeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"unsubscribe", nil) style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:markUnreadAction];
    [alertController addAction:unsubscribeAction];
    [alertController addAction:cancelAction];
    return alertController;
}

- (UIAlertController *) createLogoutAlert{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"logoutTitle", nil)
                                          message:NSLocalizedString(@"logoutMessage", nil)
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"logout", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        NSError *signOutError;
        BOOL status = [[FIRAuth auth] signOut:&signOutError];
        if (!status) {
            NSLog(@"Error signing out: %@", signOutError);
            return;
        }else{
            //Navigate to Welcome Screen
            AppDelegate *appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            [appDelegateTemp setupWelcomeVC];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    return alertController;
}

@end
