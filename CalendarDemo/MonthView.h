//
//  MonthView.h
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Months.h"
#import "DayButton.h"
@interface MonthView : UIView{
    NSInteger btnCount;
    Months * month;
}
@property (nonatomic,retain) NSMutableArray * weekTitleArray;
@property (nonatomic,retain) NSMutableArray * btnArray;
@property (nonatomic,retain) NSDate * currentDate;
@property (nonatomic,retain) NSDate * date;
@property (nonatomic,retain) UIView * selected;
@property (nonatomic,assign) id delegate;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,retain) NSMutableArray * employArray;
-(void)setWithDate:(Months *)m index:(NSInteger)idx;
-(void)createView;
@end
@protocol showInfo <NSObject>

-(void)showInfo:(MonthView *)view btn:(DayButton *)button;

@end