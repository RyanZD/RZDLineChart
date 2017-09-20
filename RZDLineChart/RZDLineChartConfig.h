//
//  RZDLineChartConfig.h
//  RZDLineChart
//
//  Created by RyanZD on 16/5/27.
//  Copyright © 2016年 RyanZD. All rights reserved.
//

#ifndef RZDLineChartConfig_h
#define RZDLineChartConfig_h


//self size -- 自身size
#define kRZDSelfWidth self.bounds.size.width
#define kRZDSelfHeight self.bounds.size.height

//unitLabel size -- 单位labelsize
#define kRZDUnitTextFont 10
#define kRZDUnitTextWidth 24
#define kRZDUnitTextHeight 24

//xToTextDistance&xToBottomDistance -- x轴距离文字的高度&x轴距离底部的高度
#define kRZDXToText 5
#define kRZDXHeight (kRZDUnitTextHeight + kRZDXToText)

//linePointRadius&lineWidth -- 线节点的半径&线宽
#define kRZDPointRadius 3
#define kRZDLineWidth 1


#endif /* RZDLineChartConfig_h */
