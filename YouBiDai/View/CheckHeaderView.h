//
//  CheckHeaderView.h
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckHeaderView : UIView

/**
 数据传递

 @param money 借款多少钱
 @param biStr 货币的数量
 */
-(void)headerData:(NSString*)money bi:(NSString*)biStr;

@end
