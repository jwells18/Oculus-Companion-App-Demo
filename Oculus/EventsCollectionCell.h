//
//  EventsCollectionCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EventsCollectionCellDelegate <NSObject>

- (void)didPressEventsCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
- (void)willDisplayEventsCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
- (void)refreshEventsData:(UICollectionViewCell *)cell;
- (void)didPressReadMoreButton:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
- (void)didPressInterestedButton:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

@interface EventsCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id<EventsCollectionCellDelegate> eventsCollectionCellDelegate;
- (void) configure:(NSArray *)events isInitialDownload:(BOOL)isInitialDownload;
- (void) reloadTableData;

@end
