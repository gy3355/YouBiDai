//
//  SWCheckDetailController.m
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "SWCheckDetailController.h"
#import "CheckHeaderView.h"
#import "CheckFooterView.h"


@interface SWCheckDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SWCheckDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    
}

-(void)setupBasic{
    self.navigationItem.title = @"借款确认";
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GM_GaryLColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self setupHeadTableView];
        [self setupFootTableView];
    }
    return _tableView;
}

-(void)setupHeadTableView{
    CheckHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"CheckHeaderView" owner:nil options:nil].firstObject;
    [headerView headerData:[self.dataArr.lastObject  firstObject] bi:[self.dataArr.lastObject  lastObject]];
    _tableView.tableHeaderView = headerView;
}

-(void)setupFootTableView{
    CheckFooterView *footerView = [[NSBundle mainBundle]loadNibNamed:@"CheckFooterView" owner:nil options:nil].firstObject;
    [footerView footerData:@"15" money:@"20000"];
    _tableView.tableFooterView = footerView;
    [footerView setSureJump:^{
        NSLog(@"不够币需要跳转充页面");
        NSString *b = @"BTC";
        NSString *title = [NSString stringWithFormat:@"您的%@数量不足，请前往充币",b];
        [self showAlertViewWithTitle:title leftT:@"取消" rightT:@"充币"];
        
    }];
    [footerView setDelegateJump:^{
        NSLog(@"跳转查看协议");
    }];
}

#pragma  mark delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count-1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
    }
    NSArray *arr = self.dataArr[indexPath.row];
    cell.textLabel.text = arr.firstObject;
    cell.detailTextLabel.text = arr.lastObject;
    
    cell.textLabel.textColor = GM_GaryMColor;
    cell.detailTextLabel.textColor = GM_BlackColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

-(void)showAlertViewWithTitle:(NSString*)title leftT:(NSString*)leftT rightT:(NSString*)rightT{
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAct = [UIAlertAction actionWithTitle:leftT style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtl addAction:leftAct];
    UIAlertAction *rightAct = [UIAlertAction actionWithTitle:rightT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtl addAction:rightAct];
    [self presentViewController:alertCtl animated:YES completion:nil];
    
    
}
@end

