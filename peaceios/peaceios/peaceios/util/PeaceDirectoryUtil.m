//
//  PeaceDirectoryUtil.m
//  peaceios
//
//  Created by  on 11-11-2.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "PeaceDirectoryUtil.h"

@implementation PeaceDirectoryUtil


+(NSString*) documentPath
{
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myPath    = [myPathList  objectAtIndex:0];
    return myPath;
}
+(NSString*) cachePath
{
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *myPath    = [myPathList  objectAtIndex:0];
    return  myPath;
}
+(NSString*) tempPath
{
    return  NSTemporaryDirectory();
}


@end
