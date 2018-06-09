//
//  CXNetworkConfig.h
//  Lottery
//
//  Created by Traveler on 2018/4/30.
//  Copyright © 2018年 Traveler. All rights reserved.
//

#ifndef CXNetworkConfig_h
#define CXNetworkConfig_h

#if 1 //现网

#define SERVER_URL              @"http://120.76.101.230:8501"

#else //研发线

#define SERVER_URL              @"http://www.vooda.cn:8081"

#endif

//注册
#define URL_Register  @"http://app.mhfire.cn/api/User/register"
//获取短信验证码
#define URL_GetSMSVerificationCode  @"http://app.mhfire.cn/api/User/get_code"
//登录
#define URL_Login  @"http://app.mhfire.cn/api/User/login"
//找回密码
#define URL_ResetPassword  @"http://app.mhfire.cn/api/User/changeBack"
//修改密码
#define URL_ModifyPassword  @"http://app.mhfire.cn/api/User/changePwd"
//上传头像
#define URL_UploadImg  @"http://app.mhfire.cn/api/User/uploadImg"


#endif /* CXNetworkConfig_h */
