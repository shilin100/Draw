//
//  CXNetworkTool.h
//  Lottery
//
//  Created by Traveler on 2018/4/30.
//  Copyright © 2018年 Traveler. All rights reserved.
//

#import "JAJNetwork.h"
#import "CXNetworkConfig.h"

@interface CXNetworkTool : JAJNetwork

//注册模块
+ (void)registerWithRegistInfo:(NSDictionary *)registInfo success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//获取短信验证码
+ (void)getSMSValidateCodeWithUserPhone:(NSString *)phone success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//找回密码
+ (void)resetPasswordWithUserPhone:(NSString *)phone newPassword:(NSString *)password success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//登录
//+ (void)loginWithUser:(CXUser *)user success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//修改密码
+ (void)modifyPasswordWithUserID:(NSString *)userID oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword success:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//用于我的关注
+ (void)getMyAttentionSuccess:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//获取双色球信息
+ (void)getSSQInfoSuccess:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

//获取福彩3D信息
+ (void)getFC3DInfoSuccess:(JAJSuccessBlock)success failure:(JAJFailureBlock)failure;

@end
