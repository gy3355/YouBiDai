//
//  StatusNoExistBorrowView.h
//  YouBiDai
//
//  Created by 吴子源 on 2018/8/2.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BorrowJumpBlock)(void);
typedef void(^ExplainJumpBlock)(void);
typedef void(^SelectIndexBlock)(NSInteger idx);


@interface StatusNoExistBorrowView : UIView

//数据源
@property (strong,nonatomic) NSArray * dataArr;

@property (copy,nonatomic) BorrowJumpBlock borrowJump;
@property (copy,nonatomic) ExplainJumpBlock explainJump;
@property (copy,nonatomic) SelectIndexBlock selectIdx;
@end
