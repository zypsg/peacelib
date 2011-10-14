//
//  ImageUtil.m
//  peaceios
//
//  Created by  on 11-10-14.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil


//生成自定义图片，支持retina屏幕。
- (UIImage*) getImageWithWidth:(float) width withHeight:(float) height
{
 
    UIScreen* screen = [UIScreen mainScreen];
    
    if([screen respondsToSelector:@selector(scale)])
    {
        width *= screen.scale;
        height *= screen.scale;
    }
 
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef =  CGBitmapContextCreate(NULL,
                                                     width,
                                                     height,
                                                     8,
                                                     4 *  width,
                                                     colorSpace,
                                                     kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextSetFillColorWithColor(contextRef,[[UIColor grayColor] CGColor] );
    CGContextFillRect(contextRef, CGRectMake(0, 0,  width,  height));
    
    
    // Drawing with a white stroke color
	CGContextSetRGBStrokeColor(contextRef, 0.0, 0.0, 0.0, 1.0);
	// And draw with a blue fill color
	CGContextSetRGBFillColor(contextRef, 0.0, 0.0, 0.0, 1.0);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(contextRef, 2.0);
    
    // Fill rect convenience equivalent to AddEllipseInRect(); FillPath();
    
	
    
   
    
    
    CGImageRef ref = CGBitmapContextCreateImage(contextRef);
    
    
    UIImage* img = nil;
    if([screen respondsToSelector:@selector(scale)])
    {
        img = [UIImage imageWithCGImage:ref scale:screen.scale orientation:UIImageOrientationUp];
    }
    else
    {
        img = [UIImage imageWithCGImage:ref];
    }
    
    CGImageRelease(ref);
    UIGraphicsPopContext();
    return img;
}


@end
