//
//  Template3CollectionViewCell.m
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import "Template3CollectionViewCell.h"
#import "SharedCache.h"
#define kTag 10210

@implementation Template3CollectionViewCell

- (void)loadImageWithURL:(NSString *)url {
    if (url.length) {
        UIActivityIndicatorView *loadingIndicator = [self.imageView viewWithTag:kTag];
        if (!loadingIndicator) {
            loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self.contentView addSubview:loadingIndicator];
        }
        loadingIndicator.tag = kTag;
        [loadingIndicator startAnimating];
        [loadingIndicator setCenter:self.imageView.center];
        
        
        NSURL *_url = [NSURL URLWithString:url];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        [[session dataTaskWithURL:_url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [loadingIndicator stopAnimating];
                [loadingIndicator removeFromSuperview];
                [[SharedCache defaultManager] addItemToCache:data withKey:url];
                self.imageView.image = [UIImage imageWithData:data];
                self.imageView.clipsToBounds = YES;
            });
        }] resume];
    }
}
@end
