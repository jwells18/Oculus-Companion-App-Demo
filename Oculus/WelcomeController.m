//
//  WelcomeController.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "WelcomeController.h"
#import "WelcomeView.h"
#import "AlertsManager.h"
#import "SignInController.h"

@interface WelcomeController () <TTTAttributedLabelDelegate>

@property (strong, nonatomic) WelcomeView *welcomeView;
@property (strong, nonatomic) AlertsManager *alertsManager;

@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //SetupView
    [self setupView];
    
    //Setup AlertsManager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) viewWillAppear:(BOOL) animated{
    self.navigationController.navigationBarHidden = true;
}

- (void) setupView{
    //Setup WelcomeView
    [self setupWelcomeView];
}

- (void) setupWelcomeView{
    self.welcomeView = [[WelcomeView alloc] init];
    self.welcomeView.frame = self.view.frame;
    [self.welcomeView.facebookButton addTarget:self action:@selector(facebookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.welcomeView.agreementLabel.delegate = self;
    self.welcomeView.accountLabel.delegate = self;
    [self.view addSubview:self.welcomeView];
}

//Button Delegates
- (void) facebookButtonPressed:(id) sender{
    //Show Feature Unavailable
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

//TTTAttributedLabel Delegate
- (void) attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    if ([url.scheme hasPrefix:@"termsOfService"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: NSLocalizedString(@"termsOfServiceURL", nil)] options:@{} completionHandler:nil];
    }
    else if ([url.scheme hasPrefix:@"privacyPolicy"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: NSLocalizedString(@"privacyPolicyURL", nil)] options:@{} completionHandler:nil];
    }
    else if ([url.scheme hasPrefix:@"signIn"]){
        SignInController *signInVC = [[SignInController alloc] init];
        [self presentViewController:signInVC animated:true completion:nil];
    }
    else if ([url.scheme hasPrefix:@"register"]){
        //Show Feature Unavailable
        [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
    }
}

@end
