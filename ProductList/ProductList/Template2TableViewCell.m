//
//  Template2TableViewCell.m
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import "Template2TableViewCell.h"
#import "Template2CollectionViewCell.h"
#import "SharedCache.h"

@implementation Template2TableViewCell

- (void)awakeFromNib {
        [self.collectionView registerNib:[UINib nibWithNibName:@"Template2CollectionViewCell"
                                                        bundle:[NSBundle mainBundle]]
              forCellWithReuseIdentifier:@"Template2CollectionViewCellIdentifier"];
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
    static NSString *cellIdentifier = @"Template2CollectionViewCellIdentifier";
    Template2CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dataDict = self.dataSourceArray[indexPath.row];
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
    if ([self.delegate respondsToSelector:@selector(itemDidSelected:)]) {
        [self.delegate itemDidSelected:self.dataSourceArray[indexPath.row]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width, self.contentView.bounds.size.height);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    [self.pageControl setCurrentPage:page];
}
@end
