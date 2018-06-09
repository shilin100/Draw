//
//  DSTrendChartGainDataInfo.m
//  DSBet
//
//  Created by Selena on 2018/3/6.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSTrendChartGainDataInfo.h"
#import "DSTrendChartGainListInfo.h"

#define IS_STRING(obj)      ([obj isKindOfClass:[NSString class]])


@implementation DSTrendChartGainDataInfo

-(void)parseServerData:(id)data
{
    if(IS_STRING(data)){
        NSString *BetStr = (NSString *)data;
        NSArray *list = [BetStr componentsSeparatedByString:@","];
        if(list.count > 0){
            self.missingData = @"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
            NSMutableArray *listArray = [NSMutableArray new];
            for(NSString *betStr in list){
                NSArray *listStr = [betStr componentsSeparatedByString:@"|"];
                if(listStr.count > 0){
                    DSTrendChartGainListInfo *info = [DSTrendChartGainListInfo new];
                    NSString *strList = [listStr objectAtIndex:1];
                    NSMutableString *muStr = [NSMutableString new];
                    if(strList.length == 5 || strList.length == 3){
                        for(NSInteger i = 0; i < strList.length; i ++){
                            NSString *str = [strList substringWithRange:NSMakeRange(i, 1)];
                            [muStr appendString:str];
                            [muStr appendString:@","];
                        }
                    }else{
                        for(NSInteger i = 0; i < strList.length/2; i ++){
                            NSString *str = [strList substringWithRange:NSMakeRange(i * 2, 2)];
                            [muStr appendString:str];
                            [muStr appendString:@","];
                        }
                    }
                    NSString *ticketOpenNum = [muStr substringToIndex:(muStr.length - 1)];
                    info.ticketOpenNum = ticketOpenNum;
                    info.ticketPlanId = [listStr objectAtIndex:0];
                    [listArray addObject:info];
                }
            }
            self.openedList = listArray;
            self.rowCount = listArray.count;
        }
        [self initData];
    }

}

- (void)initData
{
    self.missingArray = [self missingArray];
    self.censuesArray = [self censuesArray];
}


- (void)setTikectId:(NSUInteger)tikectId
{
    _tikectId = tikectId;

    DSTrendChartGainListInfo *info = [self.openedList objectAtIndex:0];
    
    NSArray *numberArray = [info.ticketOpenNum componentsSeparatedByString:@","];
    _pageCount = numberArray.count;
    
    switch (tikectId) {
        case 11:// 重庆时时彩
        case 151:// 新疆时时彩
        case 119:// 夏威夷分分彩
        case 161:
        case 191:
        case 51:
        case 601:
        case 811:
        case 911:
        case 46:
            
        case 200:
        case 201:
        case 202:
        case 203:
        case 6:
        case 205:
        case 206:
        case 711:
            
            
        case 31:
        case 32:
        case 33:
        case 35:
        case 36:
            
        case 42:
        {
            _startIndex = 0;
            _pageSize = 10;
            break;
        }
            
        case 24:// 广东11选5
        case 21://槟城11选5
        case 23:
        case 22:
        case 26:
        case 28:
        {// 江西11选5
            self.missingData = @"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
            _startIndex = 1;
            _pageSize = 11;
            break;
        }
            
        case 41: {// 亿贝3D分分彩
            _startIndex = 0;
            _pageSize = 10;
            break;
        }
        case 204:
        case 43: {// 北京PK拾
            self.missingData = @"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
            _startIndex = 1;
            _pageSize = 10;
            break;
        }
            
        case 19:// 亿贝秒秒彩
        case 20: {// 老虎机秒秒彩
        default:
            _startIndex = 0;
            _pageSize = 10;
            break;
        }
    }
}

- (NSArray *)censuesArray
{
    if (_censuesArray == nil) {
        NSMutableArray *censuesArray = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < 4; i++) {
            NSMutableArray *censuesList = [NSMutableArray array];
            [censuesArray addObject:censuesList];
            
            for (NSUInteger j = 0; j < self.pageCount; j++) {
                NSMutableArray *censuesPage = [NSMutableArray array];
                [censuesList addObject:censuesPage];
                
                for (NSUInteger k = self.startIndex; k < self.pageSize + self.startIndex; k++) {
                    
                    //出现总次数
                    if (i == 0) {
                        
                        NSInteger totalAppearCount = 0;
                        
                        for (NSUInteger x = 0; x < self.missingArray.count; x++) {
                            NSArray *missList = [self.missingArray objectAtIndex:x];
                            NSArray *missPage = [missList objectAtIndex:j];
                            NSString *rewardText = [missPage objectAtIndex:k - self.startIndex];
                            if ([rewardText isEqualToString:@"0"]) {
                                totalAppearCount++;
                            }
                        }
                        
                        [censuesPage addObject:[NSString stringWithFormat:@"%ld", totalAppearCount]];
                    }
                    
                    //平均遗漏值
                    if (i == 1) {
                        
                        NSInteger averageMissCount = 0;
                        
                        NSArray *firstList = [censuesArray objectAtIndex:0];
                        NSArray *lastPage = [firstList objectAtIndex:j];
                        NSString *totalAppearText = [lastPage objectAtIndex:k - self.startIndex];
                        NSInteger totalAppearCount = totalAppearText.integerValue;
                        
                        if (totalAppearCount == 0) {
                            averageMissCount = self.openedList.count + 1;
                        } else {
                            averageMissCount = self.openedList.count / totalAppearCount;
                        }
                        [censuesPage addObject:[NSString stringWithFormat:@"%ld", averageMissCount]];
                    }
                    
                    //最大遗漏值
                    if (i == 2) {
                        NSInteger maxMissCount = 0;
                        
                        for (NSUInteger x = 0; x < self.missingArray.count; x++) {
                            NSArray *missList = [self.missingArray objectAtIndex:x];
                            NSArray *missPage = [missList objectAtIndex:j];
                            NSString *rewardText = [missPage objectAtIndex:k - self.startIndex];
                            NSInteger rewardInt = rewardText.integerValue;
                            if (rewardInt > maxMissCount) {
                                maxMissCount = rewardInt;
                            }
                        }
                        
                        [censuesPage addObject:[NSString stringWithFormat:@"%ld", maxMissCount]];
                    }
                    
                    //最大连出值
                    if (i == 3) {
                        NSInteger maxContinuousCount = 0;
                        
                        for (NSUInteger x = 0; x < self.missingArray.count; x++) {
                            NSArray *missList = [self.missingArray objectAtIndex:x];
                            NSArray *missPage = [missList objectAtIndex:j];
                            
                            NSString *rewardText = [missPage objectAtIndex:k - self.startIndex];
                            if ([rewardText isEqualToString:@"0"]) {
                                NSInteger tempCount = 1;
                                
                                for (NSInteger z = x - 1; z >= 0; z--) {
                                    if (z < 0) continue;
                                    
                                    NSArray *lastList = [self.missingArray objectAtIndex:z];
                                    NSArray *lastPage = [lastList objectAtIndex:j];
                                    NSString *lastText = [lastPage objectAtIndex:k - self.startIndex];
                                    if ([lastText isEqualToString:@"0"]) {
                                        tempCount++;
                                    } else {
                                        break;
                                    }
                                }
                                
                                if (tempCount > maxContinuousCount) {
                                    maxContinuousCount = tempCount;
                                }
                            }
                        }
                        
                        [censuesPage addObject:[NSString stringWithFormat:@"%ld", maxContinuousCount]];
                    }
                    
                }
            }
        }
        
        _censuesArray = censuesArray;
    }
    
    return _censuesArray;
}

- (NSArray *)missingArray {
    if (_missingArray == nil) {
        NSMutableArray *missingArray = [NSMutableArray array];
        
        NSArray *numberArray = [self.missingData componentsSeparatedByString:@","];
        
        // 30个开奖记录
        for (NSUInteger i = 0; i < self.openedList.count; i++) {
            NSMutableArray *missList = [NSMutableArray array];
            [missingArray addObject:missList];
            
            // 取出某一期开奖号码
            DSTrendChartGainListInfo *info = [self.openedList objectAtIndex:i];
            // 切割出每个号码值
            NSArray *openArray = [info.ticketOpenNum componentsSeparatedByString:@","];
            
            // 每个开奖号码所在区间 例如 万、千、百、十、个
            for (NSUInteger j = 0; j < self.pageCount; j++) {
                
                NSMutableArray *missPage = [NSMutableArray array];
                [missList addObject:missPage];
                
                // 取出每个中奖值
                NSString *reward = [openArray objectAtIndex:j];
                NSInteger rewardInt = reward.integerValue;
                
                // 每个区间中的对应号码 例如 0～9、1～11
                for (NSUInteger k = self.startIndex; k < self.pageSize + self.startIndex; k++) {
                    
                    NSString *census = nil;
                    // 转存遗落值
                    if (i == 0) {
                        census = [numberArray objectAtIndex:j * self.pageSize + (k - self.startIndex)];
                        //计算遗落值
                    } else {
                        
                        NSArray *lastMissList = [missingArray objectAtIndex:i - 1];
                        NSArray *lastMissCount = [lastMissList objectAtIndex:j];
                        census = [lastMissCount objectAtIndex:k - self.startIndex];
                        
                        NSInteger censusInt = census.integerValue;
                        censusInt++;
                        
                        if (rewardInt == k) censusInt = 0;
                        
                        census = [NSString stringWithFormat:@"%ld",censusInt];
                    }
                    
                    [missPage addObject:census];
                }
            }
        }
        
        _missingArray = missingArray;
    }
    
    return _missingArray;
}

@end


