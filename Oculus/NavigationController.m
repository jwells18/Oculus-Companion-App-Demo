//
//  NavigationController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Customize Appearance
    self.navigationBar.translucent = false;
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.backgroundColor = [UIColor blackColor];
}

@end
