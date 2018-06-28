//
//  StoreFeaturedCell.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreFeaturedCell.h"
#import "Constants.h"
#import "StoreManager.h"

static NSString *cellIdentifier = @"cell";

@interface StoreFeaturedCell()

@property (strong, nonatomic) NSMutableArray *apps;

@end

@implementation StoreFeaturedCell

@synthesize storeFeaturedCellDelegate;

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Setup Data Array
    self.apps = [[NSMutableArray alloc] init];
    
    //Setup CollectionView
    [self setupCollectionView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupCollectionView{
    //Setup CollectionView Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //Setup CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[StoreFeaturedCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = COLOR_SECONDARY;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = true;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.collectionView];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"collectionView":self.collectionView};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[collectionView]-|" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(OCAppSection *)section{
    NSArray *rawDataApps = [section.apps allValues];
    StoreManager *storeManager = [[StoreManager alloc] init];
    for (NSDictionary *rawDataApp in rawDataApps){
        OCApp *app = [storeManager createApp:rawDataApp];
        [self.apps insertObject:app atIndex:0];
    }
    [self.collectionView reloadData];
}

//CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.apps.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreFeaturedCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configure:self.apps[indexPath.item]];
    return cell;
}

//CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([storeFeaturedCellDelegate respondsToSelector:@selector(didPressStoreFeaturedCell:app:)]){
        [self.storeFeaturedCellDelegate didPressStoreFeaturedCell:self app:self.apps[indexPath.item]];
    }
}

@end
