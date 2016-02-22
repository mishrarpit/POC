//
//  ViewController.m
//  ProductList
//
//  Created by Arpit Mishra on 20/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import "ViewController.h"
#import "Template2TableViewCell.h"
#import "Template3TableViewCell.h"
#import "DetailViewController.h"

#define kDefaultRowHeight 200

static NSString *template1Identifier = @"Template1TableViewCellIdentifier";
static NSString *template2Identifier = @"Template2TableViewCellIdentifier";
static NSString *template3Identifier = @"Template3TableViewCellIdentifier";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, Template2TableViewCellDelegate,Template3TableViewCellDelegate>
{
    NSDictionary *selectedItemDict;
}
@property (strong, nonatomic)NSCache *cache;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cache = [[NSCache alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Template1TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:template1Identifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"Template2TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:template2Identifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"Template3TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:template3Identifier];
    
    [self prepareData];
}
- (void)prepareData {
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataSource2" ofType:@"json"];
    if (filePath.length) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
            if (!error)
                self.dataSourceArray = jsonArr;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSDictionary *dataDict = self.dataSourceArray[indexPath.row];
    if ([dataDict[@"template"] isEqualToString:@"product-template-3"]) {
      Template3TableViewCell *template1cell = [tableView dequeueReusableCellWithIdentifier:template3Identifier];
        template1cell.delegate = self;
        template1cell.dataSourceArray = dataDict[@"items"];
        [template1cell.collectionView reloadData];
        template1cell.headerTitleLabel.text = dataDict[@"label"];
        cell = template1cell;
    }
    else {
        Template2TableViewCell *template2cell = [tableView dequeueReusableCellWithIdentifier:template2Identifier];
        template2cell.delegate = self;
        NSArray *dataArr = dataDict[@"items"];
        if (dataArr.count == 1) {
            [template2cell.pageControl setHidden:YES];
            [template2cell.collectionView setBounces:NO];
        } else {
            [template2cell.pageControl setNumberOfPages:dataArr.count];
        }
        template2cell.dataSourceArray = dataArr;
        [template2cell.collectionView reloadData];
        cell = template2cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultRowHeight;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.tableView reloadData];
}
- (void)itemDidSelected:(NSDictionary *)dataDict {
    selectedItemDict = dataDict;
    [self performSegueWithIdentifier:@"datailViewIdentifier" sender:self];
}
- (void)template3ItemDidSelected:(NSDictionary *)dataDict {
    selectedItemDict = dataDict;
    [self performSegueWithIdentifier:@"datailViewIdentifier" sender:self];
}
//datailViewIdentifier
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.identifier isEqualToString:@"datailViewIdentifier"]) {
        DetailViewController *viewController = segue.destinationViewController;
//        [self.navigationController pushViewController:viewController animated:YES];
        if (selectedItemDict) {
            viewController.urlStr = selectedItemDict[@"web-url"];
        }
    }
}
@end
