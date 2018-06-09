//
//  DSView.h
//  DSBet
//
//  Created by Selena on 2018/1/1.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSView : UIView

- (void)initSelf;

- (void)updateViewWithData:(NSObject *)data;

- (UIView *)keyWindow;

@end
