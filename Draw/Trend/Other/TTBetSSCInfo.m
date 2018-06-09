//
//  TTBetSSCInfo.m
//  DSBet
//
//  Created by 黄文豹 on 18/4/26.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "TTBetSSCInfo.h"
#import "DSTrendChartGainListInfo.h"

#define IS_DICTIONARY(obj)  ([obj isKindOfClass:[NSDictionary class]])
#define IS_ARRAY(obj)       ([obj isKindOfClass:[NSArray class]])

@implementation TTBetSSCInfo
/*
 list: [ 开奖列表
 {
 id: "121889",
 issue: "613300", 期号
 kjtime: "1492587720", 开奖时间
 kjhm: { 开奖号码
 n1: "9", 号码1
 n2: "3", 号码2
 n3: "1", 号码3
 n4: "5",
 n5: "4"
 },
 */
- (void)parseServerData:(id)data
{
    if (IS_DICTIONARY(data)) {
        
        id list = data[@"data"][@"list"];
        if (IS_ARRAY(list)){
            NSArray *arr = list;
            
            NSMutableArray *array = [NSMutableArray array];
            
            NSInteger num = arr.count > 20 ? 20 : arr.count;
            
            for (NSInteger i = 0; i < num; i ++) {
                
                NSDictionary *dict = arr[i][@"kjhm"];
                
                DSTrendChartGainListInfo *listinfo = [DSTrendChartGainListInfo new];
                
                NSString *str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",dict[@"n1"],dict[@"n2"],dict[@"n3"],dict[@"n4"],dict[@"n5"]];
                
                listinfo.ticketPlanId = arr[i][@"issue"];
                listinfo.ticketOpenNum = str;
                
                [array addObject:listinfo];
            }
            
            self.kjhms = array;
        }
        
    }
}
@end
