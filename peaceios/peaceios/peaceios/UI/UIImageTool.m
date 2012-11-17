//
//  UIImageTool.m
//  peaceios
//
//  Created by  on 11-12-10.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "UIImageTool.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageTool

//得到某个UIView对应的image
+ (UIImage*) getImageForView:(UIView*) view
{
    UIImage* img;
    UIGraphicsBeginImageContext( view.layer.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    return img;
}

@end
