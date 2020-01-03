//
//  ViewController.m
//  SnowPlus
//
//  Created by lanou3g on 16/1/9.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "ViewController.h"
#import "PointModel.h"
static long steps;
@interface ViewController ()
@property(nonatomic,strong)CADisplayLink *gameTime;
@property(nonatomic,strong)UIImage *snowImage;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)float xx;
@property(nonatomic,assign)float yy;
@property(nonatomic,assign)float a;
@property(nonatomic,strong)CADisplayLink *gameTime2;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,assign)int count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
       self.view.backgroundColor = [UIColor blackColor];
       
       UIImageView *image = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       image.image = [UIImage imageNamed:@""];
//       image.alpha = 0.8;
       [self.view addSubview:image];
       
    [self loadData];
    steps = 0;
    self.snowImage  = [UIImage imageNamed:@"雪花.png"];
    self.gameTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
    [self.gameTime addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _xx = -2.0f;
    _yy = 1.5f;
    

        
    self.gameTime2 = [CADisplayLink displayLinkWithTarget:self selector:@selector(action2)];
    
        [self.gameTime2 addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadData{
    self.y = 300;
    
    self.data = [NSMutableArray array];
    
    for (float y = 1.5f; y > -1.5f; y -= 0.1f) {
        
        self.x = 10;
        self.y = self.y + 10;
        for (float x = -2.0f; x < 2.0f; x += 0.05f) {
            float a = x * x + y * y - 1.5;
            self.x = self.x + 5;
            if (a * a *a - x * x * y * y * y <= 0.0f ) {
                PointModel *p = [[PointModel alloc]init];
                p.x = _x;
                p.y = _y;
                [self.data addObject:p];
            }
        }
    }
    //    NSLog(@"%ld",self.data.count);
    _count = (int)self.data.count;
}

-(void)action{
//    steps++;
    if (steps%6 == 0) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.snowImage];
        [self.view addSubview:imageView];
        CGFloat r = arc4random_uniform(10)+10.0;
        [imageView setFrame:CGRectMake(0, 0, r, r)];
        CGFloat x = arc4random_uniform(self.view.frame.size.width);
        CGFloat y = -r;
        [imageView setCenter:CGPointMake(x, y)];
        
        int num = arc4random_uniform((int)self.data.count);
        PointModel *p = [[PointModel alloc]init];
        p = self.data[num];
        [self.data removeObjectAtIndex:num];
        if (self.data.count == 0) {
//            [self.gameTime removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [UIView animateWithDuration:6.0f animations:^{
            for(UIView *view in [self.view subviews])
            {
                [view removeFromSuperview];
            }
            }];
            [self loadData];
        }
        
        
        [UIView animateWithDuration:6.0f animations:^{
            [imageView setCenter:CGPointMake(p.x, p.y)];
            [imageView setTransform:CGAffineTransformMakeRotation(M_PI)];
        }];
    }
}

-(void)action2{
    steps++;
//    if (steps >_count*6) {
    
    if (steps %6 == 0) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.snowImage];
        [self.view addSubview:imageView];
        CGFloat r= arc4random_uniform(10)+10.0;
        [imageView setFrame:CGRectMake(0, 0, r, r)];
        CGFloat x = arc4random_uniform(self.view.frame.size.width);
        CGFloat y = -r;
        [imageView setCenter:CGPointMake(x, y)];
        [UIView animateWithDuration:6.0f animations:^{
            [imageView setCenter:CGPointMake(arc4random_uniform(self.view.frame.size.width), self.view.frame.size.height-100+arc4random_uniform(100))];
            [imageView setTransform:CGAffineTransformMakeRotation(M_PI)];
            [imageView setAlpha:0.2f];
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
