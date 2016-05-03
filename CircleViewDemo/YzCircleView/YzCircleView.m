//
//  ViewController.h
//  CircleViewDemo
//
//  Created by Yz on 16/4/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzCircleView.h"

#define DefaultTrackLineWidth               3.0f           // 默认轨迹宽度
#define DefaultProgressLineWidth            5.0f           // 默认进度宽度
// 角度转换为弧度
#define CoverToRadian(angle)                (M_PI * (angle) / 180.0f)


@interface YzCircleView ()

// 轨迹layer
@property (nonatomic, strong) CAShapeLayer      *trackLayer;

// 进度条layer
@property (nonatomic, strong) CAShapeLayer      *progressLayer;

// 轨迹路径
@property (nonatomic, strong) UIBezierPath      *circlePathFull;

// 圆形路径
@property (nonatomic, strong) UIBezierPath      *circlePath;

// 左半边渐变颜色
@property (nonatomic, strong) CAGradientLayer   *gradientLayer;

/**
 *  当前进度  范围0 ... 100
 */
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YzCircleView

#pragma mark - Setter

-(void)setProgressLineWidth:(CGFloat)progressLineWidth {
    _progressLayer.lineWidth = progressLineWidth;
}

-(void)setProgressScale:(CGFloat)progressScale {
    _progressScale = progressScale;
    [self updateCirclePath];
}

- (void)setTrackLineWidth:(CGFloat)trackLineWidth {
    _trackLayer.lineWidth = trackLineWidth;
}

-(void)setProgressColor:(UIColor *)progressColor {
    _progressLayer.strokeColor  = progressColor.CGColor;
    
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackLayer.strokeColor = trackColor.CGColor;
}

-(void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self updateCirclePath];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = endAngle;
    if (_endAngle < _startAngle) {
        _startAngle += 360;
    }
    [self updateCirclePath];
}

-(void)setDuration:(CGFloat)duration {
    _duration = duration;
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.duration/100 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)setProgress:(CGFloat)progress {
    _progress = MAX(0, MIN(progress, 100));
    __block CAShapeLayer *progressLayer = self.progressLayer;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        progressLayer.strokeEnd = _progress ;
    });
}

#pragma mark - INIT

+ (YzCircleView *)prograssWithFrame:(CGRect)rect duration:(CGFloat)duration {
    YzCircleView *circleView = [[YzCircleView alloc] initWithFrame:rect];
    circleView.duration = duration;
    return circleView;
}



- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValue];
        [self drawDefaultUI];
    }
    return self;
}


#pragma mark - Other

- (void)setupDefaultValue {
    _progress           = 0;
    _trackLineWidth     = DefaultTrackLineWidth;
    _progressLineWidth  = DefaultProgressLineWidth;
    _progressColor      = [UIColor redColor];
    _trackColor         = [[UIColor greenColor] colorWithAlphaComponent:0.25];
    _startAngle         = -210;
    _endAngle           = 30;
    _colockwise         = YES;
    _progressScale      = 1.0;

}


- (void)drawDefaultUI {

    _trackLayer             = [CAShapeLayer layer];
    _trackLayer.frame       = self.bounds;
    _trackLayer.path        = _circlePath.CGPath;
    _trackLayer.lineWidth   = _trackLineWidth;
    _trackLayer.strokeColor = _trackColor.CGColor;
    _trackLayer.lineCap     = kCALineCapRound;
    _trackLayer.fillColor   = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_trackLayer];
    
    _progressLayer              = [CAShapeLayer layer];
    _progressLayer.path         = _circlePath.CGPath;
    _progressLayer.frame        = self.bounds;
    _progressLayer.lineWidth    = _progressLineWidth;
    _progressLayer.strokeColor  = _progressColor.CGColor;
    _progressLayer.fillColor    = [UIColor clearColor].CGColor;
    _progressLayer.lineCap      = kCALineCapRound;
    _progressLayer.strokeEnd    = _progress ;
    
    _gradientLayer              = [CAGradientLayer layer];
    _gradientLayer.colors       = @[(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    _gradientLayer.locations    = @[@(0.0f),@(0.3f),@(0.7f),@(1.0f)];
    _gradientLayer.startPoint   = CGPointMake(1.0f, 0.0f);
    _gradientLayer.endPoint     = CGPointMake(1.0f, 1.0f);
    _gradientLayer.frame        = self.bounds;
    [_gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:_progressLayer];
    
}

- (void)updateCirclePath {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    // 半径： 取 self.frame的宽高最小值进行计算
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2  - _progressLineWidth / 2 - _trackLineWidth / 2;
    //    startAngle,endAngle 是以M_PI为单位，不是以度数
    _circlePathFull = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:CoverToRadian(self.startAngle) endAngle:CoverToRadian(self.endAngle) clockwise:_colockwise];
    _circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:CoverToRadian(self.startAngle) endAngle:CoverToRadian((self.endAngle - self.startAngle)*self.progressScale + self.startAngle) clockwise:_colockwise];
    _trackLayer.path = _circlePathFull.CGPath;
    _progressLayer.path = _circlePath.CGPath;
}



- (void)updateProgress {
    if (self.progress >= 1) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    self.progress += 0.01;
}

@end
