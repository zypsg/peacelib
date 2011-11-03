//
//  Qaurtz2D.m
//  peaceios
//
//  Created by  on 11-11-2.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "Qaurtz2D.h"

static void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, 
                                                        (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}  

@implementation Qaurtz2D

//画渐变线条.
+ (void) drawLinearGradient:(CGContextRef)context withRect:(CGRect)rect withStartColor:(CGColorRef)startColor withEndColor:(CGColorRef)endColor
{
    drawLinearGradient(context,rect,startColor,endColor);
}
@end
