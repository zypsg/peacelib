//
//  UITitleButton.m
//  HealthDemo
//
//  Created by  on 11-12-3.
//  Copyright (c) 2011年 瓦力. All rights reserved.
//

#import "UITitleButton.h"

@implementation UITitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) addCustomTitleLabel
{
    if(customTitleLabel == nil)
    {
        if(self.frame.size.height>30)
        {
            customTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-30)/2, self.frame.size.width,30 )];
        }
        else
        {
            customTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        }
        customTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:customTitleLabel];
        [customTitleLabel release];
        
        customTitleLabel.textAlignment = UITextAlignmentCenter;
    }
    customTitleLabel.text = [self titleForState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self addCustomTitleLabel];
    
}

@end
