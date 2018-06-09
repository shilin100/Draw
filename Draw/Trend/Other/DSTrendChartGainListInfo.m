//
//  DSTrendChartGainListInfo.m
//  DSBet
//
//  Created by Selena on 2018/3/6.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSTrendChartGainListInfo.h"
#import "FEPrecompile.h"

@implementation DSTrendChartGainListInfo

-(void)parseServerData:(id)data
{
    NSDictionary * dict = objc_dynamic_cast(data, NSDictionary);
    if (dict) {
        NSString * houSan = objc_dynamic_cast(data[@"houSan"], NSString);
        if (houSan) self.houSan = houSan;
        
        NSString * qianSan = objc_dynamic_cast(data[@"qianSan"], NSString);
        if (qianSan) self.qianSan = qianSan;
        
        NSString * ticketOpenNum = objc_dynamic_cast(data[@"ticketOpenNum"], NSString);
        if (ticketOpenNum) self.ticketOpenNum = ticketOpenNum;
        
        NSString * ticketOrgOpenNum = objc_dynamic_cast(data[@"ticketOrgOpenNum"], NSString);
        if (ticketOrgOpenNum) self.ticketOrgOpenNum = ticketOrgOpenNum;
        
        NSString * ticketPlanId = objc_dynamic_cast(data[@"ticketPlanId"], NSString);
        if (ticketPlanId) self.ticketPlanId = ticketPlanId;
        
        NSString * zhongSan = objc_dynamic_cast(data[@"zhongSan"], NSString);
        if (zhongSan) self.zhongSan = zhongSan;
    }
}


@end
