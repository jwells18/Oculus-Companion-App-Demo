//
//  AppDetailRequirementsCollectionCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailRequirementsCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

@implementation AppDetailRequirementsCollectionCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    //Setup ImageView
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = true;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageView":self.imageView};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(NSString *)image{
    if(image != nil){
        [self.imageView sd_setShowActivityIndicatorView:true];
        [self.imageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
    else{
        self.imageView.image = [UIImage imageNamed:@"oculusPlaceholder"];
    }
}

@end
