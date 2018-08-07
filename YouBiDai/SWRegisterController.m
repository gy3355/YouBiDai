//
//  SWRegisterController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/6.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWRegisterController.h"

@interface SWRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation SWRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)setupBasic{
    GMViewBorderRadius(self.registerBtn, 5, 0, [UIColor clearColor]);
    /* 顶部按钮**/

    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"cha"] forState:0];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [rightBtn addTarget:self action:@selector(clickCloseView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}


-(void)clickCloseView{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//获取验证码
- (IBAction)getCode:(UIButton *)sender {
}
/*确认注册**/
- (IBAction)sureRegister:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //成功后调用
    UITabBarController *tab = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSNumber *idx = [tab valueForKey:@"clickIndex"];
    if (idx.integerValue>=tab.childViewControllers.count) {
        tab.selectedIndex = 0;
    }else{
        tab.selectedIndex = idx.integerValue;
    }
}
/*返回登录页**/
- (IBAction)backToLogin:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/*查看条款**/
- (IBAction)checkRule:(UIButton *)sender {
}

@end
