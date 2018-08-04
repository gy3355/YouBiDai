//
//  CheckFooterView.m
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "CheckFooterView.h"
@interface CheckFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *delegateLab;


@end

@implementation CheckFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)footerData:(NSString*)days money:(NSString*)money{
    self.backgroundColor = GM_GaryLColor;
    [self sureBtnWithEnabled:NO];
    /*温馨提示语**/
    NSString *totalStr = [NSString stringWithFormat:@"您需要%@天后,还款%@元",days,money];
    NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc]initWithString:totalStr];
    [mutAtt addAttribute:NSForegroundColorAttributeName value:GM_BlueColor range:NSMakeRange(3, days.length)];
    [mutAtt addAttribute:NSForegroundColorAttributeName value:GM_BlueColor range:NSMakeRange(totalStr.length-1-money.length, money.length)];
    self.tipsLab.attributedText = mutAtt;
    
    /*确认按钮**/
    GMViewBorderRadius(self.sureBtn, 5, 0, [UIColor clearColor]);
    
    /*选中按钮  --  协议**/
    NSString *targetStr = @"《抵押借款协议》";
    NSString *delegateStr = [NSString stringWithFormat:@"已阅读并同意%@",targetStr];
    NSMutableAttributedString *mutAttDelegate = [[NSMutableAttributedString alloc]initWithString:delegateStr];
    [mutAttDelegate addAttribute:NSForegroundColorAttributeName value:GM_BlueColor range:NSMakeRange(delegateStr.length-targetStr.length, targetStr.length)];
    self.delegateLab.titleLabel.attributedText = mutAttDelegate;
}

#pragma mark 点击交互
/*确认按钮点击**/
- (IBAction)clickSureBtn:(UIButton *)sender {
    if (self.sureJump) {
        self.sureJump();
    }
}

/*选中按钮点击**/
- (IBAction)clickSelectBtn:(UIButton*)sender {
    sender.selected = !sender.isSelected;
    [self sureBtnWithEnabled:sender.isSelected];

}

/*协议按钮点击**/
- (IBAction)clickDelegate:(UIButton *)sender {
    if (self.delegateJump) {
        self.delegateJump();
    }

}


-(void)sureBtnWithEnabled:(BOOL)enabled{
    if (enabled) {
        //勾上协议
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];
        self.sureBtn.backgroundColor = GM_BlueColor;
    }else{
        [self.sureBtn setTitleColor:GM_GaryLColor forState:0];
        self.sureBtn.backgroundColor = GM_GaryMColor;
    }
    self.sureBtn.enabled = enabled;
}

@end
