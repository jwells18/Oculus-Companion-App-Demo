//
//  WelcomeView.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "FacebookButton.h"

@interface WelcomeView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) FacebookButton *facebookButton;
@property (strong, nonatomic) TTTAttributedLabel *agreementLabel;
@property (strong, nonatomic) UIView *separatorLine;
@property (strong, nonatomic) TTTAttributedLabel *accountLabel;

@end
