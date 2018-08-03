//
//  StatusExistBorrowView.m
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/2.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "StatusExistBorrowView.h"

@interface StatusExistBorrowView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHH;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


/*  DetailView  **/
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *pledgeObj;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;//代还金额
@property (weak, nonatomic) IBOutlet UILabel *pledgeMoney;//抵押物价值
@property (weak, nonatomic) IBOutlet UILabel *warningLine;//警戒线

@property (weak, nonatomic) IBOutlet UILabel *forceLine;//平仓线

@property (weak, nonatomic) IBOutlet UIImageView *warnImage;



@end

@implementation StatusExistBorrowView

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setDataDic:(NSDictionary *)dataDic{
    //拥有多个借贷的时候
    NSInteger num = 3;
    self.pageControl.numberOfPages = num;
    self.pageControl.currentPage = 0;
    
    for (NSInteger i=0; i<num; i++) {
        StatusExistBorrowView *detailV = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
        detailV.frame = CGRectMake(SCREEN_W*i, 0, SCREEN_W, 250);
        detailV.pledgeMoney.text = [NSString stringWithFormat:@"%ld0000元",i];
        [self.scrollView addSubview:detailV];
    }
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_W*num, 290);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    // round四舍五入
    NSInteger index = round(point.x/scrollView.frame.size.width);
    self.pageControl.currentPage = index;

}

@end
