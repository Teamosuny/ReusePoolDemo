//
//  ViewReusePool.m
//  ReusePool
//
//  Created by 张恒宇 on 2019/5/5.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()
//等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUseQueue;
//使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (instancetype)init
{
    self = [super init];
    if (self) {
        _waitUseQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReuseableView {
    //从重用队列取出一个可重用的view
    UIView *view = [_waitUseQueue anyObject];
    if (view == nil) {
        return nil;
    }
    else{
        //进行队列移动
        [_waitUseQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addUsingView:(UIView *)view{
    if (view == nil) {
        return;
    }
    //添加视图到使用的队列中
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        //从使用的队列中移除
        [_usingQueue removeObject:view];
        //加入到等待使用的队列中
        [_waitUseQueue addObject:view];
    }
}

@end
