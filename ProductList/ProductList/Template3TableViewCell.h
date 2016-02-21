//
//  Template3TableViewCell.h
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Template3TableViewCellDelegate<NSObject>
- (void)template3ItemDidSelected:(NSDictionary *)dataDict;
@end

@interface Template3TableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic)NSArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id <Template3TableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@end

