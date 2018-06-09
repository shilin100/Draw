//
//  CXSSQModel.h
//  Lottery
//
//  Created by Traveler on 2018/5/1.
//  Copyright © 2018年 Traveler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSSQModel : NSObject

@property (nonatomic, copy) NSString *type; //类型（双色球）
@property (nonatomic, copy) NSString *expect; //期号
@property (nonatomic, copy) NSString *opencode; //开奖号
@property (nonatomic, copy) NSString *opentime;//开奖时间
/*
 "expect":"2018049",
 "opencode":"01,03,04,11,19,23+02",
 "opentime":"2018-05-01 21:18:20",
 "opentimestamp":1525180700
 
 */

@end
