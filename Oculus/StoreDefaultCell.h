//
//  StoreDefaultCell.h
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDefaultCollectionCell.h"
#import "OCAppSection.h"
#import "OCApp.h"

@protocol StoreDefaultCellDelegate <NSObject>

- (void)didPressStoreDefaultCell:(UITableViewCell *)cell app:(OCApp *)app;
- (void)didPressSeeAllButton:(UITableViewCell *)cell;

@end

@interface StoreDefaultCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<StoreDefaultCellDelegate> storeDefaultCellDelegate;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UIButton *seeAllButton;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) StoreDefaultCollectionCell *collectionViewCell;
- (void) configure:(OCAppSection *)section;

@end
