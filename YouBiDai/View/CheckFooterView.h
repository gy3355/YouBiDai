//
//  CheckFooterView.h
//  YouBiDai
//
//  Created by yuan on 2018/8/4.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureJumpBlock)(void);
typedef void(^DelegateJumpBlock)(void);


@interface CheckFooterView : UIView


@property (copy,nonatomic) SureJumpBlock sureJump;
@property (copy,nonatomic) DelegateJumpBlock delegateJump;

/**
 传递数值：你需要X天后，还款X元

 @param days 天数
 @param money 还款金额
 */
-(void)footerData:(NSString*)days money:(NSString*)money;
@end
