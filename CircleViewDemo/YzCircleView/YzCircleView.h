//
//  ViewController.h
//  CircleViewDemo
//
//  Created by Yz on 16/4/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface YzCircleView : UIView

/**
 *  动画时间 默认0.3
 */
@property (nonatomic, assign) CGFloat duration;

/**
 *  完成比例 默认 （0 ~ 1）
 */
@property (nonatomic, assign) CGFloat progressScale;

/**
 *  进度轨迹线宽 默认宽度 3.0f
 */
@property (nonatomic, assign) CGFloat trackLineWidth;

/**
 *  进度条线宽  默认宽度 5.0f
 */
@property (nonatomic, assign) CGFloat progressLineWidth;

/**
 *  进度条的颜色 默认 [[UIColor red] colorWithAlphaComponent:1];
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 *  轨迹的颜色 默认 [[UIColor greenColor] colorWithAlphaComponent:0.25];
 */
@property (nonatomic, strong) UIColor *trackColor;

/**
 *  轨迹进度条 圆弧的起始角度  默认 -210°
 */
@property (nonatomic, assign) CGFloat startAngle;

/**
 *  轨迹进度条 圆弧的终止角度  默认 30°
 */
@property (nonatomic, assign) CGFloat endAngle;

/**
 *  圆弧是否顺时针绘制  默认YES
 */
@property (nonatomic, assign) BOOL colockwise;


/**
 *  初始化方法
 *
 *  @param rect     控件尺寸
 *  @param duration 动画时间
 *
 *  @return <#return value description#>
 */

+ (YzCircleView *)prograssWithFrame:(CGRect)rect duration:(CGFloat)duration;


@end
