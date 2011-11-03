//
//  Qaurtz2D.h
//  peaceios
//
//  Created by  on 11-11-2.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Qaurtz2D : NSObject
{
}

+ (void) drawLinearGradient:(CGContextRef)context withRect:(CGRect)rect withStartColor:(CGColorRef)startColor withEndColor:(CGColorRef)endColor;
@end
