//
//  SWCheckDetailController.h
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWCheckDetailController : UIViewController


/**
 格式样例@[
 @[@"手续费",@"900元"],
 @[@"优惠券",@"50元"],
 @[@"到账金额",@"19000元"],
 @[@"质押币种",@"BTC"],
 @[@"质押数量",@"0.005元"],
 @[@"借款时间",@"2018-08-01"],
 @[@"借款期限",@"15天"],
 @[@"2W",@"1BTC"],
 ];
 */
@property (nonatomic,strong)NSArray *dataArr;
@end
