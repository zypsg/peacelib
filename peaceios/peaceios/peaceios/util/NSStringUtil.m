//
//  NSStringUtil.m
//  peaceios
//
//  Created by  on 11-10-9.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSStringUtil

#pragma mark  ---去除字符串中的空格--- 
+ (NSString*) removeWhieSpace:(NSString*)text
{
    return  [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


//根据指定的宽度和字体，对字符串msg进行切割，返回一个字符串数组。
+ (NSArray*) divideString:(NSString*)msg WithFont:(UIFont*)font withWidth:(float) width
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSUInteger lastIdx=0;
    int totalLength = [msg length];
    CGSize size = CGSizeZero;
    for(int i= 0;i< totalLength;i++)
    {
        NSString* subString = [msg substringWithRange:NSMakeRange(lastIdx, i-lastIdx+1)];
        size = [subString sizeWithFont:font];
        if(size.width>=width)
        {
            NSString* tempString = [msg substringWithRange:NSMakeRange(lastIdx, i-lastIdx)];
            [resultArray addObject:tempString];
            lastIdx = i;
        }
        if(i== [msg length] - 1)
        {
            NSString* tempString = [msg substringFromIndex:lastIdx];
            [resultArray addObject:tempString];
        }
    }
    return [resultArray autorelease];
}
@end
