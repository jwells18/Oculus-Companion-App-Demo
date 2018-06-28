//
//  WelcomeToOculusController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "WelcomeToOculusController.h"
#import "WelcomeToOculusView.h"
#import "TTTAttributedLabel.h"
#import "AlertsManager.h"

@interface WelcomeToOculusController () <TTTAttributedLabelDelegate>

@property (strong, nonatomic) WelcomeToOculusView *welcomeToOculusView;
@property (strong, nonatomic) AlertsManager *alertsManager;
@property (strong, nonatomic) NSObject *timeObserver;
@property BOOL isInitialVideoPlay;

@end

@implementation WelcomeToOculusController

- (void)viewDidLoad {
    [super viewDidLoad];
    //SetupView
    [self setupView];
    
    //Setup AlertsManager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.welcomeToOculusView.avPlayer play];
}

- (void) viewWillDisappear:(BOOL) animated{
    [self.welcomeToOculusView.avPlayer removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setupView{
    //Setup WelcomeToOculusView
    [self setupWelcomeToOculusView];
}

- (void) setupWelcomeToOculusView{
    self.welcomeToOculusView = [[WelcomeToOculusView alloc] init];
    self.welcomeToOculusView.frame = self.view.frame;
    self.welcomeToOculusView.subTitleLabel.delegate = self;
    [self.welcomeToOculusView.mainButton addTarget:self action:@selector(mainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.welcomeToOculusView.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 2) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        [weakSelf checkProgress: CMTimeGetSeconds(time)];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:)name:AVPlayerItemDidPlayToEndTimeNotification object:[self.welcomeToOculusView.avPlayer currentItem]];
    [self.welcomeToOculusView.avPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    [self.view addSubview:self.welcomeToOculusView];
}

- (void) checkProgress:(Float64 )progress{
    if (!self.isInitialVideoPlay == true){
        //Remove Periodic Time Observer if 4 seconds has passed
        if (progress > 4){
            [self.welcomeToOculusView.avPlayer removeTimeObserver:self.timeObserver];
            self.isInitialVideoPlay = false;
            //Show Labels
            [UIView animateWithDuration:0.5 animations:^{
                self.welcomeToOculusView.titleLabel.alpha = 1;
                self.welcomeToOculusView.subTitleLabel.alpha = 1;
            }];
        }
    }
}

//Button Delegates
- (void) mainButtonPressed:(id) sender{
    //Show Feature Unavailable
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

#pragma mark - AVPlayer  Delegate
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.welcomeToOculusView.avPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.welcomeToOculusView.avPlayer.status == AVPlayerStatusReadyToPlay) {
            //Media is playing
        } else if (self.welcomeToOculusView.avPlayer.status == AVPlayerStatusFailed) {
            //Error. Media is not playing.
        }
    }
}

//TTTAttributedLabel Delegate
- (void) attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    if ([url.scheme hasPrefix:@"exploreHeadsets"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: NSLocalizedString(@"headsetsURL", nil)] options:@{} completionHandler:nil];
    }
    else if ([url.scheme hasPrefix:@"exploreApp"]){
        [self dismissViewControllerAnimated:true completion:nil];
    }
}


@end
