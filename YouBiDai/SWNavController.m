//
//  SWNavController.m
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/1.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWNavController.h"
#import "SWFirstPageController.h"
#import "SWLoginController.h"
@interface SWNavController ()

@end

@implementation SWNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
 
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UINavigationBar *navigationBar = self.navigationBar;

    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    // 统一设置左边的返回按钮
//    UIButton *btn =[[UIButton alloc]init];
//    btn.frame = CGRectMake(0, 0, 60, 40);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [btn setImage:[UIImage imageNamed:@"fh"] forState:0];
//    [btn setImage:[UIImage imageNamed:@"back-down"] forState:UIControlStateSelected];
//    if ([viewController respondsToSelector:@selector(returnBack)]) {
//        [btn addTarget:viewController action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
//    }else{
//        [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
//    }
//    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
//    viewController.navigationItem.backBarButtonItem = back;
    
    //系统染色
//    UIBarButtonItem*btn_back = [[UIBarButtonItem alloc]init];
//    btn_back.title = @"";
//    btn_back.tintColor = GM_GaryColor;
//    viewController.navigationItem.backBarButtonItem = btn_back;
//

    //设置返回自定义样式图片
    
    UIImage *image = [UIImage imageNamed:@"fh"];

    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    buttonItem.tintColor = GM_GaryColor;
    
    viewController.navigationItem.backBarButtonItem = buttonItem;
    [[UINavigationBar appearance] setBackIndicatorImage:[[UIImage alloc]init]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage alloc] init]];

    
    
    self.navigationBarHidden = NO;
    if (self.viewControllers.count==0) {
//        viewController.navigationItem.leftBarButtonItem = nil;
        if ([viewController isKindOfClass:[SWFirstPageController class]]||[viewController isKindOfClass:[SWLoginController class]]) {
            self.navigationBarHidden = YES;
        }
    }else if (self.viewControllers.count > 0) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)returnBack{
    NSLog(@"888");
    [self popViewControllerAnimated:YES];
}
@end
