//
//  BigAreaButton.m
//  icheckup
//
//  Created by  on 11-12-16.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "BigAreaButton.h"


@implementation BigAreaButton
@synthesize touchOffset;

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    if(fabs(touchOffset)<=0.01)
    {
        touchOffset = 5.0f;
    }
    CGRect rect = CGRectMake(-touchOffset, -touchOffset, self.bounds.size.width+touchOffset*2, self.bounds.size.height+touchOffset*2);
    
    if (CGRectContainsPoint(rect, point))
        return YES;
    else
        return NO;
}
@end
