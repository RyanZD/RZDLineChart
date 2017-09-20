//
//  RZDLineChart.m
//  RZDLineChart
//
//  Created by RyanZD on 16/5/26.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#import "RZDLineChartConfig.h"
#import "RZDLineChartBase.h"
#import "RZDLineChartModel.h"
#import "UIColor+RZD.h"

@interface RZDLineChartBase ()

//for touch
@property (nonatomic,strong) NSMutableArray *pointRectArray;
@property (nonatomic,strong) NSMutableArray *xUnitsLabelArray;
@property (nonatomic,weak) UILabel *lastLabel;
@property (nonatomic,assign) CGFloat unitWidth;

@end

@implementation RZDLineChartBase

#pragma mark - initial

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - draw & redraw

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (RZDLineChartModel * lineChartModel in self.linesArray) {
        for (int i = 0; i < lineChartModel.aLineModelPoints.count; i++) {
            
            //draw point
            NSValue *pointValue = lineChartModel.aLineModelPoints[i];
            CGPoint point = [pointValue CGPointValue];
            CGContextAddArc(ctx, point.x, point.y, kRZDPointRadius, 0, 2 * M_PI, 0);
            [lineChartModel.aLineModelColor setFill];
            CGContextFillPath(ctx);
            
            //more area for touch
            NSDictionary *pointDict =@{
                                       @"index":[NSNumber numberWithInt:i],
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(point.x - self.unitWidth / 4, point.y - self.unitWidth / 4, self.unitWidth / 2, self.unitWidth / 2)]
                                       };
            [self.pointRectArray addObject:pointDict];
            
            //draw line 
            if(i > 0){
                
                UIBezierPath *linePath = [UIBezierPath bezierPath];
                NSValue *lastPointValue = lineChartModel.aLineModelPoints[i - 1];
                CGPoint lastPoint = [lastPointValue CGPointValue];
                //zero -> dotted line
                if(point.y == kRZDSelfHeight - kRZDXHeight || lastPoint.y == kRZDSelfHeight - kRZDXHeight){
                    CGFloat dash[] = {3,1};
                    [linePath setLineDash:dash count:2 phase:0];
                }else{
                    CGFloat dash[] = {1,0};
                    [linePath setLineDash:dash count:2 phase:0];
                }
                linePath.lineWidth = kRZDLineWidth;
                [lineChartModel.aLineModelColor setStroke];
                [linePath moveToPoint:lastPoint];
                [linePath addLineToPoint:point];
                [linePath stroke];
            }
        }
    }
}

// redraw
- (void)redrawLineChartWithLinesArray:(NSArray *)linesArray{
    
    self.linesArray = linesArray;
    [self setNeedsDisplay];
}

#pragma mark - event response

- (void)tapXUnitsLabel:(UITapGestureRecognizer *)tap{

    UILabel *currentLabel = (UILabel *)[tap view];
    
    if (self.lastLabel == currentLabel) {
        return;
    }
    
    [currentLabel setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
    [self.lastLabel setTextColor:self.xUnitsLabelColor];
    self.lastLabel = currentLabel;

    NSInteger i = [self.xUnitsLabelArray indexOfObject:currentLabel];
    if (self.delegate && [self.delegate respondsToSelector:@selector(RZDLineChartBaseItemClick:)]) {
        [self.delegate RZDLineChartBaseItemClick:i];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (NSDictionary *dict in self.pointRectArray) {
        
        NSInteger i = [dict[@"index"] integerValue];
        //prevent overlap
        if (self.lastLabel == self.xUnitsLabelArray[i]) {
            continue;
        }
        CGRect rect = [dict[@"rect"] CGRectValue];
        //if contain
        if (CGRectContainsPoint(rect, touchPoint)) {
            UILabel *currentLabel = self.xUnitsLabelArray[i];
            [currentLabel setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
            [self.lastLabel setTextColor:self.xUnitsLabelColor];
            self.lastLabel = currentLabel;
    
            if (self.delegate && [self.delegate respondsToSelector:@selector(RZDLineChartBaseItemClick:)]) {
                [self.delegate RZDLineChartBaseItemClick:i];
            }
        }
    }
}

- (void)tapMaxXUnitsLabel{

    UILabel *maxLabel = [self.xUnitsLabelArray lastObject];
    [maxLabel setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
    self.lastLabel = maxLabel;
    NSInteger i = self.xUnitsLabelArray.count - 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(RZDLineChartBaseItemClick:)]) {
        [self.delegate RZDLineChartBaseItemClick:i];
    }
}

#pragma mark - private methods

// calculate real y
- (CGFloat)getRealY:(CGFloat )y{
    
    return (kRZDSelfHeight - kRZDXHeight - (y / self.yMax * (kRZDSelfHeight - kRZDXHeight)));
}

// calculate real points
- (NSArray *)getALinePoints:(NSArray *)aLineYs{
    
    NSMutableArray *nmArray = [NSMutableArray array];
    
    for (int i = 0; i < aLineYs.count; i ++) {
        
        if (aLineYs[i] == [NSNull null]) {
            continue;
        }
        CGFloat x = i * self.unitWidth;
        CGFloat realX = x + kRZDUnitTextWidth / 2;
        CGFloat y = [aLineYs[i] floatValue];
        CGFloat realY = [self getRealY:y];
        CGPoint aPoint = CGPointMake(realX, realY);
        [nmArray addObject:[NSValue valueWithCGPoint:aPoint]];
    }
    return nmArray.copy;
}

#pragma mark - setter & getter

// x unit build
-(void)setXUnitsArray:(NSArray *)xUnitsArray{
    
    _xUnitsArray = xUnitsArray;
    
    for (int i = 0; i < xUnitsArray.count; i ++) {
        
        NSAssert([xUnitsArray[i] isKindOfClass:[NSString class]], @"this object must be string");
        
        CGFloat unitWidth = (kRZDSelfWidth - kRZDUnitTextWidth) / (xUnitsArray.count - 1);
        self.unitWidth = unitWidth;
        
        //kRZDUnitTextFont号字两行 bounding计算得出 如果要改字号或文字排布需要重新计算 更改上方的宏定义即可
        UILabel *xLabel = [[UILabel alloc]init];
        xLabel.frame = CGRectMake(i * unitWidth, kRZDSelfHeight - kRZDUnitTextHeight, kRZDUnitTextWidth, kRZDUnitTextHeight);
        xLabel.text = xUnitsArray[i];
        xLabel.font = [UIFont systemFontOfSize:kRZDUnitTextFont];
        xLabel.textColor = self.xUnitsLabelColor;
        xLabel.numberOfLines = 0;
        xLabel.textAlignment = NSTextAlignmentCenter;
        xLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapXUnitsLabel:)];
        [xLabel addGestureRecognizer:tap];
        [self addSubview:xLabel];
        
        //for click
        [self.xUnitsLabelArray addObject:xLabel];
    }
}

//linesArray build
- (void)setLinesArray:(NSArray *)linesArray{
    
    NSMutableArray *nmArray = [NSMutableArray array];
    
    for (RZDLineChartModel *lineChartModel in linesArray) {
        
        lineChartModel.aLineModelPoints = [self getALinePoints:lineChartModel.aLineModelYs];
        [nmArray addObject:lineChartModel];
    }
    _linesArray = nmArray.copy;
}

-(NSArray *)pointRectArray{
    
    if (_pointRectArray == nil) {
        _pointRectArray = [NSMutableArray array];
    }
    return _pointRectArray;
}

- (NSMutableArray *)xUnitsLabelArray{
    
    if (_xUnitsLabelArray == nil) {
        _xUnitsLabelArray = [NSMutableArray array];
    }
    return _xUnitsLabelArray;
}

@end
