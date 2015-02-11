//
//  EmployTip.h
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthView;
@interface EmployTip : UIView{
    UIButton * btnEntry;
    BOOL isshow;
}
@property (nonatomic,retain) NSString * name;
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) MonthView * mview;
-(void)setWithName:(NSString *)n;
-(void)createView;
@end

@protocol showEmployDelegate <NSObject>

-(void)showEmploy;

@end