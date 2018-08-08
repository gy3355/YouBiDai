//
//  SWFunc.h
//  YouBiDai
//
//  Created by yuan on 2018/8/7.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWFunc : NSObject


/**
 根据字符串渲染出二维码图片

 @param str 内容
 @param size 图片宽度
 @return 二维码图片
 */
+ (UIImage*)funcWithCodeImage:(NSString*)str width:(CGFloat)size;


/**
 判断手机号码格式是否正确

 @param mobile 手机号码
 @return 是否有效
 */
+ (BOOL)valiMobile:(NSString *)mobile;


#pragma mark 正则匹配用户密码6-20位数字和字母组合
/**
 用户密码6-20位数字和字母组合
 */
+ (BOOL)valiPassword:(NSString *) password;

#pragma mark 正则匹配用户姓名,20位的中文或英文
/**
 匹配用户姓名,20位的中文或英文
 */
+ (BOOL)valiUserName : (NSString *) userName;


#pragma mark 正则匹配用户身份证号15或18位
/**
 匹配用户身份证号15或18位
 */
+ (BOOL)valiUserIdCard: (NSString *) idCard;

#pragma mark 正则匹配员工号,12位的数字
/**
 匹配员工号,12位的数字
 */
+ (BOOL)valiEmployeeNumber : (NSString *) number;

#pragma mark 正则匹配URL
/**
 匹配URL
 */
+ (BOOL)valiURL : (NSString *) url;
@end
