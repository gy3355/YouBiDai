//
//  CheckHeaderView.m
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "CheckHeaderView.h"

@interface CheckHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;

@end

@implementation CheckHeaderView



- (void)headerData:(NSString *)money bi:(NSString*)biStr{
    self.backgroundColor = GM_GaryLColor;
    NSString *totalStr = [NSString stringWithFormat:@"借款%@需要 %@",money,biStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:totalStr];
    [attStr addAttributes:@{
                            NSFontAttributeName:[UIFont systemFontOfSize:35]
                            } range:NSMakeRange(totalStr.length-biStr.length, biStr.length)];
    self.headerTitle.attributedText = attStr;
}

@end
