//
//  ViewController.m
//  Test
//
//  Created by xiaomage on 16/4/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    for (NSInteger i = 0; i < 5; i++) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        tableView.frame = CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        tableView.delegate = self;
        [scrollView addSubview:tableView];
    }
    scrollView.contentSize = CGSizeMake(5 * scrollView.frame.size.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor redColor];
    topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    [self.view addSubview:topView];
    self.topView = topView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        UITableView *tableView = scrollView.subviews[index];
        self.topView.frame = CGRectMake(0, -(tableView.contentInset.top + tableView.contentOffset.y), self.view.frame.size.width, 100);
        [self.view addSubview:self.topView];
    } else {
        self.topView.frame = CGRectMake(0, -100, self.view.frame.size.width, 100);
        [scrollView addSubview:self.topView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test - %zd", indexPath.row];
    
    return cell;
}
@end
