//
//  SWPayBController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWPayBController.h"

@interface SWPayBController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImage;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (weak, nonatomic) IBOutlet UIButton *addressCopyBtn;
@property (weak, nonatomic) IBOutlet UIButton *readyBtn;

@end

@implementation SWPayBController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
}

- (void)setupBasic{
    self.navigationItem.title = @"充币";
}

- (IBAction)addressCopy:(UIButton *)sender {

    GMMBProgreessHUD(self.view, @"复制成功！");
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *str = self.addressLab.text.length==0?@"":self.addressLab.text;
    pasteboard.string = str;

}


- (IBAction)readyNext:(UIButton *)sender {
    
}

@end
