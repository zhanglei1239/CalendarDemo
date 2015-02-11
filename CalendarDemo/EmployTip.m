//
//  EmployTip.m
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "EmployTip.h"
#import "MonthView.h"
@implementation EmployTip

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 120, 30)];
    if (self) {
    }
    return self;
}

-(void)setWithName:(NSString *)n{
    self.name = n;
    [btnEntry setTitle:self.name forState:UIControlStateNormal];
    [btnEntry setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)createView{
    btnEntry = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 116, 26)];
    [btnEntry setBackgroundColor:[UIColor whiteColor]];
    [btnEntry.layer setMasksToBounds:YES];
    [btnEntry.layer setCornerRadius:2];
    [btnEntry.layer setBorderWidth:.5];
    [btnEntry.layer setBorderColor:[UIColor blackColor].CGColor];
    [btnEntry.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btnEntry.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [btnEntry.titleLabel setNumberOfLines:2];
    [btnEntry addTarget:self action:@selector(showEmploy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnEntry];
}

-(void)showEmploy:(UIButton *)btn{
    [self.mview.selected setBackgroundColor:[UIColor clearColor]];
    if (_delegate && [_delegate respondsToSelector:@selector(showEmploy)]) {
        [_delegate showEmploy];
        
    }
}

@end
