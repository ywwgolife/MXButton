//
//  MXButton.h
//  MXButtonDemo
//
//  Created by yww on 15/9/13.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXButton : UIButton
//点击控制
@property(nonatomic,assign)BOOL flag;

//放大时间
@property (assign, nonatomic) CGFloat forwardAnimationDuration;
//缩小时间
@property (assign, nonatomic) CGFloat backwardAnimationDuration;

//放大图片
- (void)enlargeImageInView:(UIView *)parentView
             centerAtPoint:(CGPoint)position
                  duration:(CGFloat)waitDuration
                completion:(void (^)(void))block;

//缩小图片
- (void)reduceImageInView:(UIView *)parentView
            centerAtPoint:(CGPoint)position
                 duration:(CGFloat)waitDuration
               completion:(void (^)(void))block;
@end
