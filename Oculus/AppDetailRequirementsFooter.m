//
//  AppDetailRequirementsFooter.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailRequirementsFooter.h"
#import "AppDetailRequirementsCollectionCell.h"
#import "Constants.h"

static NSString *cellIdentifier = @"cell";

@interface AppDetailRequirementsFooter()

@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) AppDetailRequirementsCollectionCell *collectionViewCell;

@end

@implementation AppDetailRequirementsFooter

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
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
    [self.collectionView registerClass:[AppDetailRequirementsCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
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

- (void) configure:(OCApp *)app{
    self.app = app;
    [self.collectionView reloadData];
}

//CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.app.images.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AppDetailRequirementsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configure:self.app.images[indexPath.item]];
    return cell;
}

@end
