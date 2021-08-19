//
//  AnimationVC.m
//  MyCode
//
//  Created by New_iMac on 2021/6/8.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "AnimationVC.h"

@interface AnimationVC () <CALayerDelegate,CAAnimationDelegate>
@property(nonatomic, strong) AnimationView *animView;
@property(nonatomic, strong) CALayer *myLayerView;

@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTestBtn];
    [self animView];
//    [self myLayerView];
    
    
    
    // 图层动画都是假象，真实的坐标和属性都没有改变，
    
    
}


-(AnimationView*)animView{
    if (!_animView) {
        _animView = [[AnimationView alloc]init];
        _animView.backgroundColor = color_random;
        _animView.bounds = CGRectMake(0, 0, 250, 250);
        _animView.center = CGPointMake(ScreenW/2, ScreenH-200);
        _animView.radius = 25;
        [self.view addSubview:_animView];
    }
    return _animView;
}

-(CALayer*)myLayerView{
    if (!_myLayerView) {
        _myLayerView = [CALayer layer];
        _myLayerView.backgroundColor = color_random.CGColor;
        _myLayerView.bounds = CGRectMake(0, 0, 250, 250);
        _myLayerView.position = CGPointMake(ScreenW/2, ScreenH-200);
        _myLayerView.delegate = self;
        [_myLayerView setNeedsDisplay];
        [self.view.layer addSublayer:_myLayerView];
    }
    return _myLayerView;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetRGBFillColor(ctx, 0.2, 0.5, 0.7, 0.9);
    CGContextAddEllipseInRect(ctx, layer.bounds);
    CGContextFillPath(ctx);
}


-(void)addTestBtn{
    
    NSArray *functionName = @[@"动画",
                              @"测试2",
                              @"动画",
                              @"",
                              @"",
                              @"",
                              @"",
                              @"",
                              @"",
                              @""];
    
    for (int i=0; i<functionName.count; i++) {
        NSString *title = functionName[i];
        if (!title||title.length<1) { break; }
        UIButton *button = [UIButton title:functionName[i] titColorN:color_white font:font_s(15) bgColor:color_theme];
        AddTarget_for_button(button, clickBtn:)
        [button cornerRadius:25];
        button.tag = i+1;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h+30+(i/2)*70);
            make.width.offset(150); make.height.offset(50);
            if (i%2==0) {
                make.right.equalTo(self.view.mas_centerX).offset(-10);
            }else{
                make.left.equalTo(self.view.mas_centerX).offset(10);
            }
        }];
    }
    
}


-(void)clickBtn:(UIButton*)btn{
    switch (btn.tag) {
            
        case 1:{
            [self animation_baseAnimation];
            
        } break;
            
        case 2:{
            [self animation_keyFrameAnimation];
        } break;
            
        case 3:{
            
        } break;
            
        default:
            break;
    }
}


// 隐式动画，只对Layer有用（CATransaction）
-(void)animation_transaction{
    
    [CATransaction begin]; // 开启事物
    _myLayerView.transform = CATransform3DRotate(_myLayerView.transform, M_PI_4, 250, 125, 0);
    _myLayerView.backgroundColor = color_random.CGColor;
//    _animView.backgroundColor = color_random;
//    _animView.center = CGPointMake(150, 150);
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:1.5];
    [CATransaction commit]; // 提交事物
       
}



// 核心动画 CABasicAnimation
-(void)animation_baseAnimation{
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform"; // 动画方式，要看CALayer里面有什么可用属性
    
    // fromValue : 开始值
    // byValue ： 增加多少值
    // toValue ： 最终值

    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(_animView.layer.transform, M_PI_4, 250, 125, 0)];
    anima.duration = 1.5;
    // 保持最新的状态
    anima.fillMode = kCAFillModeForwards;
    // 让图层保持执行完动画的状态
    anima.removedOnCompletion = NO;
    [self.animView.layer addAnimation:anima forKey:@"animView_transform1"];
}




// 核心帧动画 CAKeyframeAnimation
-(void)animation_keyFrameAnimation{
    CAKeyframeAnimation * keyFrameNaima = [CAKeyframeAnimation animation];
    keyFrameNaima.delegate = self;
    keyFrameNaima.keyPath = @"position";
    // 动画执行节奏
    keyFrameNaima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    keyFrameNaima.duration = 1.0;
    keyFrameNaima.removedOnCompletion = NO;
    keyFrameNaima.fillMode = kCAFillModeForwards;
    
    /*
    // 动画执行路径
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(120, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(150, 400)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(170, 300)];
    keyFrameNaima.values = @[value1,value2,value3,value4,value5,value6];
    keyFrameNaima.keyTimes = @[@(0.5),@(0.8),@(1.0)];
    */
    
    // 动画执行路径
    CGMutablePathRef patchRef = CGPathCreateMutable();
    CGPathAddArc(patchRef, NULL, 160, 350, 100, 0,M_PI*2, NO);
    keyFrameNaima.path = patchRef;
    CGPathRelease(patchRef);
    
    // 可用根据后面的key，移除相应的动画
    [self.animView.layer addAnimation:keyFrameNaima forKey:@"animView_position"];

}
// 动画开始的代理
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始。。。");
}
// 动画结束的代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画结束。。。");
}



// 转场动画 CATransition
-(void)animation_transition{
    CATransition *transition = [CATransition animation];
    transition.type = @"cube"; // 动画效果，百度
    transition.duration = 0.5;
    [self.animView.layer addAnimation:transition forKey:@"animView_transition"];
}


-(void)animation_group{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[]; // 里面放其它动画，组成动画组
    [self.animView.layer addAnimation:group forKey:@"animation_group"];
}


 
#pragma mark -> UIView动画

-(void)animation_view{
    [UIView beginAnimations:@"" context:nil];
    [UIView commitAnimations];
}


@end













@implementation AnimationView

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIImage *image1 = [UIImage imageNamed:@"yan_wen_zi"];
    [image1 drawInRect:CGRectMake(25, 25, 200, 200)];
//    CGImageRef refImg = (__bridge CGImageRef)(image1.CIImage);
//    CGContextDrawImage(ctx, CGRectMake(0, 0, 200, 200), refImg);
    CGContextFillPath(ctx);
}

@end
