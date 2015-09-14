//
//  ViewController.m
//  MXButtonDemo
//
//  Created by yww on 15/9/13.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import "ViewController.h"

CGFloat const MXFaultWaitDuration = 1.0f;
#define MXrandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MXButton *myButton;
// 遮盖按钮
@property(nonatomic,strong)UIButton *coverButton;
@end

@implementation ViewController

- (UIButton *)coverButton
{
    if (_coverButton == nil) {
        _coverButton = [[UIButton alloc]initWithFrame:self.view.bounds];
        _coverButton.backgroundColor =
        [UIColor colorWithRed:50/255.0
                        green:50/255.0
                         blue:50/255.0
                        alpha:1];
        //监听
        [_coverButton addTarget:self
                         action:@selector(coverButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MXrandomColor;
    
    //设置图片
    int num = arc4random_uniform(14) + 1;
    NSString *imageName = [NSString stringWithFormat:@"%d",num];
    UIImage *image = [UIImage imageNamed:imageName];
    [self.myButton setImage:image forState:UIControlStateNormal];
    // 监听点击
    [self.myButton addTarget:self
                      action:@selector(myButtonClick:)
            forControlEvents:UIControlEventTouchUpInside];

}
- (IBAction)showMXButtonClick:(UIButton *)sender
{
    NSLog(@"哈哈");
   
}

- (void)myButtonClick:(MXButton*)myButton
{
    if (self.myButton.flag ==0) {
        //放大图片
        [self.myButton enlargeImageInView:self.view
                           centerAtPoint:self.view.center
                                duration:MXFaultWaitDuration
                              completion:nil];
        //添加遮盖按钮
        [self setCoverButton];
    }else
    {
        //缩小图片
        [self.myButton reduceImageInView:self.view
                           centerAtPoint:self.view.center
                                duration:MXFaultWaitDuration
                              completion:nil];
        //消除遮盖
        [self coverButtonRemoveAnimation];
    }
    self.myButton.flag = !self.myButton.flag;
}

//添加遮盖按钮

- (void)setCoverButton
{
  [self.view insertSubview:self.coverButton belowSubview:self.myButton];
}

//遮盖按钮的点击
- (void)coverButtonClick
{
    if (self.myButton.flag == !0)
    {
        [self myButtonClick:self.myButton];
        [self coverButtonRemoveAnimation];
    }
}
//动画
- (void)coverButtonRemoveAnimation
{
    //动画消失遮盖
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.50;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
    [self.coverButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    [NSTimer scheduledTimerWithTimeInterval:theAnimation.duration
                                     target:self
                                   selector:@selector(coverButtonRemove)
                                   userInfo:nil
                                    repeats:NO];
}

//移除遮盖
- (void)coverButtonRemove
{
   [self.coverButton removeFromSuperview];
}

@end
