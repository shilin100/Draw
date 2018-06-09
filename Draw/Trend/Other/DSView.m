//
//  DSView.m
//  DSBet
//
//  Created by Selena on 2018/1/1.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSView.h"

@implementation DSView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    
    return self;
}

- (void)initSelf
{
    
    //子类View继承
}

- (void)updateViewWithData:(NSObject *)data {}


- (UIView*)keyWindow
{
    UIWindow *w = [[[UIApplication sharedApplication] windows] firstObject];
    return w;
}


@end
