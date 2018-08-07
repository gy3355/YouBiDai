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

@end
