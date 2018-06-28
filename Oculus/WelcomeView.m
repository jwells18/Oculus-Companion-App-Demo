//
//  WelcomeView.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "WelcomeView.h"
#import "Constants.h"

@implementation WelcomeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = [UIColor whiteColor];
    
    //Setup Background ImageView
    [self setupImageView];
    
    //Setup Facebook Button
    [self setupFacebookButton];
    
    //Setup Agreement Label
    [self setupAgreementLabel];
    
    //Setup Separator Line
    [self setupSeparatorLine];
    
    //Setup Account Label
    [self setupAccountLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupImageView{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = true;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage imageNamed:@"oculusImage1"];
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageView];
}

- (void) setupFacebookButton{
    self.facebookButton = [[FacebookButton alloc] init];
    self.facebookButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.facebookButton];
}

- (void) setupAgreementLabel{
    self.agreementLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text = [NSString stringWithFormat:@"%@\n%@ %@ %@", NSLocalizedString(@"agreementTitle1", nil), NSLocalizedString(@"agreementTitle2", nil), NSLocalizedString(@"agreementTitle3", nil), NSLocalizedString(@"agreementTitle4", nil)];
    NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
    self.agreementLabel.attributedText = attributedString;
    self.agreementLabel.numberOfLines = 2;
    self.agreementLabel.textAlignment = NSTextAlignmentCenter;
    self.agreementLabel.linkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                          NSFontAttributeName: [UIFont boldSystemFontOfSize:12]};
    self.agreementLabel.activeLinkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                                NSFontAttributeName: [UIFont boldSystemFontOfSize:12]};
    NSRange termsRange = [self.agreementLabel.text rangeOfString:NSLocalizedString(@"agreementTitle2", nil)];
    [self.agreementLabel addLinkToURL:[NSURL URLWithString:@"termsOfService:"] withRange:termsRange];
    NSRange privacyPolicyRange = [self.agreementLabel.text rangeOfString:NSLocalizedString(@"agreementTitle4", nil)];
    [self.agreementLabel addLinkToURL:[NSURL URLWithString:@"privacyPolicy:"] withRange:privacyPolicyRange];
    self.agreementLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.agreementLabel];
}

- (void) setupSeparatorLine{
    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.backgroundColor = [UIColor whiteColor];
    self.separatorLine.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.separatorLine];
}

- (void) setupAccountLabel{
    self.accountLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text = [NSString stringWithFormat:@"%@\n%@ %@ %@", NSLocalizedString(@"accountTitle1", nil), NSLocalizedString(@"accountTitle2", nil), NSLocalizedString(@"accountTitle3", nil), NSLocalizedString(@"accountTitle4", nil)];
    NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
    self.accountLabel.attributedText = attributedString;
    self.accountLabel.numberOfLines = 2;
    self.accountLabel.textAlignment = NSTextAlignmentCenter;
    self.accountLabel.linkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:12]};
    self.accountLabel.activeLinkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                                 NSFontAttributeName: [UIFont boldSystemFontOfSize:12]};
    NSRange signInRange = [self.accountLabel.text rangeOfString:NSLocalizedString(@"accountTitle2", nil)];
    [self.accountLabel addLinkToURL:[NSURL URLWithString:@"signIn:"] withRange:signInRange];
    NSRange registerRange = [self.accountLabel.text rangeOfString:NSLocalizedString(@"accountTitle4", nil)];
    [self.accountLabel addLinkToURL:[NSURL URLWithString:@"register:"] withRange:registerRange];
    self.accountLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.accountLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageView":self.imageView, @"facebookButton": self.facebookButton, @"agreementLabel": self.agreementLabel, @"separatorLine": self.separatorLine, @"accountLabel": self.accountLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.facebookButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.facebookButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.agreementLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.agreementLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.separatorLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.separatorLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.25 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.accountLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.accountLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[facebookButton(40)]-5-[agreementLabel(60)][separatorLine(0.5)][accountLabel(60)]|" options:0 metrics:nil views:viewsDict]];
}

@end
