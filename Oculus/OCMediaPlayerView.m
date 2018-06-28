//
//  OCMediaPlayerView.m
//  Oculus
//
//  Created by Justin Wells on 6/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "OCMediaPlayerView.h"
#import "Constants.h"

@interface OCMediaPlayerView()

@property (strong, nonatomic) NSString *videoString;

@end

@implementation OCMediaPlayerView

- (instancetype)initWithFrame:(CGRect)frame videoString:(NSString *)videoString{
    self = [super initWithFrame:frame];
    if (self){
        self.videoString = videoString;
        //Setup View
        [self setupView];
    }
    return self;
}

- (void)dealloc{
    [self.avPlayer removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup AVPlayer
    [self setupAVPlayer];
    
    //Setup Activity Indicator
    [self setupActivityIndicator];
    
    //Setup Gesture Recognizer
    [self setupTapGestureRecognizer];
    
    //Setup Sound Button
    [self setupSoundButton];
    
    //Setup Play Button
    [self setupPlayButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupAVPlayer{
    //Setup AVPlayer
    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.videoString]];
    //Setup AVPlayer Layer
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = self.frame;
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.avPlayerLayer];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:)name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
    [self.avPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    [self.avPlayer setMuted:true];
}

- (void) setupActivityIndicator{
    self.avPlayerActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.avPlayerActivityView.frame = self.frame;
    [self addSubview: self.avPlayerActivityView];
    [self.avPlayerActivityView startAnimating];
}

- (void) setupTapGestureRecognizer{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mediaViewSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTap];
}

- (void) setupSoundButton{
    self.soundButton = [[UIButton alloc] init];
    if([[self.avPlayer.currentItem.asset tracksWithMediaType:AVMediaTypeAudio] count] == 0){
        [self.soundButton setImage:[UIImage imageNamed:@"soundNone"] forState:UIControlStateNormal];
    }
    else{
        if(self.avPlayer.isMuted){
            [self.soundButton setImage:[UIImage imageNamed:@"soundOff"] forState:UIControlStateNormal];
        }
        else{
            [self.soundButton setImage:[UIImage imageNamed:@"soundOn"] forState:UIControlStateNormal];
        }
    }
    self.soundButton.clipsToBounds = YES;
    self.soundButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [self.soundButton addTarget:self action:@selector(soundButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.soundButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.soundButton];
}

- (void) setupPlayButton{
    self.playButton = [[UIButton alloc] init];
    [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    self.playButton.clipsToBounds = YES;
    self.playButton.layer.cornerRadius = 50/2;
    self.playButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self.playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.playButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.playButton];
}

- (void) setupConstraints{
    //Width & Horizontal Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.soundButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.soundButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.soundButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.soundButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
}

//AVPlayer  Delegate
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object == self.avPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.avPlayer.status == AVPlayerStatusReadyToPlay) {
            [self.avPlayerActivityView stopAnimating];
            [self.avPlayer play];
            //Initial Animation of Sound & Play Buttons
            [self showAndFadeOutControls];
        }
        else if (self.avPlayer.status == AVPlayerStatusFailed) {
            //Error. Media is not playing.
        }
    }
}

//Button Delegate
- (void) soundButtonPressed:(id)sender{
    //Setup No Sound Label if video does not have audio
    if([[self.avPlayer.currentItem.asset tracksWithMediaType:AVMediaTypeAudio] count] == 0){
        [self showAndFadeOutControls];
    }
    else{
        //Mute
        if([self.avPlayer isMuted]){
            [self.soundButton setImage:[UIImage imageNamed:@"soundOn"] forState:UIControlStateNormal];
            [self.avPlayer setMuted:false];
            [self showAndFadeOutControls];
        }
        else{
            [self.soundButton setImage:[UIImage imageNamed:@"soundOff"] forState:UIControlStateNormal];
            [self.avPlayer setMuted:true];
            [self showAndFadeOutControls];
        }
    }
}

- (void) playButtonPressed:(id)sender{
    //Check if player is playing
    if ((self.avPlayer.rate != 0) && (self.avPlayer.error == nil)) {
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.avPlayer pause];
        [self showAndFadeOutControls];
    }
    else{
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.avPlayer play];
        [self showAndFadeOutControls];
    }
}

//Gesture Delegate
- (void) mediaViewSingleTap:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded){
        [self showAndFadeOutControls];
    }
}

- (void) showAndFadeOutControls{
    [self.soundButton.layer removeAllAnimations];
    [self.playButton.layer removeAllAnimations];
    self.soundButton.alpha = 1;
    self.playButton.alpha = 1;

    [UIView animateWithDuration:0.5 delay:2.0 options: UIViewAnimationOptionAllowUserInteraction animations:^{
        //Fade Out controls after 2 seconds
        //TODO: Fix bug that prevents second tap when buttons are visible
        //NOTE: Cannot set alpha to 0 until completion because button will then not respond to touches
        self.playButton.alpha = 0.1;
        if(![self.avPlayer isMuted]){
            self.soundButton.alpha = 0.1;
        }
    } completion:^(BOOL finished) {
        self.soundButton.alpha = 0;
        self.playButton.alpha = 0;
    }];
}

@end
