//
//  TestView.m
//  MyCode
//
//  Created by New_iMac on 2021/3/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestView.h"

#define speed_x 0.5

@interface TestView()

@property (nonatomic, assign) float ellipse_x,ellipse_y;
@property (nonatomic, assign) float ellipse_x_2,ellipse_y_2; // 半轴长

@property (nonatomic, assign) CGPoint circle_center;
@property (nonatomic, strong) UIImageView *pointImgView;
@property (nonatomic, assign) float anagleChange;

@end


@implementation TestView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.transform = CATransform3DMakeRotation(M_PI_4,100, 0, 0);

//
        // 圆心(a,b)
        // 设p点坐标为 (x1,yi)
        // 圆方程式 (x1-a)^2 +(y1-b)^2 = r^2;
        
        // 椭圆 x^2/a^2+y^2/b^2=1
        
        // 先假设当前视图是正方形，宽高相等

        
        // 假如X点已知，求Y点
        _anagleChange = 0;
        
        

    }
    return self;
}
-(UIImageView*)pointImgView{
    if (!_pointImgView) {
        _pointImgView = [[UIImageView alloc]init];
        _pointImgView.center = CGPointMake(_ellipse_x_2, 0);
        _pointImgView.bounds = CGRectMake(0, 0, 30, 30);
        _pointImgView.layer.masksToBounds = YES;
        _pointImgView.layer.cornerRadius = 15;
        _pointImgView.backgroundColor = color_random;
        _pointImgView.layer.transform = CATransform3DMakeRotation(-M_PI_4,0, 0, 100);
        [self addSubview:_pointImgView];
    }
    return _pointImgView;
}


-(void)changeViewCenter{
//    CGPoint lastPoint = _pointImgView.center;
    
//    _pointImgView.center = [self calculateNewPointByLastPoint:lastPoint];
    
    CGPoint newCenter = [self calculateNewPointByAngle];
    _pointImgView.center = newCenter;
    
    float transform = (newCenter.y+600)/(_ellipse_y+600);
    _pointImgView.transform = CGAffineTransformScale(CGAffineTransformIdentity, transform, transform);
//    _pointImgView.alpha = newCenter.y/_ellipse_y;

}


//
-(CGPoint)calculateNewPointByAngle{

    _anagleChange =  _anagleChange+0.5;
    float shouldAnagle = M_PI/180*_anagleChange;
    float a_s_pow = powf(_ellipse_x_2*sinf(shouldAnagle),2);
    float b_c_pow = powf(_ellipse_y_2*cosf(shouldAnagle),2);
    float r = (_ellipse_x_2*_ellipse_y_2) / sqrtf(a_s_pow+b_c_pow);
    
    float x, y;
    x = cosf(shouldAnagle)*r+_ellipse_x_2;
    y = sinf(shouldAnagle)*r+_ellipse_y_2;
    
    NSLog(@"  --->  x = %f  y = %f",x,y);
    
    CGPoint newPoint = CGPointMake(x, y);
    return newPoint;
}



// 通过修改x轴长修改cente
-(CGPoint)calculateNewPointByLastPoint:(CGPoint)lastPoint{
    
    float x = lastPoint.x , y = lastPoint.y;
    
    // 分成四个象限处理
    if ( (_ellipse_x_2<=x && x<_ellipse_x) && y<_ellipse_y_2 ) {
        // 第一象限
        x = x+speed_x;
        y =  _ellipse_y_2 - [self point_y_by_x:x];
        
    } else if ( (_ellipse_x_2<=x && x<=_ellipse_x) && y>=_ellipse_y_2 ){
        // 第二象限
        x = x-speed_x;
        y = [self point_y_by_x:x]+_ellipse_y_2;
        
    } else if ( (0<x && x<_ellipse_x_2) && y>_ellipse_y_2 ) {
        // 第三象限
        x = x-speed_x;
        y = [self point_y_by_x:x]+_ellipse_y_2;
        
    } else if ( (0<=x && x<_ellipse_x_2) && y<=_ellipse_y_2 ){
        // 第四象限
        x = x+speed_x;
        y = _ellipse_y_2-[self point_y_by_x:x];
        
    } else {
        NSLog(@"未判断到的地方，可能刚好跟x或y轴重复");
    }
    
    
    
//    NSLog(@"  --->  x = %f  y = %f",x,y);
    CGPoint newPoint = CGPointMake(x, y);
    return newPoint;
}

-(float)point_y_by_x:(float)ponit_x{
    // 椭圆计算公式 x^2/a^2+y^2/b^2=1
    // y^2 = (1-x^2/a^2) * b^2
    // 此处需，先假设坐标原点为0，然后不同象限对y值做不同处理
    float needSqr = ((1-powf(ponit_x-_ellipse_x_2, 2)/powf(_ellipse_x_2, 2))*powf(_ellipse_y_2,2));
    float sqrtNum = sqrtf(needSqr);
//    NSLog(@"计算出的y的值： %f",sqrtNum);
    return sqrtNum; // 返回开平方的值
}





-(void)dealloc{
    log_point_func
}


 
 
 - (void)drawRect:(CGRect)rect {
     
     _ellipse_x = rect.size.width;
     _ellipse_y = rect.size.height;
     _ellipse_x_2 = _ellipse_x/2;
     _ellipse_y_2 = _ellipse_y/2;

     
     NSLog(@"宽：%f  高：%f",rect.size.width,rect.size.height);
     UIBezierPath *patch = [UIBezierPath bezierPathWithOvalInRect:rect];
     patch.lineWidth = 1;
     [[UIColor brownColor] set];
     [patch stroke];
 
     
//     [self pointImgView];
     
//     __weak typeof(self) weakSelf = self;
//     CADisplayLink *displayTimer = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(changeViewCenter)];
//     [displayTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
     
 }
 
 













@end
