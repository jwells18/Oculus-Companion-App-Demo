//
//  StoreFeaturedCollectionCell.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"

@interface StoreFeaturedCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *priceButton;
@property (strong, nonatomic) OCApp *app;
- (void) configure:(OCApp *)app;

@end
