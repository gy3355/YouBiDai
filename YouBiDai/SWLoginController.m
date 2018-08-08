//
//  SWLoginController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/6.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWLoginController.h"
#import "SWRegisterController.h"

@interface SWLoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *passwordNum;
@property (weak, nonatomic) IBOutlet UIButton *secureSwitch;//密码明文开关

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
    
    if ([self valiMessage]) {
        [self networkWithLogin];
    }
    

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
- (IBAction)clickSecureSwitch:(UIButton *)sender {
    if (@available(iOS 10.0, *)) {
        self.passwordNum.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    } else {
        self.passwordNum.keyboardType = UIKeyboardTypeASCIICapable;
    }
    self.passwordNum.secureTextEntry = sender.isSelected;
    sender.selected = !sender.isSelected;
    
}


#pragma mark 校验用户输入数据
- (BOOL)valiMessage{
    if (![SWFunc valiMobile:self.phoneNum.text]) {
        GMMBProgreessHUD(self.view, @"非正常手机号码，请重新输入");
        return NO;
    };
    
    if (![SWFunc valiPassword:self.passwordNum.text]) {
        GMMBProgreessHUD(self.view, @"密码必须是6-20位，由字母和数字组成");
        return NO;
    };
    return YES;
}


#pragma mark 登录的网络请求
- (void)networkWithLogin{
    NSString *url = [NSString stringWithFormat:@"%@/auth/login",YouBiDaiUrl];
    NSDictionary *param = @{@"phoneNumber":self.phoneNum.text,
                            @"password":self.passwordNum.text
                            };
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功后%@",responseObject);
        DismissViewControllerWithTabbarClick;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败后%@",error);
    }];
    
    
    NSLog(@"登录");

    
}
@end
