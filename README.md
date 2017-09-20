# RZDLineChart
折线图控件

Easy LineChart

Use like this 

1. make lines

RZDLineChartModel *line1 = [[RZDLineChartModel alloc]init];
line1.aLineModelYs = @[@80,@0,@140];
line1.aLineModelColor = [UIColor colorWithHexString:@"#8526c2"];

RZDLineChartModel *line2 = [[RZDLineChartModel alloc]init];
line2.aLineModelYs = @[@20,@100,@60];
line2.aLineModelColor = [UIColor colorWithHexString:@"#19b48e"];

2. initial chart

RZDLineChart *chart = [[RZDLineChart alloc]initWithFrame:CGRectMake(0,100, [UIScreen mainScreen].bounds.size.width, 200) andYMax:150 andCoverLinesArray:@[@50,@100] andWithCountNum:0];
[chart setLeftMargin:21 andRightMargin:21 andMultiple:4.5];
[chart setXUnitsArray:@[@"周一18",@"周二19",@"周三20"] andLinesArray:@[line1,line2] andXUnitsLabelColor:[UIColor colorWithHexString:@"d9abff"]];
[self.view addSubview:chart];

也许还应该配置一些东西，都在config里

最后效果是这样的 

