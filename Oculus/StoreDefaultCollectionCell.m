//
//  StoreDefaultCollectionCell.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreDefaultCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import "StoreFormatter.h"

@implementation StoreDefaultCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    //Setup ImageView
    [self setupImageView];
    
    //Setup TitleLabel
    [self setupTitleLabel];
    
    //Setup PriceLabel
    [self setupPriceLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupImageView{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = true;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageView];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize: 14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupPriceLabel{
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont systemFontOfSize: 14];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.priceLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageView":self.imageView, @"titleLabel": self.titleLabel, @"priceLabel": self.priceLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[priceLabel]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]-4-[titleLabel(18)][priceLabel(18)]|" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(OCApp *)app{
    if(app != nil){
        if(app.image != nil){
            [self.imageView sd_setShowActivityIndicatorView:true];
            [self.imageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:app.image]];
        }
        else{
            self.imageView.image = [UIImage imageNamed:@"oculusPlaceholder"];
        }
        self.titleLabel.text = app.name;
        StoreFormatter *storeFormatter = [[StoreFormatter alloc] init];
        self.priceLabel.attributedText = [storeFormatter stringPriceFromApp: app];
    }
}

@end
