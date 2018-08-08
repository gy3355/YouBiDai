//
//  SWRegisterController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/6.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWRegisterController.h"

@interface SWRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn; //注册按钮
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;//获取验证码控件


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *getCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (nonatomic,strong)NSString *codeStr;//临时保存验证码

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
- (IBAction)clickSecureSwitch:(UIButton *)sender {
    if (@available(iOS 10.0, *)) {
        self.passwordTF.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    } else {
        self.passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
    }
    self.passwordTF.secureTextEntry = sender.isSelected;
    sender.selected = !sender.isSelected;
}
/*确认注册**/
- (IBAction)sureRegister:(UIButton *)sender {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    //成功后调用
//    UITabBarController *tab = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    NSNumber *idx = [tab valueForKey:@"clickIndex"];
//    if (idx.integerValue>=tab.childViewControllers.count) {
//        tab.selectedIndex = 0;
//    }else{
//        tab.selectedIndex = idx.integerValue;
//    }
    
    if ([self valiMessage]) {
        [self networkWithRegister];
    }
}
/*返回登录页**/
- (IBAction)backToLogin:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/*查看条款**/
- (IBAction)checkRule:(UIButton *)sender {
}


#pragma mark 校验用户输入数据
- (BOOL)valiMessage{
    if (![SWFunc valiMobile:self.phoneTF.text]) {
        GMMBProgreessHUD(self.view, @"非正常手机号码，请重新输入");
        return NO;
    };
    if ([self.getCodeTF.text isEqualToString:self.codeStr]) {
        GMMBProgreessHUD(self.view, @"验证码有误，请重新输入");
        return NO;
    }
    
    if (![SWFunc valiPassword:self.passwordTF.text]) {
        GMMBProgreessHUD(self.view, @"密码必须是6-20位，由字母和数字组成");
        return NO;
    };
    return YES;
}

#pragma mark network 网络请求
-(void)networkWithRegister{
    NSString *registerUrl = [NSString stringWithFormat:@"%@/user",YouBiDaiUrl];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:registerUrl parameters:@{@"phoneNumber":self.phoneTF.text,@"captcha":self.getCodeTF,@"password":self.passwordTF.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功后%@",responseObject);
        GMMBProgreessHUD(self.view, responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败后%@",error);
    }];
}

//获取验证码
-(void)networkWithCode{
    NSString *codeUrl = [NSString stringWithFormat:@"%@/sms/register?phoneNumber=%@",YouBiDaiUrl,self.phoneTF.text];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:codeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功后%@",responseObject);
        self.codeStr = responseObject[@"data"];
        GMMBProgreessHUD(self.view, responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败后%@",error);
    }];

    
}
@end
