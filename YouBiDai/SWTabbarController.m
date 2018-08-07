//
//  SWTabbarController.m
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/1.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWTabbarController.h"
#import "SWNavController.h"
#import "SWFirstPageController.h"
#import "SWBorrowController.h"
#import "SWMineController.h"
#import "SWLoginController.h"

@interface SWTabbarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation SWTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addChildVc:[[SWFirstPageController alloc]init] title:@"首页" navtitle:@"首页"  image:@"sy_1" selectedImage:@"sy"];

    [self addChildVc:[SWBorrowController  new] title:@"借款" navtitle:@"抵押借款" image:@"jk_1" selectedImage:@"jk"];
    
    [self addChildVc:[SWMineController  new] title:@"我" navtitle:@"我的" image:@"w_1" selectedImage:@"w"];
    

}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title navtitle:(NSString *)navtitle image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    childVc.tabBarItem.title = title;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar insertSubview:view atIndex:0];
    
    childVc.navigationItem.title =navtitle;
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    SWNavController *nav = [[SWNavController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    //是否登录
    BOOL isLogin = NO;
    if (isLogin) {
        return YES;
    }
    UIViewController *vc = viewController.childViewControllers.firstObject;
    if ([NSStringFromClass([vc class] ) isEqualToString:@"SWMineController"]) {
        SWLoginController *login = [[SWLoginController alloc]init];
        SWNavController  *nav = [[SWNavController  alloc]initWithRootViewController:login];
        [vc presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    return YES;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [tabBar.items indexOfObject:item];
    self.clickIndex = @(index);
}
@end
