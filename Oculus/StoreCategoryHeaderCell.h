//
//  StoreCategoryHeaderCell.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCategoryHeaderCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
- (void) configure:(NSString *)title subTitle:(NSString *)subTitle;

@end
