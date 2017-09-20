//
//  RZDLineChartCover.h
//  RZDLineChart
//
//  Created by RyanZD on 16/5/27.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZDLineChartCover : UIView

//小数点后几位
@property (nonatomic,assign,readwrite)NSInteger countNum;
//虚拟最大y
@property (nonatomic,assign,readwrite)CGFloat yMax;
//刻度线数组
@property (nonatomic,strong,readwrite)NSArray *coverLinesYArray;

@end
