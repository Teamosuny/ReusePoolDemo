//
//  ViewController.m
//  ReusePool
//
//  Created by 张恒宇 on 2019/5/5.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "ViewController.h"
#import "IndexedTableView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,IndexedTableViewDataSource>
{
    IndexedTableView *tableView;//带索引条的tableView
    UIButton *button;
    NSMutableArray *dataSource;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个tableView
    tableView = [[IndexedTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    //设置索引数据源
    tableView.indexDataSource = self;
    [self.view addSubview:tableView];
    //创建一个按钮
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //数据源
    dataSource = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [dataSource addObject:@(i + 1)];
    }
}

- (void)doAction:(UIButton *)snder {
    NSLog(@"reloadData");
    [tableView reloadData];
}

#pragma indexTitlesForIndexDataSource
- (NSArray<NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView{
    //奇数次调用返回6个字母,偶数次调用返回11个
    static BOOL change = NO;
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    }else{
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] stringValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

@end
