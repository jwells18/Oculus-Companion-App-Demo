//
//  WelcomeToOculusView.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "WelcomeToOculusView.h"
#import "Constants.h"

@implementation WelcomeToOculusView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup AVPlayer
    [self setupAVPlayer];
    
    //Setup TitleLabel
    [self setupTitleLabel];
    
    //Setup SubTitleLabel
    [self setupSubTitleLabel];
    
    //Setup MainButton
    [self setupMainButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupAVPlayer{
    //Setup AVPlayer
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"welcomeVideo" ofType:@"mp4"];
    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:videoPath]];
    //Setup AVPlayer Layer
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.avPlayerLayer];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [self.avPlayer setMuted:true];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = NSLocalizedString(@"welcomeTitle", nil);
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:28];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.titleLabel.alpha = 0;
    [self addSubview:self.titleLabel];
}

- (void) setupSubTitleLabel{
    self.subTitleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text = [NSString stringWithFormat:@"%@\n%@ %@ %@", NSLocalizedString(@"welcomeSubTitle1", nil), NSLocalizedString(@"welcomeSubTitle2", nil), NSLocalizedString(@"welcomeSubTitle3", nil), NSLocalizedString(@"welcomeSubTitle4", nil)];
    NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    self.subTitleLabel.attributedText = attributedString;
    self.subTitleLabel.numberOfLines = 2;
    self.subTitleLabel.linkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                   NSFontAttributeName: [UIFont boldSystemFontOfSize:14]};
    self.subTitleLabel.activeLinkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:14]};
    NSRange exploreHeadsetsRange = [self.subTitleLabel.text rangeOfString:NSLocalizedString(@"welcomeSubTitle2", nil)];
    [self.subTitleLabel addLinkToURL:[NSURL URLWithString:@"exploreHeadsets:"] withRange:exploreHeadsetsRange];
    NSRange exploreAppRange = [self.subTitleLabel.text rangeOfString:NSLocalizedString(@"welcomeSubTitle4", nil)];
    [self.subTitleLabel addLinkToURL:[NSURL URLWithString:@"exploreApp:"] withRange:exploreAppRange];
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.subTitleLabel.alpha = 0;
    [self addSubview:self.subTitleLabel];
}

- (void) setupMainButton{
    self.mainButton = [[UIButton alloc] init];
    self.mainButton.backgroundColor = COLOR_TERTIARY;
    [self.mainButton setTitle:NSLocalizedString(@"startNow", nil) forState: UIControlStateNormal];
    self.mainButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.mainButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.mainButton];
}

- (void) setupConstraints{
    //Width & Horizontal Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:40]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.avPlayerLayer.frame = self.frame;
}

@end
