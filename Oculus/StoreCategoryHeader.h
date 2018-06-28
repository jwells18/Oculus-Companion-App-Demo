//
//  StoreCategoryHeader.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreCategoryHeaderDelegate <NSObject>

- (void)didPressStoryCategoryHeaderCell:(UICollectionViewCell *)sender indexPath:(NSIndexPath *)indexPath;

@end

@interface StoreCategoryHeader : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (void) imposeSearchConstraints:(NSArray *)searchConstraints;
@property (nonatomic, weak) id<StoreCategoryHeaderDelegate> storeCategoryHeaderDelegate;
@property (strong, nonatomic) UICollectionView *collectionView;

@end
