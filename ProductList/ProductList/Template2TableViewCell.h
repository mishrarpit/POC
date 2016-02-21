//
//  Template2TableViewCell.h
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Template2TableViewCellDelegate<NSObject>
- (void)itemDidSelected:(NSDictionary *)dataDict;
@end

@interface Template2TableViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic)NSArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) id <Template2TableViewCellDelegate> delegate;
@end

