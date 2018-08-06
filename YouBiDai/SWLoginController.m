//
//  SWLoginController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/6.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWLoginController.h"
#import "SWRegisterController.h"

@interface SWLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation SWLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMViewBorderRadius(self.loginBtn, 5, 0, [UIColor clearColor]);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
/*关闭视图**/
- (IBAction)clickCloseView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*登录**/
- (IBAction)login:(UIButton *)sender {
    
}

/*注册**/
- (IBAction)clickRegister:(UIButton *)sender {
    [self.navigationController pushViewController:[SWRegisterController new] animated:YES];
}
/*重设密码**/
- (IBAction)resetPassword:(UIButton *)sender {
    
}

/*查看条款**/
- (IBAction)checkRule:(UIButton *)sender {
    
}

@end
