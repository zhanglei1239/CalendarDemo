//
//  MonthView.m
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//
#define MONTH_MARGIN 25
#import "MonthView.h"
#import "Months.h"
#import "DayButton.h"
#import "Days.h"
@implementation MonthView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        btnCount = 0;
        self.index = 0;
        self.currentDate = [NSDate date];
        [self createView];
    }
    return self;
}

-(void)createView{
    
    CGFloat subWidth = [UIScreen mainScreen].bounds.size.width/7;
    NSArray *arrayWeek = [NSArray arrayWithObjects:@"日", @"一",@"二",@"三",@"四",@"五",@"六",nil];
    NSMutableArray *arrayTemp = [[NSMutableArray alloc] init];
    for(int i = 0;i<7;i++)
    {
        UILabel * label = [[UILabel alloc] init];
        label.text = [arrayWeek objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(subWidth*i, 0, subWidth, subWidth/2);
        [self addSubview:label];
        if(i == 0 || i == 6)
        {
            label.textColor = [UIColor redColor];
        }
        label.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
        [arrayTemp addObject:label];
    }
    self.weekTitleArray = arrayTemp;
    
    arrayTemp = [[NSMutableArray alloc] init];
    for (int i = 0; i<6;i++) {
        for (int j = 0; j<7; j++) {
            DayButton *btn = [DayButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(subWidth*j, subWidth/2+(subWidth*2/3)*i, subWidth, subWidth*2/3);
            btn.backgroundColor = [UIColor lightGrayColor];
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0].CGColor;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.enabled = NO;
            
            [arrayTemp addObject:btn];
            
        }
    }
    self.btnArray = arrayTemp;
}
-(void)setWithDate:(Months *)m index:(NSInteger)idx{
    month = m;
    self.index = idx;
    
    for(int i = 0;i<self.btnArray.count;i++)
    {
        DayButton *btnTemp = [self.btnArray objectAtIndex:i];
        btnTemp.ulWorldDay.hidden = YES;
        btnTemp.ulChiDay.hidden = YES;
        btnTemp.ulWorldDay.textColor = [UIColor blackColor];
        btnTemp.ulChiDay.textColor = [UIColor blackColor];
        btnTemp.enabled = NO;
        btnTemp.date = nil;
        btnTemp.tag = i;
        [btnTemp setBackgroundColor:[UIColor whiteColor]];
        [btnTemp setTitle:@"" forState:UIControlStateNormal];
        btnTemp.hidden = YES;
    }
    
    Days *day = [month.daysArray objectAtIndex:0];
    
    NSInteger first = day.weekDay-1;
    for(int i = 0;i<month.daysArray.count;i++)
    {
        Days *day = [month.daysArray objectAtIndex:i];
        DayButton *btn = [self.btnArray objectAtIndex:first+i];
        btn.hidden = NO;
        btn.date = day.dayDate;
        
        btn.ulWorldDay.hidden = NO;
        btn.ulChiDay.hidden = NO;
        if([self isToday:btn.date])
        {
            btn.ulWorldDay.textColor = [UIColor colorWithRed:233.0/255.0 green:89.0/255.0 blue:17.0/255.0 alpha:1.0];
            btn.ulChiDay.textColor = [UIColor colorWithRed:233.0/255.0 green:89.0/255.0 blue:17.0/255.0 alpha:1.0];
            [btn.ulWorldDay setBackgroundColor:[UIColor redColor]];
            [btn.ulChiDay setBackgroundColor:[UIColor redColor]];
        }
        
        if(day.weekDay == 1 || day.weekDay == 7)
        {
            btn.ulWorldDay.textColor = [UIColor redColor];
            btn.ulChiDay.textColor = [UIColor redColor];
        }
        
        if([btn.date timeIntervalSinceDate:self.currentDate]<0)
        {
            btn.ulWorldDay.textColor = [UIColor grayColor];
            btn.ulChiDay.textColor = [UIColor grayColor];
        }
        
        btn.enabled = YES;
        btn.ulWorldDay.text = [NSString stringWithFormat:@"%ld",(long)day.worldDay];
        btn.ulChiDay.text = day.chiDayStr;
        if (![@"" isEqualToString:[self getCompanyName:btn.date]]) {
            btn.ulEmploy.hidden = NO;
        }
    }
}
-(NSString *)getCompanyName:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger y = [component year];
    NSInteger m = [component month];
    NSInteger d = [component day];
    NSString * key = [NSString stringWithFormat:@"%ld,%ld,%ld",(long)y,(long)m,(long)d];
    for (NSMutableDictionary * dic in self.employArray) {
        if ([dic objectForKey:key]) {
            return  [dic objectForKey:key];
        }
    }
    return @"";
}
- (void)pressBtn:(DayButton *)btn
{
    if (self.selected) {
        [self.selected setBackgroundColor:[UIColor clearColor]];
    }
    
    self.selected = btn;
    [btn setBackgroundColor:[UIColor greenColor]];

    if (_delegate && [_delegate respondsToSelector:@selector(showInfo:btn:)]) {
        [_delegate showInfo:self btn:btn];
    }
}

-(BOOL)isToday:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *component1 = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger y = [component year];
    NSInteger m = [component month];
    NSInteger d = [component day];
    
    NSInteger y1 = [component1 year];
    NSInteger m1 = [component1 month];
    NSInteger d1 = [component1 day];
    
    if (y==y1 && m == m1 && d == d1) {
        return YES;
    }
    else{
        return NO;
    }
}
@end
