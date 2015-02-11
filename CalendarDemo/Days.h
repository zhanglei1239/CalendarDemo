//
//  Days.h
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Days : NSObject
//公历日期
@property (nonatomic,assign) NSInteger worldDay;
//农历日期
@property (nonatomic,assign) NSInteger chiDay;
//周日期
@property (nonatomic,assign) NSInteger weekDay;
//节日和农历每月开始
@property (nonatomic,strong) NSString *chiDayStr;
//当日的日期格式数据
@property (nonatomic,strong) NSDate *dayDate;
@end
