//
//  IndexedTableView.m
//  ReusePool
//
//  Created by 张恒宇 on 2019/5/5.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "IndexedTableView.h"
#import "ViewReusePool.h"

@interface IndexedTableView (){
    //定义一个容器view
    UIView *containerView;
    //定义一个重用池
    ViewReusePool *reusePool;
}

@end

@implementation IndexedTableView

- (void)reloadData {
    [super reloadData];
    //懒加载
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        //避免索引条随着table滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    if (reusePool == nil) {
        reusePool = [[ViewReusePool alloc] init];
    }
    //标记所有视图为可重用状态
    [reusePool reset];
    //reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    //获取字母索引条的显示内容
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexDataSource indexTitlesForIndexTableView:self];
    }
    //判断字母索引是否为空
    if (!arrayTitles || arrayTitles.count <= 0) {
        [containerView setHidden:YES];
        return;
    }
    NSUInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    for (int i = 0; i < [arrayTitles count]; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        //从重用池中取出一个Button出来
        UIButton *button = (UIButton *)[reusePool dequeueReuseableView];
        if (button == nil) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            //注册button到重用池当中
            [reusePool addUsingView:button];
            NSLog(@"新创建一个Button");
        }else{
            NSLog(@"Button 重用了");
        }
        //添加button到父视图中
        [containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
    }
    [containerView setHidden:NO];
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
}


@end
