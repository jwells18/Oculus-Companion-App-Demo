//
//  SettingsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SettingsCell.h"
#import "Constants.h"

@implementation SettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) configure:(UIImage *)image title:(NSString *)title{
    self.imageView.image = image;
    self.textLabel.text = title;
}

@end
