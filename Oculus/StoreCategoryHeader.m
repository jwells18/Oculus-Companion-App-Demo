//
//  StoreCategoryHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreCategoryHeader.h"
#import "Constants.h"
#import "StoreCategoryHeaderCell.h"

static NSString *cellIdentifier = @"cell";

@interface StoreCategoryHeader()

@property (strong, nonatomic) NSArray *searchConstraints;

@end

@implementation StoreCategoryHeader

@synthesize storeCategoryHeaderDelegate;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup Data
    self.searchConstraints = [[NSArray alloc] init];
    
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
    [self.collectionView registerClass:[StoreCategoryHeaderCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = COLOR_SECONDARY;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = true;
    self.collectionView.alwaysBounceHorizontal = true;
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

- (void) imposeSearchConstraints:(NSArray *)searchConstraints{
    //For demo purposes: constraints are set manually
    self.searchConstraints = @[@{@"Sort": @"Featured"}, @{@"Genre": @"All"}];
    [self.collectionView reloadData];
}

//CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.searchConstraints.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //TODO: Size cells dynamically
    return CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreCategoryHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *searchConstraint = self.searchConstraints[indexPath.item];
    NSString *searchKey = [[searchConstraint allKeys] firstObject];
    NSString *searchValue = [[searchConstraint allValues] firstObject];
    [cell configure:searchKey subTitle:searchValue];
    return cell;
}

//CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([storeCategoryHeaderDelegate respondsToSelector:@selector(didPressStoryCategoryHeaderCell:indexPath:)]){
        UICollectionViewCell *storeCategoryHeaderCell = [self.collectionView cellForItemAtIndexPath:indexPath];
        [storeCategoryHeaderDelegate didPressStoryCategoryHeaderCell:storeCategoryHeaderCell indexPath:indexPath];
    }
}

@end
