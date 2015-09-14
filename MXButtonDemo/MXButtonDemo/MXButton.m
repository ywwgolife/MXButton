//
//  MXButton.m
//  MXButtonDemo
//
//  Created by yww on 15/9/13.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static NSString * const MXAnimationKey = @"MXAnimationKey";

@interface MXButton()
@property (copy, nonatomic) void (^animationCompletion)(void);
@end

@implementation MXButton


#pragma mark - 展示图片
//放大图片
- (void)enlargeImageInView:(UIView *)parentView
             centerAtPoint:(CGPoint)position
                  duration:(CGFloat)waitDuration
                completion:(void (^)(void))block
{
    self.center = position;
    //显示
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.8f :0.5f :0.8f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    
    //动画过程
    [self didAnimationWith:forwardAnimation duration:waitDuration View:parentView];
   }

//缩小图片
- (void)reduceImageInView:(UIView *)parentView
            centerAtPoint:(CGPoint)position
                 duration:(CGFloat)waitDuration
               completion:(void (^)(void))block
{
    self.center = position;
    
    //消去
    CABasicAnimation *reverseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    reverseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2f :0.1f :0.2f :-0.75f];
    reverseAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    reverseAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    //动画过程
    [self didAnimationWith:reverseAnimation duration:waitDuration View:parentView];
}

// 动画
- (void)didAnimationWith:(CABasicAnimation*)animation duration:(CGFloat)waitDuration View:(UIView *)parentView


{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:animation,  nil];
    animationGroup.delegate = self;
    animationGroup.duration = animation.duration +  waitDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [parentView addSubview:self];
    [UIView animateWithDuration:animationGroup.duration
                          delay:0.0
                        options:0
                     animations:^{
                         [self.layer addAnimation:animationGroup
                                           forKey:MXAnimationKey];
                     }
                     completion:^(BOOL finished) {
                     }];
    
}


@end
