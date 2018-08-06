//
//  SWMineController.m
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/1.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWMineController.h"
#import "SWLoginController.h"
#import "SWNavController.h"

@interface SWMineController ()

@end

@implementation SWMineController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];
}

-(void)setupBasic{
    /* 顶部按钮**/
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"lw_2"] forState:0];
    [leftBtn addTarget:self action:@selector(clickGift) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"sz"] forState:0];
    [rightBtn addTarget:self action:@selector(clickSetting) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}
/**
 视图点击

 @param sender view
 */
- (IBAction)tapViewIndex:(UITapGestureRecognizer *)sender {
    NSLog(@"%ld",sender.view.tag);
    switch (sender.view.tag) {
        case 0:
            //个人资料->暂时转登录
        {
            SWNavController *nav = [[SWNavController alloc]initWithRootViewController:[SWLoginController new]];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
            
            
            break;
            
        default:
            break;
    }
    
}
//点击优惠券
-(void)clickGift{
    
}
//点击设置
-(void)clickSetting{
    
}


@end
