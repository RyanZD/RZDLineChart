//
//  RZDLineChartCover.m
//  RZDLineChart
//
//  Created by RyanZD on 16/5/27.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import "RZDLineChartConfig.h"
#import "RZDLineChartCover.h"
#import "UIColor+RZD.h"

@interface RZDLineChartCover ()

@property (nonatomic,strong,readwrite)NSArray *realYArray;

@end

@implementation RZDLineChartCover

#pragma mark - initial

- (instancetype )initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - draw

- (void )drawRect:(CGRect)rect {
    
    //x
    float baseY = [self p_getRealY:0];
    UIBezierPath *realYPath = [UIBezierPath bezierPath];
    [realYPath moveToPoint:CGPointMake(0, baseY)];
    [realYPath addLineToPoint:CGPointMake(self.bounds.size.width, baseY)];
    [realYPath setLineWidth:0.5];
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4]setStroke];
    [realYPath stroke];
    
    for (NSNumber *realYNum in self.realYArray) {
        
        CGFloat realY = [realYNum floatValue];
        
        UIBezierPath *realYPath = [UIBezierPath bezierPath];
        [realYPath moveToPoint:CGPointMake(0, realY)];
        [realYPath addLineToPoint:CGPointMake(self.bounds.size.width, realY)];
        [realYPath setLineWidth:0.5];
        [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4]setStroke];
        [realYPath stroke];
    }
}

#pragma mark - private methods

// calculate real y
- (CGFloat )p_getRealY:(CGFloat )y{
    
    return (kRZDSelfHeight - kRZDXHeight - (y / self.yMax * (kRZDSelfHeight - kRZDXHeight)));
}

#pragma mark - setter & getter

- (void )setCoverLinesYArray:(NSArray *)coverLinesYArray{

    _coverLinesYArray = coverLinesYArray;

    NSMutableArray *nmArray = [NSMutableArray array];
    for (NSNumber *y in coverLinesYArray) {
        
        CGFloat realY = [self p_getRealY:[y floatValue]];
        [nmArray addObject:[NSNumber numberWithFloat:realY]];
        
        NSString *Str;
        switch (self.countNum) {
            case 0:
                Str = [NSString stringWithFormat:@"%.f",[y floatValue]];
                break;
            case 1:
                Str = [NSString stringWithFormat:@"%.1f",[y floatValue]];
                break;
            case 2:
                Str = [NSString stringWithFormat:@"%.2f",[y floatValue]];
                break;
            default:
                Str = [NSString stringWithFormat:@"%.f",[y floatValue]];
                break;
        }
        
        //y unit
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - 36, realY - 13, 31, 13)];
        label.text = Str;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:label];
    }
    self.realYArray = nmArray.copy;
}

@end
