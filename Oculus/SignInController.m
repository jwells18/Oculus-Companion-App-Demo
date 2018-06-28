//
//  SignInController.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SignInController.h"
#import "SignInView.h"
#import "BottomNavigationBar.h"
#import "AlertsManager.h"
#import "Constants.h"
#import "AppDelegate.h"
@import Firebase;
#import "ValidationManager.h"

@interface SignInController ()

@property (strong, nonatomic) SignInView *signInView;
@property (strong, nonatomic) BottomNavigationBar *bottomNavigationBar;
@property (strong, nonatomic) AlertsManager *alertsManager;
@property (strong, nonatomic) NSString *emailString;
@property (strong, nonatomic) NSString *passwordString;
@property (strong, nonatomic) ValidationManager *validationManager;

@end

@implementation SignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    //SetupView
    [self setupView];
    
    //Setup Alerts Manager
    self.alertsManager = [[AlertsManager alloc] init];
    
    //Setup Validation Manager
    self.validationManager = [[ValidationManager alloc] init];
}

- (void) viewWillAppear:(BOOL) animated{
    self.navigationController.navigationBarHidden = true;
    //Keyboard Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.signInView.emailField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing: true];
}

- (void) setupView{
    self.view.backgroundColor = COLOR_SECONDARY;
    
    //Setup SignIn View
    [self setupSignInView];
    
    //Setup Bottom NavigationBar
    [self setupBottomNavigationBar];
}

- (void) setupSignInView{
    self.signInView = [[SignInView alloc] init];
    self.signInView.frame = self.view.frame;
    [self.signInView.tapToResignKeyboardRecognizer addTarget:self action:@selector(tapToResignKeyboard:)];
    [self.signInView.resetPasswordButton addTarget:self action:@selector(resetPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.signInView.forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.signInView.emailField.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.signInView.passwordField.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.signInView];
}

- (void) setupBottomNavigationBar{
    self.bottomNavigationBar = [[BottomNavigationBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width, 80)];
    [self.bottomNavigationBar configure:NSLocalizedString(@"back", nil) rightTitle:NSLocalizedString(@"signIn", nil)];
    [self.bottomNavigationBar.leftButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomNavigationBar.rightButton addTarget:self action:@selector(signInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomNavigationBar.rightButton.enabled = false;
    self.bottomNavigationBar.rightButton.alpha = 0.5;
    [self.view addSubview: self.bottomNavigationBar];
}

//Gesture Recognizer Delegate
- (void) tapToResignKeyboard:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded){
        [self.view endEditing:true];
    }
}

//Button Delegates
- (void) resetPasswordButtonPressed:(id) sender{
    //Show Feature Unavailable
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

- (void) forgotPasswordButtonPressed:(id) sender{
    //Show Feature Unavailable
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

- (void) backButtonPressed:(id) sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) signInButtonPressed:(id) sender{
    [[FIRAuth auth] signInWithEmail:self.emailString password:self.passwordString completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if(error){
            UIAlertController *alertVC = [self.alertsManager createErrorAlert:NSLocalizedString(@"error", nil) message:[error localizedDescription]];
            [self presentViewController:alertVC animated:true completion:nil];
        }
        else{
            //Navigate to Welcome Screen
            AppDelegate *appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            [appDelegateTemp setupTabVC];
        }
    }];
}

//Keyboard Delegates
- (void)keyboardWillShow:(NSNotification *)notification{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        //Update BottomNavigationBar
        CGRect bottomNavBarFrame = self.bottomNavigationBar.frame;
        bottomNavBarFrame.origin.y = self.view.frame.size.height-keyboardSize.height-bottomNavBarFrame.size.height;
        self.bottomNavigationBar.frame = bottomNavBarFrame;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 animations:^{
        //TODO: Update SignIn View
        
        //Update BottomNavigationBar
        CGRect bottomNavBarFrame = self.bottomNavigationBar.frame;
        bottomNavBarFrame.origin.y = self.view.frame.size.height-bottomNavBarFrame.size.height;
        self.bottomNavigationBar.frame = bottomNavBarFrame;
    }];
}

//TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // "Length of existing text" - "Length of replaced text" + "Length of replacement text"
    NSInteger newTextLength = [textField.text length] - range.length + [string length];
    
    //Limit Characts
    if(textField == self.signInView.emailField.textField){
        return (newTextLength < 100);
    }
    else if(textField == self.signInView.passwordField.textField){
        return (newTextLength < 100);
    }
    //Prevent emojis and other characters
    if( [string rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location != NSNotFound ) {
        return false;
    }
    
    return true;
}

- (void) textFieldDidChange: (UITextField *) textField{
    if(textField == self.signInView.emailField.textField){
        self.emailString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    else if(textField == self.signInView.passwordField.textField){
        self.passwordString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    //Validate Credentials
    [self validateCredentials];
}

- (void) validateCredentials{
    if([self.validationManager validateEmail:self.emailString] == true && [self.validationManager validatePassword:self.passwordString] == true){
        self.bottomNavigationBar.rightButton.enabled = true;
        self.bottomNavigationBar.rightButton.alpha = 1;
    }
    else{
        self.bottomNavigationBar.rightButton.enabled = false;
        self.bottomNavigationBar.rightButton.alpha = 0.5;
    }
}

@end
