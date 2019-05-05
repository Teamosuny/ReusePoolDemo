//
//  ViewReusePool.h
//  ReusePoolDemo
//
//  Created by 张恒宇 on 2019/5/5.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//实现重用机制的类
@interface ViewReusePool : NSObject

//从重用池中取出一个可重用的view
- (UIView *)dequeueReuseableView;

//向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;

//重置方法,讲当前使用中的视图移除到可重用的队列中
- (void)reset;
@end


