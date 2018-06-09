//
//  TTAppcationInstance.h
//  DSBet
//
//  Created by 黄文豹 on 18/4/28.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAppcationInstance : NSObject

@property (nonatomic, strong) NSArray *kjhms;

+ (instancetype)sharedInstance;
@end
