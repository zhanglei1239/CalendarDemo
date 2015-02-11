//
//  ViewController.h
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployTip.h"
@interface ViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,retain) UIScrollView * uScalendar;
@property (nonatomic,retain) UILabel * uLtitle;
@property (nonatomic,retain) NSMutableArray * dateArr;
@property (nonatomic,retain) NSMutableArray * viewArr;
@property (nonatomic,retain) NSMutableArray * employArr;
@property (nonatomic,retain) EmployTip * tip;
@end

