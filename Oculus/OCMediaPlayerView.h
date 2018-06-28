//
//  OCMediaPlayerView.h
//  Oculus
//
//  Created by Justin Wells on 6/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;
@import MediaPlayer;

@interface OCMediaPlayerView : UIView

- (instancetype)initWithFrame:(CGRect)frame videoString:(NSString *)videoString;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong, nonatomic) UIActivityIndicatorView *avPlayerActivityView;
@property (strong, nonatomic) UIButton *soundButton;
@property (strong, nonatomic) UIButton *playButton;

@end
