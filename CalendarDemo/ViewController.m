//
//  ViewController.m
//  CalendarDemo
//
//  Created by highcom on 15-2-10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ViewController.h"
#import "Days.h"
#import "Months.h"
#import "MonthView.h"
#import "EmployTip.h"
#import "EmployInfoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [topView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    
    self.uLtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.view addSubview:self.uLtitle];
    [self.uLtitle setTextAlignment:NSTextAlignmentCenter];
    
    self.uScalendar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-60)] ;
    [self.view addSubview:self.uScalendar];
    [self.uScalendar setPagingEnabled:YES];
    self.uScalendar.delegate = self;
    [self.uScalendar setBackgroundColor:[UIColor clearColor]];
    
    [self initData];
    
    [self initScrollView];
}

-(void)initScrollView{
    int count = 0;
    for (Months * month in self.dateArr) {
        MonthView * mView = [[MonthView alloc] initWithFrame:CGRectMake(count*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-60)];
        mView.delegate = self;
        mView.employArray = self.employArr;
        [mView setWithDate:month index:count];
        [self.uScalendar addSubview:mView];
        [self.viewArr addObject:mView];
        count++;
    }
    [self.uScalendar setContentSize:CGSizeMake((count+1)*[UIScreen mainScreen].bounds.size.width, self.uScalendar.frame.size.height)];
}

-(void)initData{
    self.dateArr = [self createDateArr];
    self.viewArr = [NSMutableArray array];
    self.employArr = [self createEmployArr];
}

-(NSMutableArray *)createEmployArr{
    NSMutableArray * temp= [NSMutableArray array];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"黑龙江海康软件工程有限公司" forKey:@"2015,2,10"];
    [temp addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"北京南北xx科技股份有限公司" forKey:@"2015,2,24"];
    [temp addObject:dic];
    return temp;
}

-(NSMutableArray *)createDateArr{
    NSMutableArray * temp = [NSMutableArray array];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger totalDays = 0;
    NSDate * begin = [NSDate date];
    NSDate * end = [NSDate dateWithTimeInterval:63072000 sinceDate:begin];
    CGFloat deviceVersion = [[UIDevice currentDevice].systemVersion floatValue];
    NSInteger flag = 0;
    if(deviceVersion>=8.0)
    {
        flag = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday|NSCalendarUnitDay;
    }
    else
    {
        flag = NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
    }
    NSDateComponents * components = [calendar components:flag fromDate:begin];
    NSInteger beginYear = [components year];
    NSInteger beginMonth = [components month];
    NSInteger beginDay = [components day];
    
    totalDays = beginDay-1;
    NSDate *dateFirst = [NSDate dateWithTimeInterval:-86400*totalDays sinceDate:begin];
    totalDays = 0;
    NSDateComponents *componentLast = [calendar components:flag fromDate:end];
    NSInteger endYear = [componentLast year];
    NSInteger endMonth = [componentLast month];
    
    for (NSInteger i = beginYear; i<=endYear; i++) {
        if (i == beginYear) {
            for (NSInteger m = beginMonth; m<=12; m++) {
                Months * month = [[Months alloc] init];
                month.worldYear = i;
                month.worldMoth = m;
                month.daysCount = [self dayOfMonth:i and:m];
                NSMutableArray *arrayDaysTemp = [[NSMutableArray alloc] init];
                for(NSInteger k = 1;k<=month.daysCount;k++)
                {
                    Days *day = [[Days alloc] init];
                    
                    NSDate *date = [NSDate dateWithTimeInterval:86400*totalDays sinceDate:dateFirst];
                    totalDays++;
                    day.weekDay = [self weekDayWithDate:date];
                    day.worldDay = [self worldDayWithDate:date];
                    day.dayDate = date;
                    day.chiDay = [self chiDayWithDate:date];
                    day.chiDayStr = [self getDayFromChiDay:day.chiDay];
                    if(day.chiDay == 1)
                    {
                        day.chiDayStr = [self getMonthFromChiMonth:[self chiMonthWithDate:date]];
                    }
                    [arrayDaysTemp addObject:day];
                    
                }
                
                month.daysArray = arrayDaysTemp;
                [temp addObject:month];
                
            }
        }else if(i == endYear){
            for (NSInteger m = 1; m<=endMonth; m++) {
                Months * month = [[Months alloc] init];
                month.worldYear = i;
                month.worldMoth = m;
                month.daysCount = [self dayOfMonth:i and:m];
                NSMutableArray *arrayDaysTemp = [[NSMutableArray alloc] init];
                for(NSInteger k = 1;k<=month.daysCount;k++)
                {
                    Days *day = [[Days alloc] init];
                    
                    NSDate *date = [NSDate dateWithTimeInterval:86400*totalDays sinceDate:dateFirst];
                    totalDays++;
                    day.weekDay = [self weekDayWithDate:date];
                    day.worldDay = [self worldDayWithDate:date];
                    day.dayDate = date;
                    day.chiDay = [self chiDayWithDate:date];
                    day.chiDayStr = [self getDayFromChiDay:day.chiDay];
                    if(day.chiDay == 1)
                    {
                        day.chiDayStr = [self getMonthFromChiMonth:[self chiMonthWithDate:date]];
                    }
                    [arrayDaysTemp addObject:day];
                    
                }
                
                month.daysArray = arrayDaysTemp;
                [temp addObject:month];
                
            }
        }else{
            for (NSInteger m = 1; m<=12; m++) {
                Months * month = [[Months alloc] init];
                month.worldYear = i;
                month.worldMoth = m;
                month.daysCount = [self dayOfMonth:i and:m];
                NSMutableArray *arrayDaysTemp = [[NSMutableArray alloc] init];
                for(NSInteger k = 1;k<=month.daysCount;k++)
                {
                    Days *day = [[Days alloc] init];
                    
                    NSDate *date = [NSDate dateWithTimeInterval:86400*totalDays sinceDate:dateFirst];
                    totalDays++;
                    day.weekDay = [self weekDayWithDate:date];
                    day.worldDay = [self worldDayWithDate:date];
                    day.dayDate = date;
                    day.chiDay = [self chiDayWithDate:date];
                    day.chiDayStr = [self getDayFromChiDay:day.chiDay];
                    if(day.chiDay == 1)
                    {
                        day.chiDayStr = [self getMonthFromChiMonth:[self chiMonthWithDate:date]];
                    }
                    [arrayDaysTemp addObject:day];
                    
                }
                
                month.daysArray = arrayDaysTemp;
                [temp addObject:month];
                
            }
        }
    }
    
    
    return temp;
}


-(NSInteger) dayOfMonth:(NSInteger) year and:(NSInteger) imonth
{
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if(year%4==0 && year%100!=0)
        return 29;
    
    if(year%400 == 0)
        return 29;
    
    return 28;
}

- (NSString *)getMonthFromChiMonth:(NSInteger)month
{
    NSArray *arrayTemp = [NSArray arrayWithObjects:
                          @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                          @"九月", @"十月", @"冬月", @"腊月", nil];
    NSString *str = nil;
    for(int i = 0;i<arrayTemp.count;i++)
    {
        if(month-1 == i)
        {
            str = [arrayTemp objectAtIndex:i];
            break;
        }
    }
    
    return str;
    
}

- (NSString *)getDayFromChiDay:(NSInteger)day
{
    NSArray *arrayTemp = [NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    NSString *str = nil;
    for(int i = 0;i<arrayTemp.count;i++)
    {
        if(day-1 == i)
        {
            str = [arrayTemp objectAtIndex:i];
            break;
        }
    }
    
    return str;
    
}
- (NSDateComponents *)getCalendarComponents:(NSString *)identifier andDate:(NSDate *)date
{
    NSInteger flagChi = 0;
    NSInteger flag = 0;
    float deviceVersion = 0;
    
    if(deviceVersion>=8.0)
    {
        flagChi = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay;
        flag = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday|NSCalendarUnitDay;
    }
    else
    {
        flagChi = NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit;
        flag = NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
    }
    
    
    
    NSDateComponents *component = nil;
    if([identifier isEqualToString:NSCalendarIdentifierChinese])
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
        component = [calendar components:flagChi fromDate:date];
    }
    else
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        component = [calendar components:flag fromDate:date];
    }
    
    return component;
}

- (NSInteger)chiDayWithDate:(NSDate *)date
{
    
    NSDateComponents *component = [self getCalendarComponents:NSCalendarIdentifierChinese andDate:date];
    
    NSInteger chiDay = [component day];
    
    return chiDay;
}


- (NSInteger)chiMonthWithDate:(NSDate *)date
{
    
    NSDateComponents *component = [self getCalendarComponents:NSCalendarIdentifierChinese andDate:date];
    
    NSInteger chiMonth = [component month];
    
    return chiMonth;
}
- (NSInteger)weekDayWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSInteger weekDayTemp = [component weekday];
    
    return weekDayTemp;
}

- (NSInteger)worldDayWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay fromDate:date];
    
    NSInteger day = [component day];
    
    return day;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;//根据坐标算页数
    
    Months * mon= [self.dateArr objectAtIndex:page];
    NSString *str1 = [NSString stringWithFormat:@"%ld",(long)mon.worldYear];
    NSString *str2 = [NSString stringWithFormat:@"%ld",(long)mon.worldMoth];
    NSString *strLong = [NSString stringWithFormat:@"%@年%@月",str1,str2];
    [self.uLtitle setText:[NSString stringWithFormat:@"%@",strLong]];
    MonthView * view = [self.viewArr objectAtIndex:page];
    [view.selected setBackgroundColor:[UIColor clearColor]];
    view.selected = nil;
    if (self.tip) {
        [self.tip removeFromSuperview];
        self.tip = nil;
    }
}

-(void)showInfo:(MonthView *)view btn:(DayButton *)button{
    
    NSString * name = [self getCompanyName:button.date];
    if (self.tip) {
        [self.tip removeFromSuperview];
        self.tip = nil;
    }
    if (![@"" isEqualToString:name]) {
        CGFloat x = view.frame.origin.x+self.uScalendar.frame.origin.x+button.frame.origin.x;
        CGFloat y = view.frame.origin.y+self.uScalendar.frame.origin.y+button.frame.origin.y;
        self.tip = [[EmployTip alloc] initWithFrame:CGRectMake(x+20, y-20, 120, 30)];
        self.tip.mview = view;
        self.tip.delegate = self;
        [self.tip createView];
        [self.tip setBackgroundColor:[UIColor clearColor]];
        [self.tip setWithName:[NSString stringWithFormat:@"%@,点击查看详情",name]];
        [self.view addSubview:self.tip];
        [self.view bringSubviewToFront:self.tip];
    }
}

-(void)showEmploy{
    if (self.tip) {
        [self.tip removeFromSuperview];
        self.tip = nil;
    }
    EmployInfoViewController * controller = [[EmployInfoViewController alloc] init];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(NSString *)getCompanyName:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger year = [component year];
    NSInteger month = [component month];
    NSInteger day = [component day];
    NSString * key = [NSString stringWithFormat:@"%ld,%ld,%ld",(long)year,(long)month,(long)day];
    for (NSMutableDictionary * dic in self.employArr) {
        if ([dic objectForKey:key]) {
            return  [dic objectForKey:key];
        }
    }
    return @"";
}
@end
