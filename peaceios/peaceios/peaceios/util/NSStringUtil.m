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

@end
