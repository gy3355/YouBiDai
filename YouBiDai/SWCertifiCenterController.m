//
//  SWCertifiCenterController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/7.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWCertifiCenterController.h"

@interface SWCertifiCenterController ()
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SWCertifiCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMViewBorderRadius(self.sureBtn, 5, 0, [UIColor clearColor]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
