//
//  RequestManager.m
//  LvXin
//
//  Created by Weiyijie on 15/9/17.
//  Copyright (c) 2015年 showsoft. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"

@implementation RequestManager

//创建一个单利manager
static AFHTTPSessionManager *manager ;
+ (AFHTTPSessionManager *)sharedHTTPSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 15;
    });
    return manager;
}
/**
 获取新闻
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)newsListSucceed:(Succeed)succeed andFaild:(Failed)falid {
    
    NSString *urlString = @"https://api.dongqiudi.com/app/tabs/iphone/58.json?mark=gif&version=600";
    [RequestManager GetRequestWithUrlString:urlString withDic:nil Succeed:^(NSData *data) {
        succeed(data);
    } andFaild:^(NSError *error) {
        falid(error);
    }];
    
}

/**
 获取足彩信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)zucaiListSucceed:(Succeed)succeed andFaild:(Failed)falid {
    
    NSString *urlString = @"https://api.hoocaitai.com/match/1";
    NSDictionary *dic = @{@"app_key":@"1050AB894F49D63E93AAE0A9442C1805"};
    [RequestManager GetRequestWithUrlString:urlString withDic:dic Succeed:^(NSData *data) {
        succeed(data);
    } andFaild:^(NSError *error) {
        falid(error);
    }];
    
}

/**
 获取开奖信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)kaijiangListSucceed:(Succeed)succeed andFaild:(Failed)falid {
    NSString *urlString = @"https://api.hoocaitai.com/info/award?uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=A406E0D4E0B12C1C7604E2518CDD969A";
//    NSDictionary *dic = @{@"app_key":@"A406E0D4E0B12C1C7604E2518CDD969A",
//                          @"uuid":@"25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41",
//                          @"identity":@"com.hongcaitai.monster",@"platform":@"1"};
    [RequestManager GetRequestWithUrlString:urlString withDic:nil Succeed:^(NSData *data) {
        succeed(data);
    } andFaild:^(NSError *error) {
        falid(error);
    }];
    
}

//足球篮球比分
+ (void)bifenWithLotyId:(NSInteger)lotyId Succeed:(Succeed)succeed andFaild:(Failed)falid {
    NSString *urlString = @"";
    if (lotyId == 1) {
        urlString = @"https://api.hoocaitai.com/info/award/1?issue=0&limit=0&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=FDA6D162F89AB5C964B27502DF831FAA";
    }
    if (lotyId == 2) {
        urlString = @"https://api.hoocaitai.com/info/award/2?issue=0&limit=0&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=768FC5236E8FC55517136A1062E57AC6";
    }
    [RequestManager GetRequestWithUrlString:urlString withDic:nil Succeed:^(NSData *data) {
        succeed(data);
    } andFaild:^(NSError *error) {
        falid(error);
    }];
    
}

//数字彩开奖历史
+ (void)shuzicailishiWithLotyId:(NSInteger)lotyId Succeed:(Succeed)succeed andFaild:(Failed)falid {
    NSString *urlString = @"";
    switch (lotyId) {
        case 10:
            
            urlString = @"https://api.hoocaitai.com/info/award/10?issue=0&limit=20&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=502E78C4460286CD783E9A4E3A0E75D9";
            
            break;
        case 11:
            urlString = @"https://api.hoocaitai.com/info/award/11?issue=0&limit=20&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=68C2B6B6A7FFAEB97655436CB96383BD";
            
            break;
        case 12:
            urlString = @"https://api.hoocaitai.com/info/award/12?issue=0&limit=20&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=9EE55DC9017B671FDCA7DB4990C29641";
            
            break;
        case 21:
            urlString = @"https://api.hoocaitai.com/info/award/21?issue=0&limit=20&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=795F0EFEBAEC5681E52EC385FA91DF82";
            
            break;
        case 32:
            urlString = @"https://api.hoocaitai.com/info/award/30?issue=0&limit=20&uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=9003A22477E66BB170AD915797E8BA4B";
            
            break;
            
        default:
            break;
    }
    [RequestManager GetRequestWithUrlString:urlString withDic:nil Succeed:^(NSData *data) {
        succeed(data);
    } andFaild:^(NSError *error) {
        falid(error);
    }];
    
}

/**
 获取中奖信息
 
 @param succeed 成功
 @param falid 失败
 */
+ (void)zhongjiangInfoWithLotyId:(NSInteger)lotyId qishu:(NSInteger)qishu Succeed:(Succeed)succeed andFaild:(Failed)falid {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.hoocaitai.com/info/szcawarddetail/%ld/%ld?uuid=25EC5AFF-863D-4EC9-94D2-DEB0A66A3F41&version=1.3.2&identity=com.hongcaitai.monster&platform=1&app_key=57B2CBF4732AA3DFD0F240394A14BE3C",lotyId,qishu];
    
    
    [RequestManager GetRequestWithUrlString:urlString withDic:nil Succeed:^(NSData *data) {
        succeed(data);
    } andFaild:^(NSError *error) {
        falid(error);
    }];
    
}
#pragma mark -数据缓存
//从本地读取数据
+ (NSData *)loadLocalDataWithFileName:(NSString *)filename
{
    //1 先从本地取数据
    // temp
    NSString *tempPath = NSTemporaryDirectory();
    
    // 拼接文件名
    NSString *filePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",filename]];
    
    // 解档
    NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return data;
}

+ (void)writeToLocalWithData:(NSData *)data withFileName:(NSString *)filename
{
    // temp
    NSString *tempPath = NSTemporaryDirectory();
    
    // 拼接文件名
    NSString *filePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",filename]];
    
    // file:文件全路径
    [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}







#pragma mark -基本的GET 和POST请求

//*************************************基本的GET 和POST请求


+ (void)GetRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid
{
    
//    MMLog(@"GET请求链接 == %@ ",urlString);
    AFHTTPSessionManager *manager = [RequestManager sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    [manager GET:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            succeed(data);
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
    }];
    
}


+ (void)GetRequestWithUrlString:(NSString *)urlString Succeed:(Succeed)succeed andFaild:(Failed)falid
{
    
//    MMLog(@"GET请求链接 == %@ ",urlString);
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [RequestManager sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            succeed(data);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
    }];
}

+ (NSURLSessionDataTask *)PostRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid
{
//    MMLog(@"POST请求链接 == %@  %@",urlString,dic);
    AFHTTPSessionManager *manager = [RequestManager sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    NSURLSessionDataTask *urlSessionDataTask = [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            if ([NSJSONSerialization isValidJSONObject:responseObject]) {
                data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            }
        }
        
        if (!data) {
            return;
        }
        succeed(data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
    }];
    
    return urlSessionDataTask;
}
#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(Progress)progress
                              success:(DownloadSucceed)success
                              failure:(Failed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    AFHTTPSessionManager *sessionManager = [RequestManager sharedHTTPSessionManager];
    __block NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
//        返回文件位置的URL路径
        success(filePath);
        //保存的文件路径
        return [NSURL fileURLWithPath:filePath];

        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    
    return downloadTask;
}
@end
