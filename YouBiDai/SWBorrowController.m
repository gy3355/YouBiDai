//
//  SWBorrowController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/3.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWBorrowController.h"
#import "SWCheckDetailController.h"

@interface SWBorrowController ()<DYO_PickViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *tipsBtn;
@property (weak, nonatomic) IBOutlet UIButton *certifiBtn;
@property (weak, nonatomic) IBOutlet UIButton *bType;


@property (strong,nonatomic)DYO_PickView *pickView;

@end

@implementation SWBorrowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 顶部按钮**/
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [rightBtn setTitle:@"借款记录" forState:0];
    rightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
    [rightBtn setTitleColor:GM_GaryColor forState:0];
    [rightBtn addTarget:self action:@selector(clickBorrowRecord) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

#pragma mark 交互
/*借款记录**/
-(void)clickBorrowRecord {
    NSLog(@"借款记录");
}

/*前往认证**/
- (IBAction)clickCertifi:(UIButton *)sender {
}

/*选择币种**/
- (IBAction)selectBtype:(UIButton *)sender {
    [self.pickView showWith:@[@[@"BTC",@"GTC",@"ETH",@"DGKX",@"XETH"]] list:1];
    
}
- (IBAction)selectDate:(UISlider *)sender {
    
    NSInteger index = round(sender.value);
    NSLog(@"%lf--%ld",sender.value,index);
    sender.value = index;
}

/* 申请借款确认**/
- (IBAction)applyForBorrow:(UIButton *)sender {
    SWCheckDetailController *check = [SWCheckDetailController new];
    check.dataArr = @[@[@"手续费",@"900元"],
                      @[@"优惠券",@"50元"],
                      @[@"到账金额",@"19000元"],
                      @[@"质押币种",@"BTC"],
                      @[@"质押数量",@"0.005元"],
                      @[@"借款时间",@"2018-08-01"],
                      @[@"借款期限",@"15天"],
                      @[@"2W",@"1BTC"],
                      ];
    [self.navigationController pushViewController:check animated:YES];
    
}

#pragma mark 懒加载
- (DYO_PickView *)pickView{
    if (!_pickView) {
        _pickView = [DYO_PickView defaultPick];
        _pickView.delegate = self;
    }
    return _pickView;
}

#pragma mark delegate

-(void)pickViewdidSelect:(NSString *)selectStr{
    NSLog(@"%@",selectStr);
    [self.bType setTitle:selectStr forState:0];
}
@end
