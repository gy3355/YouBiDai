//
//  SWFirstPageController.m
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/1.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWFirstPageController.h"
#import "StatusNoExistBorrowView.h"
#import "StatusExistBorrowView.h"

typedef enum : NSUInteger {
    BorrowTypeNone,
    BorrowTypeOne,
    BorrowTypeMore,
} BorrowType;

@interface SWFirstPageController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) StatusExistBorrowView *existView;
@property (strong,nonatomic) StatusNoExistBorrowView *noExistView;

@property (strong,nonatomic) UIView *headerView;
@property (strong,nonatomic) UIScrollView * adScrollView;
@property (strong,nonatomic) UIView * statusView;



@end

@implementation SWFirstPageController

#define ADScrollViewH SCREEN_W*32/75



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupNetWork];
}


- (void)setupBasic{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -GMStatusBarHeight, SCREEN_W,SCREEN_H ) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    
}

/* HeaderView **/
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, ADScrollViewH)];
        [_headerView addSubview:self.adScrollView];
        [_headerView addSubview:self.statusView];
        /* 顶部按钮**/
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_headerView.width-100, GMStatusBarHeight, 80, 30)];
        [rightBtn setTitle:@"抵押规则" forState:0];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:0];
        [rightBtn addTarget:self action:@selector(clickRule) forControlEvents:UIControlEventTouchUpInside];
        [_headerView insertSubview:rightBtn aboveSubview:_adScrollView];
    }
    return _headerView;
}
/* 表头--AD轮播**/
- (UIScrollView *)adScrollView{
    if (!_adScrollView) {
        _adScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_W, ADScrollViewH)];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:_adScrollView.bounds];
        imageV.image = [UIImage imageNamed:@"bg"];
        [_adScrollView addSubview:imageV];
        _adScrollView.contentSize = CGSizeMake(SCREEN_W, ADScrollViewH);
    }
    return _adScrollView;
}

/* 表头--币种选择及个人贷款**/
- (UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_adScrollView.frame), SCREEN_W, 300)];
    }
    return _statusView;
}


//看数据显示已贷款还是未贷款界面
-(void)setupStatusView{
    BOOL isExistBorrow = YES;
    if (isExistBorrow) {
        self.existView = [[NSBundle mainBundle]loadNibNamed:@"StatusExistBorrowView" owner:nil options:nil].firstObject;
        self.existView.frame = self.statusView.bounds;
        self.existView.y = 0;
        self.existView.dataDic = @{@"dd":@2};
        

//        [self.existView setBorrowJump:^{
//            NSLog(@"外面跳转借款");
//        }];

        [self.statusView addSubview:self.existView];
    }else{
        self.noExistView = [[NSBundle mainBundle]loadNibNamed:@"StatusNoExistBorrowView" owner:nil options:nil].firstObject;
        
        self.noExistView.frame = self.statusView.bounds;
        self.noExistView.y = 0;
        self.noExistView.dataArr = @[@"BTC",@"ETH",@"GTC",@"KDG",@"GYLX",@"GDDQA",@"XQC",@"RDC"];
        [self.noExistView setBorrowJump:^{
            NSLog(@"外面跳转借款");
        }];
        [self.noExistView setExplainJump:^{
            NSLog(@"外面跳转说明");
        }];
        [self.noExistView setSelectIdx:^(NSInteger idx) {
            NSLog(@"选择%ld",idx);
        }];
        [self.statusView addSubview:self.noExistView];
    }
    
   
    
}

#pragma  mark 交互
- (void)clickRule{
    NSLog(@"进入抵押规则");
}

- (void)setupRefreshUI{
    //更新轮播
    
    //更新状态视图
    [self setupStatusView];
    
    
}
#pragma mark 头部刷新
-(void)refreshHeader{
    NSLog(@"刷新成功");
    [self.tableView.mj_header endRefreshing];
}

#pragma mark tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark Network-----

-(void)setupNetWork{
    NSDictionary *data = @{
                           @"ad":@"bg",
                           @"detail":@[]
                           };
    [self setupRefreshUI];
    
}

@end
