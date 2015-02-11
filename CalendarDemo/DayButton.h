//
//  DayButton.h
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayButton : UIButton
@property (nonatomic,retain) NSDate * date;
@property (nonatomic,retain) UILabel * ulChiDay;
@property (nonatomic,retain) UILabel * ulWorldDay;
@property (nonatomic,retain) UILabel * ulEmploy;
@end
