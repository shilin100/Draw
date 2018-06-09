//
//  JAJNetwork.m
//  139Boot
//
//  Created by JiangAijun on 2015/8/25.
//  Copyright © 2015年 com.richinfo. All rights reserved.
//

#import "JAJNetwork.h"
#import "AFNetworking.h"

static NSString * kBaseUrl = @"";

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //接收参数类型
        
//        client.requestSerializer = [AFJSONRequestSerializer serializer];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
}

@end



@implementation JAJNetwork

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(JAJSuccessBlock)success
            failure:(JAJFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    //    JAJLog(@"kBaseUrl--%@--path==%@",kBaseUrl,path);
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(JAJSuccessBlock)success
             failure:(JAJFailureBlock)failure {
    //获取完整的url路径
    
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}



+ (void)downloadWithPath:(NSString *)path
                 success:(JAJSuccessBlock)success
                 failure:(JAJFailureBlock)failure
                progress:(JAJDownloadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
}


+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                      image:(UIImage *)image
                    success:(JAJSuccessBlock)success
                    failure:(JAJFailureBlock)failure
                   progress:(JAJUploadProgressBlock)progress {
    
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    NSData * data = UIImagePNGRepresentation(image);
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imagekey fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}



+ (void)dataTaskWithHTTPMethod:(JAJRequestMethod)method urlString:(NSString *)urlString sendBodyInfoString:(NSString *)sendBodyString finised:(JAJRequestCallBlock)finished
{
    NSString *methodName = (method == GET) ? @"GET" : @"POST"; //设置方式
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setAllHTTPHeaderFields:@{@"Content-Type":@"application/xml",@"Accept-Encoding":@"gzip,deflate"}];
    [request setHTTPMethod:methodName];
    [request setHTTPBody:[sendBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self dataTaskWithRequest:request finised:finished];
}


+ (void)dataTaskWithRequest:(NSURLRequest *)request finised:(JAJRequestCallBlock)finished
{
    [[[AFHttpClient sharedClient] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        finished(response,responseObject,error);
    }] resume];
}




@end
