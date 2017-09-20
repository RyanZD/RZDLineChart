//
//  RZDLineChart.h
//  RZDLineChart
//
//  Created by RyanZD on 16/5/27.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RZD.h"
#import "RZDLineChartModel.h"

@protocol RZDLineChartDelegate <NSObject>

@optional
- (void)RZDLineChartItemClick:(NSInteger )index;

@end

@interface RZDLineChart : UIView

@property (nonatomic,weak) id<RZDLineChartDelegate>delegate;

/**
 *  设置cover
 *
 *  @param frame           整个折线图的frame
 *  @param yMax            最大虚拟y
 *  @param coverLinesArray 虚拟y标度横线
 *  @param countNum        标度小数点个数 支持 0 1 2大于2算0
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame andYMax:(CGFloat )yMax andCoverLinesArray:(NSArray *)coverLinesArray andWithCountNum:(NSInteger )countNum;

/**
 *  设置scrollView
 *
 *  @param leftMargin  折线图真实范围距离cover左距离
 *  @param rightMargin 折线图真实范围距离cover右距离
 *  @param multiple    scrollView滚动距离是自身的多少倍
 */
- (void)setLeftMargin:(CGFloat)leftMargin andRightMargin:(CGFloat)rightMargin andMultiple:(CGFloat)multiple;

/**
 *  设置chart
 *
 *  @param xUnitsArray    x轴坐标单位
 *  @param linesArray     折线具体
 *  @param xUnitsLabelColor 点击对应下方label高亮色
 */
- (void)setXUnitsArray:(NSArray *)xUnitsArray andLinesArray:(NSArray *)linesArray andXUnitsLabelColor:(UIColor *)xUnitsLabelColor;

/**
 *  根据某个数组重绘lineChart
 */
- (void)redrawLineChartWithLinesArray:(NSArray *)linesArray;

@end
