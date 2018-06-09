//
//  CXNetworkTool.m
//  Lottery
//
//  Created by Traveler on 2018/4/30.
//  Copyright © 2018年 Traveler. All rights reserved.
//

#import "CXNetworkTool.h"


@implementation CXNetworkTool

//注册模块
+ (void)registerWithRegistInfo:(NSDictionary *)registInfo success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure{
    [self postWithPath:URL_Register params:registInfo success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取短信验证码
+ (void)getSMSValidateCodeWithUserPhone:(NSString *)phone success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
{
    NSDictionary * params = @{@"UserPhone":phone};
    [self postWithPath:URL_GetSMSVerificationCode params:params success:^(id responseObject) {

        success(responseObject);
    } failure:^(NSError *error) {

        failure(error);
    }];
}


//找回密码
+ (void)resetPasswordWithUserPhone:(NSString *)phone newPassword:(NSString *)password success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
{
    NSDictionary * params = @{@"UserPhone":phone,@"NewPwd":password};
    [self getWithPath:URL_ResetPassword params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
//        [CXTools showTips:@"网络繁忙，请稍后再试"];
        failure(error);
    }];
}

//登录
//+ (void)loginWithUser:(CXUser *)user success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"UserPhone"] = user.UserPhone;
//    params[@"Password"] = user.Password;
//    params[@"DeviceTokens"] = user.UserPhone;
//
//    [self postWithPath:URL_Login params:params success:^(id responseObject) {
//        CXLog(@"%@",responseObject);
//        success(responseObject);
//    } failure:^(NSError *error) {
//        [CXTools showTips:@"请求失败，请稍后再试"];
//        failure(error);
//    }];
//}


//修改密码
+ (void)modifyPasswordWithUserID:(NSString *)userID oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
{
    NSDictionary * params = @{@"UserID":userID,@"Password":oldPassword,@"NewPwd":newPassword};
    [self getWithPath:URL_ModifyPassword params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {

        failure(error);
    }];
    
}



//用于我的关注
+ (void)getMyAttentionSuccess:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
{
    NSDictionary * params = @{@"type":@"消防常识"};
    
    [self getWithPath:@"http://120.76.101.230:8501/fsss_api/discover/getArticleList" params:params success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if(code == 200){
            success(responseObject);
        }else{

        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取双色球信息
+ (void)getSSQInfoSuccess:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
{
    
    [self getWithPath:@"http://f.apiplus.net/ssq.json" params:nil success:^(id responseObject) {        
//        if ([responseObject objectForKey:@"data"] != nil) {
            success(responseObject);
//        }else{
//            [CXTools showTips:@"暂无数据"];
//        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取福彩3D信息
+ (void)getFC3DInfoSuccess:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure
{
    [self getWithPath:@"http://f.apiplus.net/fc3d.json" params:nil success:^(id responseObject) {
            if ([responseObject objectForKey:@"data"] != nil) {
                success(responseObject);
            }
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
