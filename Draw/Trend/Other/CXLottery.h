//
//  CXLottery.h
//  Lottery
//
//  Created by Traveler on 2018/4/29.
//  Copyright © 2018年 Traveler. All rights reserved.
//

#ifndef CXLottery_h
#define CXLottery_h

//日志打印
#ifdef DEBUG
#define CXLog(...) NSLog(@"%s 行号：%d \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define CXLog(...)
#endif



#define SSQBet @"双色球"
#define FC3DBet @"福彩3D"
#define GD11S5Bet @"广东11选5"
#define JSK3Bet @"江苏快3"
#define AHK3Bet @"安徽快3"
#define JLK3Bet @"吉林快3"
#define XJSSCBet @"新疆时时彩"
#define TJSSCBet @"天津时时彩"

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define mainView [UIApplication sharedApplication].keyWindow

//属性定义宏
#define  PROPERTY_WEAK       @property (nonatomic,weak)
#define  PROPERTY_ASSIGN     @property (nonatomic,assign)
#define  PROPERTY_COPY       @property (nonatomic,copy  )
#define  PROPERTY_STRONG     @property (nonatomic,strong)
#define  PROPERTY_READONLY   @property (nonatomic,readonly)
#define  PROPERTY_STRONG_R   @property (nonatomic,strong,readonly)

// 颜色
#define CXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define CXColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define CXRandomColor (CXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))) //随机色

#define CXGlobalBgColor  CXColor(245, 245, 245)//[UIColor colorWithHexString:@"#f5f5f5"] //全局背景颜色

#define CXGlobalThemeColor  CXColor(212, 0, 0)  //全局主题颜色

#define CXGlobalDisabledColor  CXColor(220, 220, 220) //全局不可点击的主题颜色

#define CXRedBallColor  CXColor(216, 30, 6)  //红球
#define CXBlueBallColor  CXColor(0, 102, 219) //篮球
// 字体
#define CXFont(s)  [UIFont systemFontOfSize:(s)]


// 判断是否是iPhone X
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 5.5屏幕判断
#define isIPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
// 4.7屏幕判断
#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
// 4.0屏幕判断
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 3.5屏幕判断
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPad ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound)

#define IsAfterIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)
#define IsAfterIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0)

// 状态栏高度
#define STATUS_BAR_HEIGHT (isIPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (isIPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (isIPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (isIPhoneX ? 34.f : 0.f)


#endif /* CXLottery_h */
