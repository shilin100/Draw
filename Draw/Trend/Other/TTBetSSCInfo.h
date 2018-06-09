//
//  TTBetSSCInfo.h
//  DSBet
//
//  Created by 黄文豹 on 18/4/26.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSDataObject.h"
#import "FEPrecompile.h"

@interface TTBetSSCInfo : DSDataObject


PROPERTY_COPY     NSArray   *kjhms;
PROPERTY_COPY     NSString   *kjtime;
PROPERTY_COPY     NSString   *issue;


@end
