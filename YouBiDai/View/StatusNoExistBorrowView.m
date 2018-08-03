//
//  StatusNoExistBorrowView.m
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/2.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "StatusNoExistBorrowView.h"

@interface StatusNoExistBorrowView ()
@property (weak, nonatomic) IBOutlet UIButton *BorrowBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation StatusNoExistBorrowView



-(void)layoutSubviews{
    GMViewBorderRadius(self.BorrowBtn, 5, 0, [UIColor clearColor]);
}

-(void)setDataArr:(NSArray *)dataArr{
    
    if (dataArr.count==0) {
        return;
    }
    CGFloat edge = 10;
    CGFloat btnW = 85;
    CGFloat btnH = 70;
    CGFloat maxW = SCREEN_W - 80;
    
    
    CGFloat btnsMaxW = dataArr.count*btnW+edge*(dataArr.count-1);
    CGFloat x= (maxW-btnsMaxW)/2 >0?(maxW-btnsMaxW)/2:0;
    NSInteger num = 0;

    for (NSString *str in dataArr) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, btnW, btnH)];
        
        [btn setTitle:str forState:0];
        [btn setTitleColor:GM_BlackColor forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:23.0];
        btn.tag = num;
        num++;
        [btn addTarget:self action:@selector(clickIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        x = x+edge+btnW;
        [self.scrollView addSubview:btn];
    }
    if (btnsMaxW<maxW) {
        self.scrollView.contentSize = CGSizeMake(maxW, btnH);
    }else self.scrollView.contentSize = CGSizeMake(btnsMaxW, btnH);
}


- (IBAction)clickExplain:(UIButton *)sender {
    NSLog(@"说明");
    if (self.explainJump) {
        self.explainJump();
    }
    
}

- (IBAction)clickBorrow:(UIButton *)sender {
    NSLog(@"跳转借款");
    if (self.borrowJump) {
        self.borrowJump();
    }

    
}

-(void)clickIndex:(UIButton*)sender{
    
    if (self.selectIdx) {
        self.selectIdx(sender.tag);
    }
}

@end
