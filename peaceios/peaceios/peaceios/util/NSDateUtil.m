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

@end
