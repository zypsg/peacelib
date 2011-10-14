//
//  NSLogUtil.m
//  peaceios
//
//  Created by  on 11-10-9.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "NSLogUtil.h"
@interface NSLogUtil (private)

+ (NSString*) getWriteFilePath;

@end

@implementation NSLogUtil

+ (BOOL) saveToDocuments:(NSString*)msg
{
    return  [msg writeToFile:[self getWriteFilePath] atomically:YES encoding:NSUTF8StringEncoding error:NULL];

}


+ (NSString*) getWriteFilePath
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
	return [pathname stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[NSDate date]]];
}

@end
