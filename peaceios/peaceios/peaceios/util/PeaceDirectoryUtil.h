//
//  PeaceDirectoryUtil.h
//  peaceios
//
//  Created by  on 11-11-2.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeaceDirectoryUtil : NSObject
{
}

+(NSString*) documentPath;
+(NSString*) cachePath;
+(NSString*) tempPath;
@end
