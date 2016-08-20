//
//  ViewController.m
//  lighttest
//
//  Created by noveltek on 2016/4/21.
//  Copyright © 2016年 noveltek. All rights reserved.
//
//跑馬燈功能 顯示一條紅色的
#import "ViewController.h"

#pragma mark - Class define variable
#define K_MAIN_VIEW_SCROLL_HEIGHT 35.0f //包圍文字高度
#define K_MAIN_VIEW_SCROLL_TEXT_TAG 300
#define K_MAIN_VIEW_TEME_INTERVAL 0.02         //计时器间隔时间(单位秒)
#define K_MAIN_VIEW_SCROLLER_SPACE 10          //每次移动的距离
#define K_MAIN_VIEW_SCROLLER_LABLE_WIDTH  1000  //字体宽度
#define K_MAIN_VIEW_SCROLLER_LABLE_MARGIN 0   //前后间隔距离
#define ENABLE_color 1

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Class property
@synthesize arrData;

- (void)viewDidLoad {
         [super viewDidLoad];
    
         [self initView];
     }

- (void)didReceiveMemoryWarning {
         [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
     }

#pragma mark - Custom method
//初始化数据
-(void) initView{
#if ENABLE_color

         if (!self.arrData) {
             self.arrData = @[@{@"newsTitle" : @"██████████████████████████████████"},
                              @{@"newsTitle" :@"██████████████████████████████████"},
                              @{@"newsTitle" :@"██████████████████████████████████"}];

         }
#else
    if (!self.arrData) {
        self.arrData = @[@{@"newsTitle" : @"hi"},
                         @{@"newsTitle" :@"hello"},
                         @{@"newsTitle" :@"123"}];
        
    }
#endif
         //文字滚动
         [self initScrollText];
    
         //开启滚动
         [self startScroll];
     }


//文字滚动初始化
-(void) initScrollText{
    
         //获取滚动条
         scrollViewText = (UIScrollView *)[self.view viewWithTag:K_MAIN_VIEW_SCROLL_TEXT_TAG];
         if(!scrollViewText){
                 scrollViewText = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, K_MAIN_VIEW_SCROLL_HEIGHT)];
                 scrollViewText.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
                 scrollViewText.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
                 scrollViewText.tag = K_MAIN_VIEW_SCROLL_TEXT_TAG;
                 [scrollViewText setBackgroundColor:[UIColor grayColor]];
        
                 //清除子控件
                 for (UIView *view in [scrollViewText subviews]) {
                         [view removeFromSuperview];
                     }
        
                 //添加到当前视图
                 [self.view addSubview:scrollViewText];
             }
    
    
         if (self.arrData) {
        
                 CGFloat offsetX = 0 ,i = 0, h = 40;
        
                 //设置滚动文字
                 UILabel *labText = nil;
                 for (NSDictionary *dicTemp in self.arrData) {
                         labText = [[UILabel alloc] initWithFrame:CGRectMake(i * (K_MAIN_VIEW_SCROLLER_LABLE_WIDTH + K_MAIN_VIEW_SCROLLER_LABLE_MARGIN),
                                                                             (K_MAIN_VIEW_SCROLL_HEIGHT - h) / 2,K_MAIN_VIEW_SCROLLER_LABLE_WIDTH,h)];
                         [labText setFont:[UIFont systemFontOfSize:30]]; //跑馬燈文字大小
                         [labText setTextColor:[UIColor redColor]]; // 跑馬燈顏色
                         labText.text = dicTemp[@"newsTitle"];
                         offsetX += labText.frame.origin.x;
            
                         //添加到滚动视图
                         [scrollViewText addSubview:labText];
            
                         i++;
                     }
             
                 //设置滚动区域大小
                 [scrollViewText setContentSize:CGSizeMake(offsetX, 0)];
             }
     }

//开始滚动
-(void) startScroll{
     
         if (!timer)
                 timer = [NSTimer scheduledTimerWithTimeInterval:K_MAIN_VIEW_TEME_INTERVAL target:self selector:@selector(setScrollText) userInfo:nil repeats:YES];
     
         [timer fire];
     }


 //滚动处理
 -(void) setScrollText{
     
         CGFloat startX = scrollViewText.contentSize.width - K_MAIN_VIEW_SCROLLER_LABLE_WIDTH - K_MAIN_VIEW_SCROLLER_LABLE_MARGIN;
     
         [UIView animateWithDuration:K_MAIN_VIEW_TEME_INTERVAL * 2 animations:^{
                 CGRect rect;
                 CGFloat offsetX = 0.0;
             
                 for (UILabel *lab in scrollViewText.subviews) {
                     
                         rect = lab.frame;
                         offsetX = rect.origin.x - K_MAIN_VIEW_SCROLLER_SPACE;
                         if (offsetX < -K_MAIN_VIEW_SCROLLER_LABLE_WIDTH)
                                 offsetX = startX;
                     
                         lab.frame = CGRectMake(offsetX, rect.origin.y, rect.size.width, rect.size.height);
                     }
             
                 NSLog(@"offsetX:%f",offsetX);
             
             }];
     
     }

 @end
