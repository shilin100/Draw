//
//  JAJNetwork.h
//  139Boot
//
//  Created by JiangAijun on 2015/8/25.
//  Copyright © 2015年 com.richinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JAJRequestMethod){
    GET,
    POST,
};

typedef void (^JAJSuccessBlock)(id responseObject);
typedef void (^JAJFailureBlock)(NSError *error);
typedef void (^JAJDownloadProgressBlock)(float progress);
typedef void (^JAJUploadProgressBlock)(float progress);

typedef void (^JAJRequestCallBlock)(NSURLResponse *response,id responseObject,NSError *error);


@interface JAJNetwork : NSObject



/**
 get网络请求
 
 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;


/**
 post网络请求
 
 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;



/**
 下载文件
 
 @param path url路径
 @param success 下载成功
 @param failure 下载失败
 @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure progress:(JAJDownloadProgressBlock)progress;


/**
 上传图片
 
 @param path url地址
 @param params UIImage对象
 @param imagekey imagekey
 @param image 上传参数
 @param success 上传成功
 @param failure 上传失败
 @param progress 上传进度
 */
//+ (void)uploadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)imagekey image:(UIImage *)image success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure progress:(JAJUploadProgressBlock)progress;



/**
 请求加载数据
 
 @param method GET / POST
 @param urlString URLString
 @param sendBodyString 请求体
 @param finished 完成回调
 */
+ (void)dataTaskWithHTTPMethod:(JAJRequestMethod)method urlString:(NSString *)urlString sendBodyInfoString:(NSString *)sendBodyString finised:(JAJRequestCallBlock)finished;


/**
 请求加载数据
 
 @param request request
 @param finished 完成回调
 */
+ (void)dataTaskWithRequest:(NSURLRequest *)request finised:(JAJRequestCallBlock)finished;




@end
