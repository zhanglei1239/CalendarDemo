//
//  DayButton.m
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "DayButton.h"

@implementation DayButton

+ (id)buttonWithType:(UIButtonType)buttonType
{
    DayButton *btn = [super buttonWithType:buttonType];
     CGFloat subWidth = [UIScreen mainScreen].bounds.size.width/7;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, subWidth, subWidth/3)];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:[btn titleFont]];
    label.hidden = YES;
    [btn addSubview:label];
    btn.ulWorldDay = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, subWidth/3, subWidth, subWidth/3)];
    label.hidden = YES;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:[btn titleFont]*3/4];
    [btn addSubview:label];
    btn.ulChiDay = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(subWidth*2/3+2, 1, 12, 12)];
    label.hidden = YES;
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:6];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderWidth = .5;
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.font = [UIFont systemFontOfSize:[btn titleFont]*2/3];
    [label setText:@"招"];
    [btn addSubview:label];
    btn.ulEmploy = label;
    return btn;
}

- (CGFloat)titleFont
{
    CGFloat widthTemp = [UIScreen mainScreen].bounds.size.width;
    CGFloat fontTemp = 0;
    if(widthTemp<=320)
    {
        fontTemp = 12;
    }
    else if(widthTemp<=375)
    {
        fontTemp = 14;
    }
    else
    {
        fontTemp = 16;
    }
    
    return fontTemp;
    
}

- (void)layoutSubviewsr
{
    self.ulWorldDay.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2);
    self.ulChiDay.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
}
@end
