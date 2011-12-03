//
//  NSDateUtil.m
//  peaceios
//
//  Created by  on 11-10-18.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "NSDateUtil.h"

@implementation NSDateUtil

+ (NSString*) currentTimeInStr
{
    
    
    NSDateFormatter* df_local = [[[NSDateFormatter alloc] init] autorelease];
    [df_local setTimeZone:[NSTimeZone systemTimeZone]];
    [df_local setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    return  [df_local stringFromDate:[NSDate date]];
    
}



//输入的日期字符串形如：@"1992-05-21 13:08:08"

+ (NSDate *)dateFromString:(NSString *)dateString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"]; 
	NSDate *destDate= [dateFormatter dateFromString:dateString];
	[dateFormatter release];
	return destDate;
}



+ (NSString *)stringFromDate:(NSDate *)date
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
	//zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *destDateString = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	return destDateString;
}

@end
