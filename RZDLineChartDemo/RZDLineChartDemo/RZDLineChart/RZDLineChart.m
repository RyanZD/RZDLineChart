//
//  RZDLineChart.m
//  RZDLineChart
//
//  Created by RyanZD on 16/5/27.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import "RZDLineChart.h"
#import "RZDLineChartBase.h"
#import "RZDLineChartCover.h"

@interface RZDLineChart()<RZDLineChartBaseDelegate>

@property (nonatomic,strong) RZDLineChartCover *lineChartCover;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) RZDLineChartBase *lineChart;
@property (nonatomic,assign) CGFloat yMax;

@end

@implementation RZDLineChart

#pragma mark - initial

- (instancetype)initWithFrame:(CGRect)frame andYMax:(CGFloat )yMax andCoverLinesArray:(NSArray *)coverLinesArray andWithCountNum:(NSInteger)countNum{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.lineChartCover = [[RZDLineChartCover alloc]initWithFrame:self.bounds];
        //set
        self.lineChartCover.countNum = countNum;
        self.lineChartCover.yMax = yMax;
        self.lineChartCover.coverLinesYArray = coverLinesArray;
        [self addSubview:self.lineChartCover];
        
        self.yMax = yMax;
    }
    return self;
}

#pragma mark - public methods

- (void)setLeftMargin:(CGFloat)leftMargin andRightMargin:(CGFloat)rightMargin andMultiple:(CGFloat)multiple{

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(leftMargin, 0, self.lineChartCover.bounds.size.width - (leftMargin + rightMargin), self.lineChartCover.bounds.size.height)];
    self.scrollView.contentSize = CGSizeMake(multiple * self.scrollView.bounds.size.width, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //scroll end
    self.scrollView.contentOffset = CGPointMake((multiple - 1) * self.scrollView.bounds.size.width, 0);
    [self.lineChartCover addSubview:self.scrollView];
}

- (void)setXUnitsArray:(NSArray *)xUnitsArray andLinesArray:(NSArray *)linesArray andXUnitsLabelColor:(UIColor *)xUnitsLabelColor{

    self.lineChart = [[RZDLineChartBase alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.bounds.size.height)];
    self.lineChart.delegate = self;
    self.lineChart.yMax = self.yMax;
    self.lineChart.xUnitsLabelColor = xUnitsLabelColor;
    self.lineChart.xUnitsArray = xUnitsArray;
    self.lineChart.linesArray = linesArray;
    [self.scrollView addSubview:self.lineChart];
    // endItem tap
    [self.lineChart tapMaxXUnitsLabel];
}

// redraw
- (void)redrawLineChartWithLinesArray:(NSArray *)linesArray{

    [self.lineChart redrawLineChartWithLinesArray:linesArray];
}

#pragma mark - RZDLineChartDelegate

- (void)RZDLineChartBaseItemClick:(NSInteger)index{

    if (self.delegate && [self.delegate respondsToSelector:@selector(RZDLineChartItemClick:)]) {
        [self.delegate RZDLineChartItemClick:index];
    }
}

@end
