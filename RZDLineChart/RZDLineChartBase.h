//
//  RZDLineChart.h
//  RZDLineChart
//
//  Created by RyanZD on 16/5/26.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RZDLineChartBaseDelegate <NSObject>

@optional
- (void)RZDLineChartBaseItemClick:(NSInteger )index;

@end

@interface RZDLineChartBase : UIView

@property (nonatomic,strong) NSArray *xUnitsArray;
@property (nonatomic,assign) CGFloat yMax;
@property (nonatomic,strong) NSArray *linesArray;
@property (nonatomic,strong) UIColor *xUnitsLabelColor;
@property (nonatomic,weak) id<RZDLineChartBaseDelegate>delegate;

- (void)redrawLineChartWithLinesArray:(NSArray *)linesArray;
- (void)tapMaxXUnitsLabel;

@end
