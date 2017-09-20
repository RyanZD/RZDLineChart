//
//  ViewController.m
//  RZDLineChartDemo
//
//  Created by 张锐 on 2017/9/20.
//  Copyright © 2017年 zhangr. All rights reserved.
//

#import "ViewController.h"
#import "RZDLineChart.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) RZDLineChart *chart;

@property (nonatomic,strong) NSArray *linesArray;

@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.textLabel];
    
    RZDLineChart *chart = [[RZDLineChart alloc]initWithFrame:CGRectMake(0,100, [UIScreen mainScreen].bounds.size.width, 200) andYMax:150 andCoverLinesArray:@[@50,@100] andWithCountNum:0];
    [chart setLeftMargin:21 andRightMargin:21 andMultiple:4.5];
    [chart setXUnitsArray:@[@"周一18",@"周二19",@"周三20"] andLinesArray:self.linesArray andXUnitsLabelColor:[UIColor colorWithHexString:@"d9abff"]];
    [self.view addSubview:chart];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.bgImageView.frame = CGRectMake(0,100, [UIScreen mainScreen].bounds.size.width, 200);
    self.textLabel.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 300);
}

#pragma mark - setters & getters

- (UIImageView *)bgImageView{

    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    }
    return _bgImageView;
}

- (NSArray *)linesArray{

    if (_linesArray == nil) {
        RZDLineChartModel *line1 = [[RZDLineChartModel alloc]init];
        line1.aLineModelYs = @[@80,@0,@140];
        line1.aLineModelColor = [UIColor colorWithHexString:@"#8526c2"];
        RZDLineChartModel *line2 = [[RZDLineChartModel alloc]init];
        line2.aLineModelYs = @[@20,@100,@60];
        line2.aLineModelColor = [UIColor colorWithHexString:@"#19b48e"];
        RZDLineChartModel *line3 = [[RZDLineChartModel alloc]init];
        line3.aLineModelYs = @[@120,@70,@0];
        line3.aLineModelColor = [UIColor colorWithHexString:@"#4b60f4"];
        _linesArray = @[line1,line2,line3];
    }
    return _linesArray;
}

- (UILabel *)textLabel{

    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:22];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = @"RZDLineChart";
    }
    return _textLabel;
}

@end
