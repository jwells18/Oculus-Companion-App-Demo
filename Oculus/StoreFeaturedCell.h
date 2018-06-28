//
//  StoreFeaturedCell.h
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreFeaturedCollectionCell.h"
#import "OCAppSection.h"
#import "OCApp.h"

@protocol StoreFeaturedCellDelegate <NSObject>

- (void)didPressStoreFeaturedCell:(UITableViewCell *)cell app:(OCApp *)app;

@end

@interface StoreFeaturedCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<StoreFeaturedCellDelegate> storeFeaturedCellDelegate;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) StoreFeaturedCollectionCell *collectionViewCell;
- (void) configure:(OCAppSection *)section;

@end
