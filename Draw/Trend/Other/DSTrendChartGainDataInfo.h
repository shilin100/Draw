//
//  DSTrendChartGainDataInfo.h
//  DSBet
//
//  Created by Selena on 2018/3/6.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSDataObject.h"
#import "FEPrecompile.h"

@interface DSTrendChartGainDataInfo : DSDataObject

PROPERTY_STRONG NSString *missingData;
PROPERTY_STRONG NSArray *openedList;
PROPERTY_ASSIGN NSInteger rowCount;

@property (nonatomic, assign) NSUInteger tikectId;

@property (nonatomic, assign) NSUInteger startIndex;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger pageCount;


//@property (nonatomic, assign, readonly) NSUInteger startIndex;
//@property (nonatomic, assign, readonly) NSUInteger pageSize;
//@property (nonatomic, assign, readonly) NSUInteger pageCount;

@property (nonatomic, strong) NSArray *missingArray;
@property (nonatomic, strong) NSArray *censuesArray;


- (void)initData;

@end
