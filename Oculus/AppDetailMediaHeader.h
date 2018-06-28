//
//  AppDetailMediaHeader.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"
#import "OCMediaPlayerView.h"

@interface AppDetailMediaHeader : UIView

@property (strong, nonatomic) OCMediaPlayerView *mediaPlayerView;
- (void) configure:(OCApp *)app;

@end
