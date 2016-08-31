//
//  ViewController.m
//  UI-02
//
//  Created by liuxingchen on 16/8/30.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *shopView;
/** 添加 */
@property(nonatomic,strong)UIButton * addBtn ;
/** 删除 */
@property(nonatomic,strong)UIButton * removeBtn ;
/** 数据源 */
@property(nonatomic,strong)NSArray * shopsArray ;
@end

@implementation ViewController

//一进来就会调用viewDidLoad方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.addBtn = [self frame:CGRectMake(50, 50, 70, 70) normalImage:@"add" highlightedImage:@"add_highlighted" disabledImage:@"add_disabled" tag:10 action:@selector(add:)];
    
    self.removeBtn = [self frame:CGRectMake(250, 50, 70, 70) normalImage:@"remove" highlightedImage:@"remove_highlighted" disabledImage:@"remove_disabled" tag:20 action:@selector(remove:)];
    self.shopsArray = @[
                        @{@"icon":@"danjianbao",
                          @"name":@"单肩包"
                            },
                        @{@"icon":@"shuangjianbao",
                          @"name":@"双肩包"
                          },
                        @{@"icon":@"qianbao",
                          @"name":@"钱包"
                          },
                        @{@"icon":@"shoutibao",
                          @"name":@"手提包"
                          },
                        @{@"icon":@"xiekuabao",
                          @"name":@"斜挎包"
                          },
                        @{@"icon":@"liantiaobao",
                          @"name":@"链条包"
                          }
                        ];
    
    [self ButtonState];
}

-(UIButton *)frame:(CGRect) frame
 normalImage:(NSString *) normalImage
highlightedImage:(NSString *) highlightedImage
disabledImage:(NSString *) disabledImage
          tag:(NSInteger) tag
       action:(SEL) action
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:disabledImage] forState:UIControlStateDisabled];
    btn.tag = tag;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

-(void)add:(UIButton *)btn;
{
    //把商品的尺寸抽成变量
    CGFloat shopW = 70;
    CGFloat shopH = 90;
    //每一行的列数
    int cols = 3;
    
    CGFloat colsMargin = (self.shopView.frame.size.width - cols * shopW)/(cols -1);
    NSUInteger index = self.shopView.subviews.count;
    
    NSUInteger col = index % cols;
    CGFloat shopX = col *(colsMargin +shopW);
    
    
    CGFloat rowMargin = 10;
    
    NSUInteger row = index / cols;
    CGFloat shopY  = row *(rowMargin + shopH);
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(shopX, shopY, shopW, shopH)];
    view.backgroundColor = [UIColor redColor];
    [self.shopView addSubview:view];
    
    NSDictionary *dict = self.shopsArray[index];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shopW, shopW)];
    imageView.image = [UIImage imageNamed:dict[@"icon"]];
    [view addSubview:imageView];
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(0, shopW, shopW, shopH-shopW)];
    label.text = dict[@"name"];
    
    //设置字体大小
    label.font = [UIFont systemFontOfSize:13];
    //设置字体居中
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blueColor];
    [view addSubview:label];
    [self ButtonState];
}
-(void)remove:(UIButton *)btn;
{
    
    [self.shopView.subviews.lastObject removeFromSuperview];
    [self ButtonState];
}
-(void)ButtonState
{
    // 删除按钮什么时候可以点击：商品个数 > 0
    self.removeBtn.enabled = (self.shopView.subviews.count > 0);
    // 添加按钮什么时候可以点击：商品个数 < 总数
    self.addBtn.enabled  = (self.shopView.subviews.count < self.shopsArray.count);
    
}
@end
