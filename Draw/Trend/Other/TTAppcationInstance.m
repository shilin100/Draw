//
//  TTAppcationInstance.m
//  DSBet
//
//  Created by 黄文豹 on 18/4/28.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "TTAppcationInstance.h"

@implementation TTAppcationInstance
+ (instancetype)sharedInstance
{
    static TTAppcationInstance * _suspendBtn;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _suspendBtn = [[TTAppcationInstance alloc] init];
    });
    return _suspendBtn;
}
@end
