//
//  BigAreaButton.h
//  icheckup
//
//  Created by  on 11-12-16.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//
//默认UIButton的按键响应区域是该button的bounds 范围。如果需要扩大UIButton按键响应区域，请使用本类。


#import <UIKit/UIKit.h>

@interface BigAreaButton : UIButton
{
    float touchOffset;
}
@property (nonatomic,assign) float touchOffset;
@end
