//
//  RZDLineChartModel.h
//  RZDLineChart
//
//  Created by RyanZD on 16/5/26.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZDLineChartModel : NSObject

//y Array -> Virtual
@property (nonatomic,strong) NSArray *aLineModelYs;

//line color
@property (nonatomic,strong) UIColor *aLineModelColor;

@property (nonatomic,strong) NSArray *aLineModelPoints;

@end
