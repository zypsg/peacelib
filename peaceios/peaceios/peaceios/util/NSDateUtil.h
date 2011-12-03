//
//  NSDateUtil.h
//  peaceios
//
//  Created by  on 11-10-18.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateUtil : NSObject

+ (NSString*) currentTimeInStr;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString *)stringFromDate:(NSDate *)date;
@end
