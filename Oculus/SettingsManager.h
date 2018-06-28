//
//  SettingsManager.h
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsManager : NSObject

- (NSArray *) getSettingsSections;
- (NSArray *) getSettingsSectionTitles;
- (NSArray *) getSettingsSectionImages;

@end
