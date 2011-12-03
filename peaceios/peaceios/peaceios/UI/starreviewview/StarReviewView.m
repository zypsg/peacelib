//
//  StarReviewView.m
//  HealthDemo
//
//  Created by  on 11-11-10.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "StarReviewView.h"


@implementation StarReviewView
@synthesize score;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void) setScore:(float)ascore
{
    score = ascore;
    [self setNeedsDisplay];
}
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //以下为画星星
    
    UIImage* starImgLight = [UIImage imageNamed:@"xing-hight.png"];
    UIImage* starImgGray = [UIImage imageNamed:@"xing.png"];
    
    float starNum = MIN(score, 10.0)/2;
    
    
    float xOrigin = 10,yOrigin = 3;
    int count = 0;
    while (starNum>1.0) {
        [starImgLight drawAtPoint:CGPointMake(xOrigin, yOrigin)];
        xOrigin+=(starImgLight.size.width+5);
        starNum --;
        count++;
    }
    
    int grayX = xOrigin;
    for(int i= count;i<5;i++)
    {
        [starImgGray drawAtPoint:CGPointMake(grayX, yOrigin)];
        grayX+=(starImgGray.size.width +5);
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if(starNum>0.0&&starNum<1.0)
    {
        //        [starImgGray drawAtPoint:CGPointMake(xOrigin, 10)];
        CGContextSaveGState(ctx);
        CGContextAddRect(ctx, CGRectMake(xOrigin,  yOrigin, starImgLight.size.width*starNum, starImgLight.size.height));
        
        CGContextClosePath(ctx);
        CGContextClip(ctx);
        
        [starImgLight drawAtPoint:CGPointMake(xOrigin, yOrigin)];
        CGContextRestoreGState(ctx);
    }
    
    yOrigin+=(starImgGray.size.height+3);
    //以上为画星星
}
 

@end
