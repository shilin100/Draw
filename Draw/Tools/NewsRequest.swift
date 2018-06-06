//
//  NewsRequest.swift
//  Draw
//
//  Created by 123 on 2018/6/6.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import Moya


enum ApiManager {
    case login(username:String,password:String,token:String)
    
}
extension ApiManager:TargetType{
    
    var baseURL: URL {
        return URL.init(string: "BaseURL")!
    }
    
    //请求路径
    var path:String{
        
        switch self {
        case .login(username: _, password:_ , token:_):
            return "login/accountLogin"
            
        }
        
    }
    
    var headers: [String: String]? {
        return nil;
    }
    //请求的参数
    var parameters: [String: Any]? {
        switch self {
        case .login(username: let userName, password: let pwd, token: let token):
            return ["account":userName,"pwd":pwd,"deviceToken":token];
            
        }
        
    }
    
    ///请求方式
    var method: Moya.Method {
        switch self {
        case .login(username: _, password: _, token: _):
            return .post;
            
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    //MARK:task type
    var task: Task {
        return .requestPlain
    }
    
    var validate: Bool {
        return false
    }
    
}
