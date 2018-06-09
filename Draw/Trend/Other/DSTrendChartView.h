//
//  DSTrendChartView.h
//  DSBet
//
//  Created by Selena on 2018/3/6.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSView.h"

@interface DSTrendChartView : DSView

@property (nonatomic, assign) NSInteger ticketId;

- (void)updateViewWithData:(NSObject *)data;

@end
