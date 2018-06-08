//
//  RequestManager.h
//  LvXin
//
//  Created by Weiyijie on 15/9/17.
//  Copyright (c) 2015年 showsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UpLoadPicQuality 0.3

#define TEST 1

#if TEST
// 测试环境

#define HeadURl @"http://f.apiplus.net"
#define appKey @"fa6849774bebb1f9fe03e22c957a2f30"


#else
// 正式环境
#define HeadURl @"http://f.apiplus.net"
#define appKey @"fa6849774bebb1f9fe03e22c957a2f30"

#endif


typedef void(^Succeed)(NSData * data);
typedef void(^Failed)(NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^Progress)(NSProgress *progress);
//下载成功
typedef void(^DownloadSucceed)(NSString * filePath);

@interface RequestManager : NSObject

/**
 获取新闻
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)newsListSucceed:(Succeed)succeed andFaild:(Failed)falid;

/**
 获取足彩信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)zucaiListSucceed:(Succeed)succeed andFaild:(Failed)falid;

//足彩新闻
+ (void)zucainewsSucceed:(Succeed)succeed andFaild:(Failed)falid;

/**
 获取开奖信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)kaijiangListSucceed:(Succeed)succeed andFaild:(Failed)falid;


/**
 获取比分信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)bifenWithLotyId:(NSInteger)lotyId Succeed:(Succeed)succeed andFaild:(Failed)falid;


//数字彩开奖历史
+ (void)shuzicailishiWithLotyId:(NSInteger)lotyId Succeed:(Succeed)succeed andFaild:(Failed)falid;

/**
 获取中奖信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)zhongjiangInfoWithLotyId:(NSInteger)lotyId qishu:(NSInteger)qishu Succeed:(Succeed)succeed andFaild:(Failed)falid ;
#pragma mark -数据缓存
//从本地读取数据
+ (NSData *)loadLocalDataWithFileName:(NSString *)filename;
// 缓存数据
+ (void)writeToLocalWithData:(NSData *)data withFileName:(NSString *)filename;


+ (NSURLSessionDataTask *)experienceDetails:(Succeed)succeed andFaild:(Failed)falid;
+ (NSURLSessionDataTask *)experienceTender:(Succeed)succeed andFaild:(Failed)falid;
+ (void)voiceWithPhone2:(NSString *)phone succeed:(Succeed)succeed andFaild:(Failed)falid;
+ (void)loginWithPhone2:(NSString *)phone password:(NSString *)password csf:(NSString*)csf succeed:(Succeed)succeed andFaild:(Failed)falid;

@end
