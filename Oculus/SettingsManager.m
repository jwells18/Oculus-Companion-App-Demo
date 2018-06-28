//
//  SettingsManager.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SettingsManager.h"

@implementation SettingsManager

- (NSArray *) getSettingsSections{
    NSArray *settingsSections = @[NSLocalizedString(@"account", nil), NSLocalizedString(@"payment", nil), NSLocalizedString(@"advanced", nil)];
    return settingsSections;
}

- (NSArray *) getSettingsSectionTitles{
    NSArray *accountSectionTitles = @[NSLocalizedString(@"linkedAccounts", nil), NSLocalizedString(@"cameraRollAccess", nil), NSLocalizedString(@"changeOculusPassword", nil), NSLocalizedString(@"resetOculusPin", nil), NSLocalizedString(@"privacySettings", nil), NSLocalizedString(@"notifications", nil)];
    NSArray *paymentSectionTitles = @[NSLocalizedString(@"paymentMethods", nil), NSLocalizedString(@"purchaseHistory", nil)];
    NSArray *advancedSectionTitles = @[NSLocalizedString(@"legal", nil), NSLocalizedString(@"healthAndSafety", nil), NSLocalizedString(@"help", nil), NSLocalizedString(@"version", nil)];
    return @[accountSectionTitles, paymentSectionTitles, advancedSectionTitles];
}

- (NSArray *) getSettingsSectionImages{
    NSArray *accountSectionImages = @[[UIImage imageNamed:@"linkedAccounts"], [UIImage imageNamed:@"cameraRollAccess"], [UIImage imageNamed:@"changeOculusPassword"], [UIImage imageNamed:@"resetOculusPin"], [UIImage imageNamed:@"privacySettings"], [UIImage imageNamed:@"notifications1"]];
    NSArray *paymentSectionImages = @[[UIImage imageNamed:@"paymentMethods"], [UIImage imageNamed:@"purchaseHistory"]];
    NSArray *advancedSectionImages = @[[UIImage imageNamed:@"legal"], [UIImage imageNamed:@"healthAndSafety"], [UIImage imageNamed:@"help"], [UIImage imageNamed:@"version"]];
    return @[accountSectionImages, paymentSectionImages, advancedSectionImages];
}

@end
