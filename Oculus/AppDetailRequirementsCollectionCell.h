//
//  AppDetailRequirementsCollectionCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDetailRequirementsCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
- (void) configure:(NSString *)image;

@end
