//
//  UITitleButton.h
//  HealthDemo
//
//  Created by  on 11-12-3.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//
// 通常的UIButton不能同时支持设置image和title。本自定义的UITitleButton可以同时支持自定义image和title。
#import <UIKit/UIKit.h>

@interface UITitleButton : UIButton
{
    UILabel* customTitleLabel;
}

- (void) addCustomTitleLabel;
@end
