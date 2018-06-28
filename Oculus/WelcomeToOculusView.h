//
//  WelcomeToOculusView.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;
#import "TTTAttributedLabel.h"

@interface WelcomeToOculusView : UIView

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) TTTAttributedLabel *subTitleLabel;
@property (strong, nonatomic) UIButton *mainButton;

@end
