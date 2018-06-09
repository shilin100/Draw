//
//  DSTrendChartView.m
//  DSBet
//
//  Created by Selena on 2018/3/6.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSTrendChartView.h"

#import "DSTrendChartGainDataInfo.h"
#import "DSTrendChartGainListInfo.h"

#import "FEPrecompile.h"  //xin
#import "CXLottery.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Item.h"

#define kDSTrendChartView_TextFontSize              10
#define kDSTrendChartView_LineHalfWidth             (.7f)
#define kDSTrendChartPeriodsView_ItemWidth          30
#define kDSTrendChartSuspendView_PeriodsOffset      8
#define kDSTrendChartPeriodsView_TextTailCount      (4)
#define kDSTrendChartPeriodsView_TextAppearCount    (@"出现总次数")
#define kDSTrendChartPeriodsView_TextMissAverage    (@"平均遗漏值")
#define kDSTrendChartPeriodsView_TextMissMax        (@"最大遗漏值")
#define kDSTrendChartPeriodsView_TextContinuousMax  (@"最大连出值")

@class DSTrendChartTitleView;
@class DSTrendChartPeriodsView;
@class DSTrendChartContentView;
@class DSTrendChartSuspendView;

// 趋势图 主View
@interface DSTrendChartView ()
<
UIScrollViewDelegate
>
{
    UIScrollView *_topScrollView;
    UIScrollView *_leftScrollView;
    UIScrollView *_contentScrollView;
    
    DSTrendChartSuspendView *_topSuspendView;
    DSTrendChartTitleView *_topTitleView;
    DSTrendChartPeriodsView *_periodsView;
    DSTrendChartContentView *_contentView;
}

PROPERTY_STRONG DSTrendChartGainDataInfo *dataInfo;

@end

//标题内容
@interface DSTrendChartTitleView : DSView

@property(nonatomic, assign) NSUInteger startIndex;
@property(nonatomic, assign) NSUInteger pageSize;
@property(nonatomic, assign) NSUInteger pageCount;

@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;

- (void)updateReloadUI;

@end


//开奖期数
@interface DSTrendChartPeriodsView : DSView

PROPERTY_STRONG DSTrendChartGainDataInfo *dataInfo;

@property(nonatomic, assign) NSUInteger rewardCount;
@property(nonatomic, assign) CGFloat periodsWidth;

@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;

@end

//中间内容
@interface DSTrendChartContentView : DSView

PROPERTY_STRONG DSTrendChartGainDataInfo *dataInfo;

@property(nonatomic, assign) NSInteger startIndex;
@property(nonatomic, assign) NSInteger pageSize;
@property(nonatomic, assign) NSInteger pageCount;

@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;

@end


//悬浮内容
@interface DSTrendChartSuspendView : DSView

PROPERTY_STRONG DSTrendChartGainDataInfo *dataInfo;

@property(nonatomic, assign) CGFloat periodsWidth;

@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;

@end


@implementation DSTrendChartView

- (void)initSelf
{
    [super initSelf];
    [self setClipsToBounds:YES];
    
    _contentScrollView = [self setupContentScrollView];
    _contentScrollView.userInteractionEnabled = YES;
    
    _topSuspendView = [self setupContentTrendChartSuspendView];
    _topScrollView = [self setupContentScrollView];
    _leftScrollView = [self setupContentScrollView];
    _leftScrollView.showsVerticalScrollIndicator = NO;
    
    _topTitleView = ({
        DSTrendChartTitleView *view = [[DSTrendChartTitleView alloc] init];
        [_topScrollView addSubview:view];
        view;
    });
    
    _periodsView = ({
        DSTrendChartPeriodsView *view = [[DSTrendChartPeriodsView alloc] init];
        [_leftScrollView addSubview:view];
        view;
    });
    
    _contentView = ({
        DSTrendChartContentView *view = [[DSTrendChartContentView alloc] init];
        [_contentScrollView addSubview:view];
        view;
    });
}

- (UIScrollView *)setupContentScrollView
{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectZero];
    view.userInteractionEnabled = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.showsVerticalScrollIndicator = NO;
    view.delegate = self;
    [self addSubview:view];
    
    return view;
}

- (DSTrendChartSuspendView *)setupContentTrendChartSuspendView
{
    DSTrendChartSuspendView *view = [[DSTrendChartSuspendView alloc] init];
    view.userInteractionEnabled = NO;
    view.backgroundColor = CXColor(55, 55, 55);
    [self addSubview:view];
    return view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.dataInfo == nil || self.dataInfo.openedList.count <= 0) return;
    
    CGFloat pageCountWidth = kDSTrendChartPeriodsView_ItemWidth * _topTitleView.pageCount;
    
    CGFloat x = 0, y = 0, w = 0, h = 0;
    
    //计算悬浮视图Frame
    
    w = _topSuspendView.periodsWidth ;
    h = kDSTrendChartPeriodsView_ItemWidth * 2;
    _topSuspendView.frame = CGRectMake(x, y, w, h);
    [_topSuspendView setNeedsDisplay];
    
    // 计算上标题栏Frame
    x = _topSuspendView.x + _topSuspendView.width;y = _topSuspendView.y;
    w = self.width - x; h = _topSuspendView.height;
    _topScrollView.frame = CGRectMake(x, y, w, h);
    _topScrollView.contentSize = CGSizeMake(_topTitleView.pageSize * pageCountWidth, h);
    _topTitleView.frame = CGRectMake(0, 0, _topScrollView.contentSize.width, _topScrollView.height);
    [_topTitleView setNeedsDisplay];
   //[_topTitleView updateReloadUI];
    
    // 计算左标题栏Frame
    x = _topSuspendView.x; y = _topSuspendView.height;
    w = _topSuspendView.width; h = self.height - _topSuspendView.height;
    _leftScrollView.frame = CGRectMake(x, y, w, h);
    _leftScrollView.contentSize = CGSizeMake(w, kDSTrendChartPeriodsView_ItemWidth * (self.dataInfo.openedList.count + kDSTrendChartPeriodsView_TextTailCount));
    _periodsView.frame = CGRectMake(0, 0, _leftScrollView.width, _leftScrollView.contentSize.height);
    [_periodsView setNeedsDisplay];
    
    // 计算中间内容Frame
    _contentScrollView.frame = self.bounds;
    _contentScrollView.contentSize = CGSizeMake(_topScrollView.contentSize.width, _leftScrollView.contentSize.height);
    _contentScrollView.contentInset = UIEdgeInsetsMake(_topSuspendView.height, _topSuspendView.width, 0, 0);
    _contentView.frame = CGRectMake(0, 0, _contentScrollView.contentSize.width, _contentScrollView.contentSize.height);
    [_contentView setNeedsDisplay];
    [_contentScrollView setContentOffset:CGPointMake(-_contentScrollView.contentInset.left, -_contentScrollView.contentInset.top)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_contentScrollView]) {
        CGFloat contentOffsetX = scrollView.contentOffset.x + scrollView.contentInset.left;
        CGFloat contentOffsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
        if (contentOffsetX <= 0) contentOffsetX = 0;
        if (contentOffsetY <= 0) contentOffsetY = 0;
        _topScrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        _leftScrollView.contentOffset = CGPointMake(0, contentOffsetY);
    }
}

- (void)updateViewWithData:(NSObject *)data
{
    self.dataInfo = objc_dynamic_cast(data, DSTrendChartGainDataInfo);
    if (self.dataInfo) {
        
        _topTitleView.startIndex = self.dataInfo.startIndex;
        _topTitleView.pageSize = self.dataInfo.pageSize;
        _topTitleView.pageCount = self.dataInfo.pageCount;
        
        _contentView.startIndex = _topTitleView.startIndex;
        _contentView.pageSize = _topTitleView.pageSize;
        _contentView.pageCount = _topTitleView.pageCount;
        _periodsView.rewardCount = _topTitleView.pageCount;
        
        _periodsView.dataInfo = self.dataInfo;
        _topSuspendView.dataInfo = self.dataInfo;
        _contentView.dataInfo = self.dataInfo;
        
        DSTrendChartGainListInfo *listInfo = self.dataInfo.openedList.firstObject;
        NSString *openNums = listInfo.ticketPlanId;
        CGSize openWidth = [openNums sizeWithFont:_topSuspendView.textFont constrainedToSize:self.size];
        _periodsView.periodsWidth = _topSuspendView.periodsWidth = openWidth.width + kDSTrendChartSuspendView_PeriodsOffset * 2;
        
        [self setNeedsLayout];
    }
}

@end



//标题内容
@implementation DSTrendChartTitleView

- (void)updateReloadUI
{
    [self drawRect:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.startIndex = 0;
        self.pageSize = 0;
        self.pageCount = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.pageCount == 0 || self.pageSize == 0) return;
    
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 1.f, 0.73f, 0.f, 1);
    CGContextFillRect(context, self.bounds);
    
    CGFloat offset = kDSTrendChartView_LineHalfWidth;
    
    //设置画笔颜色
    CGContextSetRGBStrokeColor(context, 0.65, 0.84, 0.94, 1.00);
    
    CGContextMoveToPoint(context, 0 + offset, 0 + offset);
    CGContextAddLineToPoint(context,self.width - offset, 0 + offset);
    
    CGContextMoveToPoint(context, 0 + offset, self.height * .5);
    CGContextAddLineToPoint(context,self.width - offset, self.height * .5);
    
    CGContextMoveToPoint(context, 0 + offset, self.height - offset);
    CGContextAddLineToPoint(context,self.width - offset, self.height - offset);
    
    //格子
    for (NSUInteger i = 0; i < self.pageCount; i++) {
        for (NSUInteger j = 1; j <= self.pageSize; j++) {
            
            CGFloat x =  kDSTrendChartPeriodsView_ItemWidth * ((i * self.pageSize) + j);
            if (j == self.pageSize) {
                CGContextMoveToPoint(context, x, 0);
            } else {
                CGContextMoveToPoint(context, x, self.height * .5);
            }
            CGContextAddLineToPoint(context, x, self.height);
            
        }
    }
    CGContextStrokePath(context);
    
    
    //绘制文字
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineBreakMode = NSLineBreakByCharWrapping;
    para.alignment = NSTextAlignmentCenter;
    NSDictionary *attrs = @{NSFontAttributeName : self.textFont, NSForegroundColorAttributeName: self.textColor, NSParagraphStyleAttributeName : para};
    
    CGSize sizeText = self.size;
    CGRect rectText = self.bounds;
    
    for (NSUInteger i = 0; i < self.pageCount ; i++) {
        for (NSUInteger j = self.startIndex; j < self.pageSize + self.startIndex; j++) {
            NSString *numStr = [NSString stringWithFormat:@"%ld", j];
            sizeText = [numStr sizeWithFont:self.textFont constrainedToSize:self.size];
            CGFloat x = kDSTrendChartPeriodsView_ItemWidth * (i * self.pageSize) + (j - self.startIndex) * kDSTrendChartPeriodsView_ItemWidth  + (kDSTrendChartPeriodsView_ItemWidth - sizeText.width) * .5;
            rectText = CGRectMake(x, self.height * .5 + (self.height * .5 - sizeText.height) * .5, sizeText.width, sizeText.height);
            [numStr drawInRect:rectText withAttributes:attrs];
            
            if (j == self.startIndex) {
                NSString *titleText = [NSString stringWithFormat:@"第%ld位", i + 1];
                sizeText = [titleText sizeWithFont:self.textFont constrainedToSize:self.size];
                CGFloat x = (self.pageSize * kDSTrendChartPeriodsView_ItemWidth - sizeText.width) * .5 + self.pageSize * kDSTrendChartPeriodsView_ItemWidth * i;
                rectText = CGRectMake(x, (self.height * .5 - sizeText.height) * .5, sizeText.width, sizeText.height);
                [titleText drawInRect:rectText withAttributes:attrs];
            }
        }
    }
    CGContextStrokePath(context);
}

- (UIFont *)textFont
{
    if (_textFont == nil) {
        UIFont *font = [UIFont systemFontOfSize:13];
        
        _textFont = font;
    }
    
    return _textFont;
}

- (UIColor *)textColor
{
    if (_textColor == nil) {
        UIColor *color = [UIColor whiteColor];
        
        _textColor = color;
    }
    
    return _textColor;
}
@end


//开奖期数
@implementation DSTrendChartPeriodsView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.dataInfo == nil && self.dataInfo.openedList.count <= 0) return;
    
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 1.f, 1.f, 1.f, 1.f);
    CGContextFillRect(context, self.bounds);
    
    CGFloat lineOffset = kDSTrendChartView_LineHalfWidth;
    CGFloat periodsWidth = self.periodsWidth;
    NSUInteger herEndCount = self.dataInfo.openedList.count + kDSTrendChartPeriodsView_TextTailCount;
    
    //设置画笔颜色
    CGContextSetRGBStrokeColor(context, 0.65, 0.84, 0.94, 1.00);
    
    //三条竖线
    CGContextMoveToPoint(context, 0 + lineOffset, 0 + lineOffset);
    CGContextAddLineToPoint(context, 0 + lineOffset, self.height - lineOffset);
    
    //横线
    for (NSUInteger i = 0; i < herEndCount; i++) {
        CGFloat y = kDSTrendChartPeriodsView_ItemWidth + i * kDSTrendChartPeriodsView_ItemWidth;
        if (i == herEndCount - 1) y = y - lineOffset;
        CGContextMoveToPoint(context, 0 + lineOffset, y);
        CGContextAddLineToPoint(context, self.width - lineOffset, y);
    }

    CGContextStrokePath(context);
    
    //绘制文字
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineBreakMode = NSLineBreakByCharWrapping;
    para.alignment = NSTextAlignmentCenter;
    NSDictionary *attrsPeriods = @{NSFontAttributeName : self.textFont, NSForegroundColorAttributeName: self.textColor, NSParagraphStyleAttributeName : para};
//    NSDictionary *attrsNumbers = @{NSFontAttributeName : self.textFont, NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName : para};
    
    CGSize sizeText = self.size;
    CGRect rectText = self.bounds;
    NSString *textDraw = nil;
    for (NSUInteger i = 0; i < herEndCount; i++) {
        if (i < self.dataInfo.openedList.count) {
            DSTrendChartGainListInfo *listInfo = [self.dataInfo.openedList objectAtIndex:i];
            //开奖期数
            textDraw = listInfo.ticketPlanId;
            sizeText = [textDraw sizeWithFont:self.textFont constrainedToSize:self.size];
            rectText = CGRectMake((periodsWidth - sizeText.width) * .5, i * kDSTrendChartPeriodsView_ItemWidth + (kDSTrendChartPeriodsView_ItemWidth - sizeText.height) * .5, sizeText.width, sizeText.height);
            [textDraw drawInRect:rectText withAttributes:attrsPeriods];
        } else {
            if (i == 0 + self.dataInfo.openedList.count) {
                textDraw = kDSTrendChartPeriodsView_TextAppearCount;
            } else if (i == 1 + self.dataInfo.openedList.count) {
                textDraw = kDSTrendChartPeriodsView_TextMissAverage;
            } else if (i == 2 + self.dataInfo.openedList.count) {
                textDraw = kDSTrendChartPeriodsView_TextMissMax;
            } else if (i == 3 + self.dataInfo.openedList.count) {
                textDraw = kDSTrendChartPeriodsView_TextContinuousMax;
            }
            sizeText = [textDraw sizeWithFont:self.textFont constrainedToSize:self.size];
            rectText = CGRectMake((self.width - sizeText.width) * .5, i * kDSTrendChartPeriodsView_ItemWidth + (kDSTrendChartPeriodsView_ItemWidth - sizeText.height) * .5, sizeText.width, sizeText.height);
            [textDraw drawInRect:rectText withAttributes:attrsPeriods];
        }
    }
    CGContextStrokePath(context);
}

- (UIFont *)textFont
{
    if (_textFont == nil) {
        UIFont *font = [UIFont systemFontOfSize:kDSTrendChartView_TextFontSize];
        _textFont = font;
    }
    
    return _textFont;
}

- (UIColor *)textColor
{
    if (_textColor == nil) {
        UIColor *color = [UIColor blackColor];
        
        _textColor = color;
    }
    
    return _textColor;
}

@end


//中间内容
@implementation DSTrendChartContentView : DSView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.dataInfo == nil && self.dataInfo.openedList.count <= 0) return;
    
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 1.f, 1.f, 1.f, 1.f);
    CGContextFillRect(context, self.bounds);
    //分段背景颜色
    for (NSUInteger i = 0; i < self.pageCount; i++) {
        if ((i % 2) != 0) {
            CGFloat x = i * self.pageSize * kDSTrendChartPeriodsView_ItemWidth;
            CGFloat w = self.pageSize * kDSTrendChartPeriodsView_ItemWidth;
            CGContextSetRGBFillColor(context, .83f, .92f, .97f, .7f);
            CGContextFillRect(context, CGRectMake(x, 0, w, self.height - kDSTrendChartPeriodsView_TextTailCount * kDSTrendChartPeriodsView_ItemWidth));
        }
    }
    
    //设置画笔颜色
    CGContextSetRGBStrokeColor(context, 0.65, 0.84, 0.94, 1.00);
    CGFloat lineOffset = kDSTrendChartView_LineHalfWidth;
    CGFloat itemHalfWidth = kDSTrendChartPeriodsView_ItemWidth * .5;
    NSUInteger herEndCount = self.dataInfo.openedList.count + kDSTrendChartPeriodsView_TextTailCount;
    
    //竖着的线线条
    for (NSUInteger i = 0; i < self.pageCount; i++) {
        CGFloat w = kDSTrendChartPeriodsView_ItemWidth * i * self.pageSize;
        for (NSUInteger j = 0; j < self.pageSize; j++) {
            CGFloat x = w + j * kDSTrendChartPeriodsView_ItemWidth;
            CGContextMoveToPoint(context, x, 0 + lineOffset);
            CGContextAddLineToPoint(context, x, self.height - lineOffset);
        }
    }
    
    //横着的线线条
    for (NSUInteger i = 0; i < herEndCount; i++) {
        CGFloat y = kDSTrendChartPeriodsView_ItemWidth + i * kDSTrendChartPeriodsView_ItemWidth;
        if (i == herEndCount - 1) y = y - lineOffset;
        CGContextMoveToPoint(context, 0 + lineOffset, y);
        CGContextAddLineToPoint(context,self.width - lineOffset, y);
    }
    CGContextStrokePath(context);
    
    //绘制遗漏文字
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineBreakMode = NSLineBreakByCharWrapping;
    para.alignment = NSTextAlignmentCenter;
    NSDictionary *darwsAttrs = @{NSFontAttributeName : self.textFont, NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName : para};
    
    CGSize sizeText = self.size;
    CGRect rectText = self.bounds;
    CGFloat ellipseOffset = 2.f;
    CGFloat ellipseWidth = kDSTrendChartPeriodsView_ItemWidth - ellipseOffset * 2;
    
    NSArray *missArray = self.dataInfo.missingArray;
    for (NSUInteger i = 0; i < missArray.count; i++) {
        DSTrendChartGainListInfo *listInfo = [self.dataInfo.openedList objectAtIndex:i];
        NSArray *missList = [missArray objectAtIndex:i];
        NSArray *numberArray = [listInfo.ticketOpenNum componentsSeparatedByString:@","];
        CGFloat y = i * kDSTrendChartPeriodsView_ItemWidth;
        
        for (NSUInteger j = 0; j < self.pageCount; j++) {
            NSArray *missPage = [missList objectAtIndex:j];
            
            NSString  *rewardText = [numberArray objectAtIndex:j];
            if(rewardText.length > 1){
                NSString *sunStr = [rewardText substringToIndex:1];
                if([sunStr isEqualToString:@"0"]){
                    rewardText = [rewardText substringFromIndex:1];
                }
            }
            NSInteger rewardNumber = rewardText.integerValue;
            CGFloat w = kDSTrendChartPeriodsView_ItemWidth * j * self.pageSize;
            
            for (NSUInteger k = self.startIndex; k < self.pageSize + self.startIndex; k++) {
                CGFloat x = w + (k - self.startIndex) * kDSTrendChartPeriodsView_ItemWidth;
                if (k != rewardNumber) {
                    NSString  *drawText = [missPage objectAtIndex:k - self.startIndex];
                    sizeText = [drawText sizeWithFont:self.textFont constrainedToSize:self.size];
                    rectText = CGRectMake(x + (kDSTrendChartPeriodsView_ItemWidth - sizeText.width) * .5, y + (kDSTrendChartPeriodsView_ItemWidth - sizeText.height) * .5, sizeText.width, sizeText.height);
                    [drawText drawInRect:rectText withAttributes:darwsAttrs];
                    
                }
            }
        }
    }
    CGContextStrokePath(context);
    
    //绘制统计文字
    NSArray *censuesArray = self.dataInfo.censuesArray;
    for (NSUInteger i = 0; i < censuesArray.count; i++) {
        NSArray *censuesList = [censuesArray objectAtIndex:i];
        CGFloat y = (i + missArray.count) * kDSTrendChartPeriodsView_ItemWidth;
        
        for (NSUInteger j = 0; j < self.pageCount; j++) {
            NSArray *censuesPage = [censuesList objectAtIndex:j];
            CGFloat w = kDSTrendChartPeriodsView_ItemWidth * j * self.pageSize;
            
            for (NSUInteger k = self.startIndex; k < self.pageSize + self.startIndex; k++) {
                CGFloat x = w + (k - self.startIndex) * kDSTrendChartPeriodsView_ItemWidth;
                NSString  *drawText = [censuesPage objectAtIndex:k - self.startIndex];
                sizeText = [drawText sizeWithFont:self.textFont constrainedToSize:self.size];
                rectText = CGRectMake(x + (kDSTrendChartPeriodsView_ItemWidth - sizeText.width) * .5, y + (kDSTrendChartPeriodsView_ItemWidth - sizeText.height) * .5, sizeText.width, sizeText.height);
                [drawText drawInRect:rectText withAttributes:darwsAttrs];
            }
        }
    }
    CGContextStrokePath(context);
    
    
    //画连线
    for (NSUInteger i = 0; i < self.pageCount; i++) {
        //设置画笔颜色
        if (i % 2 == 0) CGContextSetRGBStrokeColor(context, 1.f, 0.84f, 0.94f, 1.00f);
        else CGContextSetRGBStrokeColor(context, .73f, .73f, 1.f, 1.00f);
        CGContextSetLineWidth(context, 2.f);
        
        CGFloat startX = 0, startY = 0;
        CGFloat w = kDSTrendChartPeriodsView_ItemWidth * i * self.pageSize + itemHalfWidth;
        
        for (NSUInteger j = 0; j < self.dataInfo.openedList.count; j++) {
            DSTrendChartGainListInfo *listInfo = [self.dataInfo.openedList objectAtIndex:j];
            NSArray *numberArray = [listInfo.ticketOpenNum componentsSeparatedByString:@","];
            NSString  *rewardText = [numberArray objectAtIndex:i];
            if(rewardText.length > 1){
                NSString *sunStr = [rewardText substringToIndex:1];
                if([sunStr isEqualToString:@"0"]){
                    rewardText = [rewardText substringFromIndex:1];
                }
            }
            NSInteger rewardNumber = rewardText.integerValue;
            startY = j * kDSTrendChartPeriodsView_ItemWidth + itemHalfWidth;
            
            for (NSUInteger k = self.startIndex; k < self.pageSize + self.startIndex; k++) {
                if (k == rewardNumber) {
                    
                    startX = w + (k - self.startIndex) * kDSTrendChartPeriodsView_ItemWidth;
                    if (j != 0) CGContextAddLineToPoint(context, startX, startY);
                    if (j != self.dataInfo.openedList.count - 1) CGContextMoveToPoint(context, startX, startY);
                    break;
                }
            }
        }
        CGContextStrokePath(context);
    }
    
    //绘制中奖文字
    NSDictionary *rewardAttrs = @{NSFontAttributeName : self.textFont, NSForegroundColorAttributeName: self.textColor, NSParagraphStyleAttributeName : para};
    for (NSUInteger i = 0; i < self.dataInfo.openedList.count; i++) {
        
        DSTrendChartGainListInfo *listInfo = [self.dataInfo.openedList objectAtIndex:i];
        NSArray *numberArray = [listInfo.ticketOpenNum componentsSeparatedByString:@","];
        CGFloat y = i * kDSTrendChartPeriodsView_ItemWidth;
        
        for (NSUInteger j = 0; j < self.pageCount; j++) {
            
            NSString  *rewardText = [numberArray objectAtIndex:j];
            if(rewardText.length > 1){
                NSString *sunStr = [rewardText substringToIndex:1];
                if([sunStr isEqualToString:@"0"]){
                    rewardText = [rewardText substringFromIndex:1];
                }
            }
            NSInteger rewardNumber = rewardText.integerValue;
            CGFloat w = kDSTrendChartPeriodsView_ItemWidth * j * self.pageSize;
            
            for (NSUInteger k = self.startIndex; k < self.pageSize + self.startIndex; k++) {
                CGFloat x = w + (k - self.startIndex) * kDSTrendChartPeriodsView_ItemWidth;
                if (k == rewardNumber) {
                    if (j % 2 != 0) [[UIColor colorWithRed:.0f green:.53f blue:.8f alpha:1.000] set];
                    else [[UIColor colorWithRed:.96f green:.15f blue:.17f alpha:1.000] set];
                    CGContextFillEllipseInRect(context, CGRectMake(x + ellipseOffset, y + ellipseOffset, ellipseWidth, ellipseWidth));
                    
                    sizeText = [rewardText sizeWithFont:self.textFont constrainedToSize:self.size];
                    rectText = CGRectMake(x + (kDSTrendChartPeriodsView_ItemWidth - sizeText.width) * .5, y + (kDSTrendChartPeriodsView_ItemWidth - sizeText.height) * .5, sizeText.width, sizeText.height);
                    [rewardText drawInRect:rectText withAttributes:rewardAttrs];
                    break;
                }
            }
        }
    }
    CGContextStrokePath(context);
}

- (UIFont *)textFont
{
    if (_textFont == nil) {
        UIFont *font = [UIFont systemFontOfSize:kDSTrendChartView_TextFontSize];
        
        _textFont = font;
    }
    
    return _textFont;
}

- (UIColor *)textColor
{
    if (_textColor == nil) {
        UIColor *color = [UIColor whiteColor];
        
        _textColor = color;
    }
    
    return _textColor;
}

@end


//悬停标题
@implementation DSTrendChartSuspendView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.dataInfo == nil && self.dataInfo.openedList.count <= 0) return;
    
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 1.f, 0.73f, 0.f, 1);
    CGContextFillRect(context, self.bounds);
    
    CGFloat offset = kDSTrendChartView_LineHalfWidth;
    CGFloat w = self.periodsWidth;
    
    //设置画笔颜色
    CGContextSetRGBStrokeColor(context, 0.65, 0.84, 0.94, 1.00);
    
    CGContextMoveToPoint(context, 0 + offset, 0 + offset);
    CGContextAddLineToPoint(context,self.width - offset, 0 + offset);
    
    CGContextMoveToPoint(context,self.width - offset, 0 + offset);
    CGContextAddLineToPoint(context,self.width - offset, self.height - offset);
    
    CGContextMoveToPoint(context,self.width - offset, self.height - offset);
    CGContextAddLineToPoint(context, 0 + offset, self.height - offset);
    
    CGContextMoveToPoint(context, 0 + offset, self.height - offset);
    CGContextAddLineToPoint(context, 0 + offset,  0 + offset);
    
    CGContextMoveToPoint(context, w, 0 + offset);
    CGContextAddLineToPoint(context, w, self.height - offset);
    CGContextStrokePath(context);
    
    //绘制文字
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineBreakMode = NSLineBreakByCharWrapping;
    para.alignment = NSTextAlignmentCenter;
    NSDictionary *attrs = @{NSFontAttributeName : self.textFont, NSForegroundColorAttributeName: self.textColor, NSParagraphStyleAttributeName : para};
    
    CGSize sizeText = self.size;
    CGRect rectText = self.bounds;
    
    NSString *periods = @"期号";
    sizeText = [periods sizeWithFont:self.textFont constrainedToSize:self.size];
    rectText = CGRectMake((w - sizeText.width) * .5, (self.height - sizeText.height) * .5, sizeText.width, sizeText.height);
    
    [periods drawInRect:rectText withAttributes:attrs];
}

- (UIFont *)textFont
{
    if (_textFont == nil) {
        //UIFont *font = [UIFont systemFontOfSize:kDSTrendChartView_TextFontSize];
        UIFont *font = [UIFont systemFontOfSize:13];
        _textFont = font;
    }
    
    return _textFont;
}

- (UIColor *)textColor
{
    if (_textColor == nil) {
        UIColor *color = [UIColor whiteColor];
        
        _textColor = color;
    }
    
    return _textColor;
}
@end
