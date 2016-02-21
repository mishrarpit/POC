//
//  DetailViewController.h
//  ProductList
//
//  Created by Arpit Mishra on 21/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic)NSString *urlStr;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
