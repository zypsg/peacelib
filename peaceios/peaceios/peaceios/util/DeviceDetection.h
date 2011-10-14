//
//  DeviceDetection.m
//  HealthDemo
//
//  Created by  on 11-9-30.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

enum {
    MODEL_UNKNOWN,
    MODEL_IPHONE_SIMULATOR,
    MODEL_IPOD_TOUCH,
    MODEL_IPOD_TOUCH_2G,
    MODEL_IPOD_TOUCH_3G,
    MODEL_IPOD_TOUCH_4G,
    MODEL_IPHONE,
    MODEL_IPHONE_3G,
    MODEL_IPHONE_3GS,
    MODEL_IPHONE_4G,
    MODEL_IPAD
};

@interface DeviceDetection : NSObject

+ (uint) detectDevice;
+ (int) detectModel;

+ (NSString *) returnDeviceName:(BOOL)ignoreSimulator;
+ (BOOL) isIPodTouch;
+ (BOOL) canSendSms;

+ (BOOL) isIphone4;

+ (BOOL) isIphone;

+ (BOOL) isIpad;

+ (BOOL) isItouch;

+ (BOOL) hasMicrophone;

+ (BOOL) hasFlash;
@end