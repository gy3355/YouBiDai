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
@property (weak, nonatomic) IBOutlet UILabel *daysLab;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

//主要显示
@property (weak, nonatomic) IBOutlet UICountingLabel *mainContent;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
    GMViewBorderRadius(self.applyBtn, 5, 0, [UIColor clearColor]);
    
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderScroll)];
    
    
    
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

    self.mainContent.method = UILabelCountingMethodEaseIn;
    //设置格式
    self.mainContent.format = @"%f";
    //设置变化范围及动画时间
    [self.mainContent countFrom:0.00
                         to:(sender.value)
               withDuration:1.5f];
    
   
    
    
    NSInteger index = round(sender.value);
    NSLog(@"%lf--%ld",sender.value,index);
    sender.value = index;
    self.daysLab.text = [NSString stringWithFormat:@"%ld天",7+index];
    
    
    
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

#pragma mark 头部刷新
-(void)refreshHeaderScroll{
    NSLog(@"刷新成功");
    [self.scrollView.mj_header endRefreshing];
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
