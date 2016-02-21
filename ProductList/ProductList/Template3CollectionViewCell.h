//
//  Template3CollectionViewCell.h
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Template3CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;

- (void)loadImageWithURL:(NSString *)url;
@end
