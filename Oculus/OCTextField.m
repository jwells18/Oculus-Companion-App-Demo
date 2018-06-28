//
//  OCTextField.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "OCTextField.h"

@implementation OCTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup TextField
    [self setupTextField];
    
    //Setup TextField BottomLine
    [self setupTextFieldBottomLine];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupTextField{
    self.textField = [[UITextField alloc] init];
    self.textField.textColor = [UIColor whiteColor];
    self.textField.tintColor = [UIColor whiteColor];
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    self.textField.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.textField];
}

- (void) setupTextFieldBottomLine{
    self.textFieldBottomLine = [[UIView alloc] init];
    self.textFieldBottomLine.backgroundColor = [UIColor grayColor];
    self.textFieldBottomLine.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.textFieldBottomLine];
}

- (void) setupConstraints{
    UIView *spacerView = [[UIView alloc] init];
    spacerView.userInteractionEnabled = false;
    spacerView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:spacerView];
    
    NSDictionary *viewsDict = @{@"titleLabel":self.titleLabel, @"textField": self.textField, @"textFieldBottomLine": self.textFieldBottomLine, @"spacerView": spacerView};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textField]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textFieldBottomLine]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel(16)][spacerView][textField(20.5)]-4-[textFieldBottomLine(0.5)]|" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(NSString *)title placeholder:(NSString *)placeholder{
    self.titleLabel.text = title;
    self.textField.placeholder = placeholder;
}

@end
