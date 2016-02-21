//
//  Template3TableViewCell.m
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import "Template3TableViewCell.h"
#import "Template3CollectionViewCell.h"
#import "SharedCache.h"

@implementation Template3TableViewCell

- (void)awakeFromNib {
    [self.collectionView registerNib:[UINib nibWithNibName:@"Template3CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"Template3CollectionViewCellIdentifier"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Template3CollectionViewCellIdentifier";
    Template3CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dataDict = self.dataSourceArray[indexPath.row];
    cell.titleLabel.text = dataDict[@"label"];
    cell.priceLabel.text = @"Rs.500";
    cell.updatedPriceLabel.text = @"Rs.300";
    NSData *imgData = (NSData *)[[SharedCache defaultManager] getItemForKey:dataDict[@"image"]];
    if (imgData) {
        UIImage *img = [UIImage imageWithData:imgData];
        cell.imageView.image = img;
    } else {
        [cell loadImageWithURL:dataDict[@"image"]];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(template3ItemDidSelected:)]) {
        [self.delegate template3ItemDidSelected:self.dataSourceArray[indexPath.row]];
    }
}
@end
