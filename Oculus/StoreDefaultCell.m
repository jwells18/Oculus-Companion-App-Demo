//
//  StoreDefaultCell.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreDefaultCell.h"
#import "Constants.h"
#import "StoreManager.h"


static NSString *cellIdentifier = @"cell";

@interface StoreDefaultCell()

@property (strong, nonatomic) NSMutableArray *apps;

@end

@implementation StoreDefaultCell

@synthesize storeDefaultCellDelegate;

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
    
    //Setup Category Label
    [self setupCategoryLabel];
    
    //Setup SeeAll Label
    [self setupSeeAllButton];
    
    //Setup CollectionView
    [self setupCollectionView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupCategoryLabel{
    self.categoryLabel = [[UILabel alloc] init];
    self.categoryLabel.textColor = [UIColor whiteColor];
    self.categoryLabel.font = [UIFont systemFontOfSize:14];
    self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.categoryLabel];
}

- (void) setupSeeAllButton{
    self.seeAllButton = [[UIButton alloc] init];
    [self.seeAllButton setTitle:NSLocalizedString(@"seeAll", nil) forState: UIControlStateNormal];
    self.seeAllButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.seeAllButton addTarget:self action:@selector(seeAllButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.seeAllButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.seeAllButton];
}

- (void) setupCollectionView{
    //Setup CollectionView Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 0);
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //Setup CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[StoreDefaultCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = COLOR_SECONDARY;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.collectionView];
}

- (void) setupConstraints{
    UIView *spacerView = [[UIView alloc] init];
    spacerView.userInteractionEnabled = false;
    spacerView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:spacerView];
    
    NSDictionary *viewsDict = @{@"categoryLabel": self.categoryLabel, @"spacerView": spacerView, @"seeAllButton": self.seeAllButton, @"collectionView":self.collectionView};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[categoryLabel]-[spacerView]-[seeAllButton]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[categoryLabel]-2-[collectionView]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.seeAllButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.categoryLabel attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
     [self addConstraint: [NSLayoutConstraint constraintWithItem:self.seeAllButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.categoryLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}

- (void) configure:(OCAppSection *)section{
    self.categoryLabel.text = section.name;
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
    return CGSizeMake((collectionView.frame.size.width*0.4), collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreDefaultCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configure:self.apps[indexPath.item]];
    return cell;
}

//CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([storeDefaultCellDelegate respondsToSelector:@selector(didPressStoreDefaultCell:app:)]){
        [self.storeDefaultCellDelegate didPressStoreDefaultCell:self app:self.apps[indexPath.item]];
    }
}

//Button Delegates
- (void) seeAllButtonPressed:(id) sender{
    if ([storeDefaultCellDelegate respondsToSelector:@selector(didPressSeeAllButton:)]){
        [self.storeDefaultCellDelegate didPressSeeAllButton:self];
    }
}

@end
