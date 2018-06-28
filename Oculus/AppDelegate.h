//
//  AppDelegate.h
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void) setupTabVC;
- (void) setupWelcomeVC;

//Core Data
@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext;


@end

