//
//  StarReviewView.h
//  HealthDemo
//
//  Created by  on 11-11-10.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//宽度为111 ,高度为21 宽度和高度都是一定的,该View只能调整X，Y坐标。score 取值范围是0-10

#import <UIKit/UIKit.h>
#define kStarReviewViewWidth 111 
#define kStarReviewViewHeight 21 

@interface StarReviewView : UIView
{
    float score;
}
@property (nonatomic, assign) float score;
@end
