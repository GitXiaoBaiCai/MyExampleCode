//
//  CALayerVC.m
//  MyCode
//
//  Created by New_iMac on 2021/6/8.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "CALayerVC.h"

@interface CALayerVC () <CALayerDelegate>
 
@property(nonatomic, strong) CustomLayerView *layerView;
@property(nonatomic, strong) CustomLayer *layer;
@property(nonatomic, strong) UIImageView *imageView;
          
@end

@implementation CALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTestBtn];
//    [self layerView];
//    [self layer];
    
    
    [self imageView];
    [self creatBitmap];
}


-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = color_group;
        _imageView.frame = CGRectMake(30, 300, 300, 300);
        _imageView.layer.borderColor = color_random.CGColor;
        _imageView.layer.borderWidth = 2;
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}




// 创建一个图形上下文 (创建圆角图片)
-(void)creatBitmap{
    
    // 开启新的图形上下文(基于位图bitmap)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 300), NO, [UIScreen mainScreen].scale);
    
    // 获取当前位图上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    [color_random set];
    CGContextSetLineWidth(ref, 5);
    CGContextAddEllipseInRect(ref, CGRectMake(10, 10, 280, 280));
    CGContextStrokePath(ref);
    
    CGContextRestoreGState(ref);
    CGContextAddEllipseInRect(ref, CGRectMake(15, 15, 270, 270));
    CGContextClip(ref); // 裁剪上下文，(上面的代码不裁剪，下面代码的都裁剪)，超出圆的部分都要删除
    
    // 绘制
    UIImage *bgImg = [UIImage imageNamed:@"yan_wen_zi"];
    [bgImg drawInRect:CGRectMake(15, 15, 270, 270)];
    
    // 获取上下文内容
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImg;
    
}


// 屏幕截图
-(void)clipScreen{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    self.imageView.image = newImg;
}


-(void)addTestBtn{
    
    NSArray *functionName = @[@"测试1",
                              @"",
                              @"",
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
//            [_layer setNeedsDisplay];
            [self clipScreen];
        } break;
            
        case 2:{
            
        } break;
            
        case 3:{
            
        } break;
            
        default:
            break;
    }
}

-(CustomLayer*)layer{
    if (!_layer) {
        _layer = [CustomLayer layer];
        _layer.backgroundColor = color_random.CGColor;
        _layer.bounds = CGRectMake(0, 0, 300, 300);
        _layer.position = CGPointMake(ScreenW/2,ScreenH-250);
        _layer.anchorPoint = CGPointMake(0.5, 0.5);
        _layer.delegate = self;
        [_layer setNeedsDisplay];
        [self.view.layer addSublayer:_layer];
    }
    return _layer;
}
 


// CALayerDelegate 代理， 调用 [layer setNeedsDisplay];会在这执行重绘，
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    // 设置蓝色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);
    // 设置边框宽度
    CGContextSetLineWidth(ctx, 20);
    // 添加一个跟层一样大的矩形到路径中
    CGContextAddRect(ctx, layer.bounds);
    // 绘制路径
    CGContextStrokePath(ctx);
}


//-(CustomLayerView*)layerView{
//    if (!_layerView) {
//        _layerView = [[CustomLayerView alloc]init];
//        _layerView.backgroundColor = color_random;
//        _layerView.bounds = CGRectMake(0, 0, 300, 300);
//        _layerView.center = CGPointMake(ScreenW/2,ScreenH-250);
//        [self.view addSubview:_layerView];
//    }
//    return _layerView;
//}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end










#pragma mark==>> view




@implementation CustomLayerView


-(void)dealloc{
    log_point_func
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/**
 图形上下文栈，自动获得，由  drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx ，方法传过来的，系统自动创建，调用
 */
- (void)drawRect:(CGRect)rect {
    NSLog(@"宽：%f  高：%f",rect.size.width,rect.size.height);
//    drawImage();
}



#pragma mark ==>> 基本绘图使用

// 网上有个第三方框架 CorePoint，专门做绘图的
void draw_test(void){
    drawLines();
    drawRect();
    drawCircle();
    drawEllipse();
    drawString();
    drawImage();
    drawDummy();
    drawBezierPath();
}

// 画线
void drawLines(void){
    
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 将当前图形上下文拷贝一份放入图形栈中
    CGContextSaveGState(ref);
    
    /* ---- 第1根线 ---- */
    
    // 设置起点
    CGContextMoveToPoint(ref, 20, 20);
    
    // 添加下一个点
    CGContextAddLineToPoint(ref, 20, 200);
    CGContextAddLineToPoint(ref, 100, 200);
    // 线宽
    CGContextSetLineWidth(ref, 3);
    // 线起点终点样式
    CGContextSetLineCap(ref, kCGLineCapRound);
    // 拐角样式
    CGContextSetLineJoin(ref, kCGLineJoinRound);
    // 线的颜色
    CGContextSetRGBStrokeColor(ref, 88/255.f, 86/255.f, 213/255.f, 1.0);
//    [[UIColor redColor] set]; // 两种方式都能设置线的颜色
    CGContextClosePath(ref); // 关闭路径(会自动连接起点和终点)
    // 渲染到view
    CGContextStrokePath(ref);
 
    
    /* ---- 清除之前上下文样式 ---- */
    CGContextRestoreGState(ref); // 将栈顶的上下文出栈，替换当前的上下文
    
    
    /* ---- 第2根线 ---- */
    
    // 设置点
    CGContextMoveToPoint(ref, 300, 20);
    CGContextAddLineToPoint(ref, 300, 200);
    CGContextAddLineToPoint(ref, 150, 200);
    // 设置线的样式
    CGContextSetLineWidth(ref, 40);
    CGContextSetLineCap(ref, kCGLineCapButt);
    CGContextSetLineJoin(ref, kCGLineJoinBevel);
    CGContextSetRGBStrokeColor(ref, 100/255.f, 48/255.f, 96/255.f, 1.0);

    // 渲染到view
    CGContextStrokePath(ref);
//    CGContextDrawPath(ref,kCGPathStroke); // 等同于上面的方法
    
}


// 画虚线
void drawDummy(void){
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 设置起点
    CGContextMoveToPoint(ref, 20, 50);
    CGContextAddLineToPoint(ref, 300, 50);
    CGContextSetLineWidth(ref, 1);
    // 设置虚线(一维数组)
    // 比如 {6,2}，代表第一段长度为6(有颜色)，第二段长度为2(无色)，后面都依次循环
    // 比如 {6,2,10,2}，代表第一段长度为6(有色)，第二段长度为2(无色)，第三段长度为10(有色)，第四段长度为2(无色)，后面都依次循环前面的值
    CGFloat length[3] = {6,3};
//    CGFloat length = 50; // 当为一个值时，有色线长度等于无色线长度
    CGContextSetLineDash(ref, 0, length, 2);
    [color_random set];
    // 渲染到view
    CGContextStrokePath(ref);
}


// 画矩形
void drawRect(void){
    
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddRect(ref, CGRectMake(20, 20, 200, 200));
    CGContextSetLineWidth(ref, 10);
    CGContextSetRGBStrokeColor(ref, 88/255.f, 86/255.f, 213/255.f, 1.0);
    CGFloat length = 10.0;
    CGContextSetLineDash(ref, 10, &length, 20);
    CGContextSetLineCap(ref, kCGLineCapRound);
    CGContextSetLineJoin(ref, kCGLineJoinRound);
    CGContextStrokePath(ref); // 渲染到view
    
}

// 画圆(圆弧)
void drawCircle(void){
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddArc(ref, 150, 150, 140, M_PI_2, M_PI, 1);
    CGContextSetLineWidth(ref, 10);
    CGContextStrokePath(ref);
}

// 画椭圆
void drawEllipse(void){
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ref, CGRectMake(20, 20, 300, 150));
    CGContextSetLineWidth(ref, 5);
    CGContextStrokePath(ref);
}

// 画字符串
void drawString(void){
    CGContextRef ref = UIGraphicsGetCurrentContext();
    NSString *str = @"哈哈哈,hellow";
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:color_random,
                              NSFontAttributeName:font_b(20)};
    [str drawInRect:CGRectMake(50, 50, 300, 30) withAttributes:attrDic];
    CGContextStrokePath(ref);
}

// 画图片
void drawImage(void){
    // 画圆
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ref, CGRectMake(20, 20, 200, 200));
    CGContextClip(ref);
    
    UIImage *image1 = [UIImage imageNamed:@"yan_wen_zi"];
    [image1 drawInRect:CGRectMake(0, 0, 300, 300)];
        
    CGContextStrokePath(ref);

//    UIImage *image2 = [UIImage imageNamed:@"wang"];
//    [image2 drawInRect:CGRectMake(255, 93, 50, 44)];
}

// 贝塞尔曲线
void drawBezierPath(void){
    CGContextRef ref = UIGraphicsGetCurrentContext();

    CGFloat cp_x = 150; // 曲线控制点的用户空间的x坐标。
    CGFloat cp_y = 60;  // 曲线控制点的用户空间的y坐标。
    
    CGFloat start_x = cp_x-50; // 起点x坐标。
    CGFloat start_y = cp_y-30; // 起点y坐标。
    
    // 起点
    CGContextMoveToPoint(ref, start_x, start_y);
    CGContextSetLineWidth(ref, 5);
    
    CGFloat end_x = cp_x+50; // 要结束曲线的用户空间的x坐标。
    CGFloat end_y = start_y;  // 要结束曲线的用户空间的y坐标。
    
    CGContextAddQuadCurveToPoint(ref, cp_x, cp_y, end_x, end_y);
    [color_random set];
    
    CGContextStrokePath(ref);

}


// 矩阵操作 CTM，具体可查看api
void drawCTM(void){
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 50, 20);
    CGContextAddLineToPoint(ref, 50, 100);
    CGContextAddLineToPoint(ref, 100, 100);
    CGContextSetLineWidth(ref, 3);

//    CGContextRotateCTM(ref, M_PI);
    // 渲染到view
    CGContextStrokePath(ref);
}



#pragma mark==>> 涂鸦
//-(NSMutableArray*)allPointAry{
//    if (!_allPointAry) {
//        _allPointAry = [NSMutableArray array];
//
//    }
//    return _allPointAry;
//}

/*
// 在这设置起点
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    NSMutableArray *mutAry = [NSMutableArray array];
    [mutAry addObject:[NSValue valueWithCGPoint:startPoint]];
    [self.allPointAry addObject:mutAry];
    [self setNeedsDisplay];
}

// 连线
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];
    NSMutableArray *mutAry = (NSMutableArray*)[self.allPointAry lastObject];
    [mutAry addObject:[NSValue valueWithCGPoint:currentPoint]];
    [self setNeedsDisplay];
}

// 连线
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:touch.view];
    NSMutableArray *mutAry = (NSMutableArray*)[self.allPointAry lastObject];
    [mutAry addObject:[NSValue valueWithCGPoint:endPoint]];
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)drawRect:(CGRect)rect {
    
//    NSLog(@"宽：%f  高：%f",rect.size.width,rect.size.height);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 10);
    
    for (int a=0; a<self.allPointAry.count; a++) {
        NSArray *pointAry = self.allPointAry[a];
        for (int i=0; i<pointAry.count; i++) {
            NSValue *ponitValue = pointAry[i];
            CGPoint point = [ponitValue CGPointValue];
            if (i==0) {
                CGContextMoveToPoint(ctx, point.x, point.y);
            }else{
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
    }
    
    CGContextStrokePath(ctx);
    
}
*/









@end







#pragma mark==>> Layer


@implementation CustomLayer

 
//-(void)drawInContext:(CGContextRef)ctx{
//    // 设置为蓝色
//    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
//    CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 200, 200));
//    // 绘制路径
//    CGContextFillPath(ctx);
//
//    // 图片再自定义layer画不出来
//    //    UIImage *image1 = [UIImage imageNamed:@"yan_wen_zi"];
//    //    CGImageRef refImg = (__bridge CGImageRef)(image1.CIImage);
//    //    CGContextDrawImage(ctx, CGRectMake(0, 0, 200, 200), refImg);
//
//}



@end



