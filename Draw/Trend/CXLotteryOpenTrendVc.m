//
//  CXLotteryOpenTrendVc.m
//  Lottery
//
//  Created by Traveler on 2018/5/3.
//  Copyright © 2018年 Traveler. All rights reserved.
//

#import "CXLotteryOpenTrendVc.h"
#import "DSTrendChartView.h"
#import "DSTrendChartGainDataInfo.h"
#import "DSTrendChartGainListInfo.h"
#import "TTAppcationInstance.h"
#import "CXSSQModel.h"
#import "UIBarButtonItem+Item.h"
#import "CXNetworkTool.h"
#import <MJExtension/MJExtension.h>

@interface CXLotteryOpenTrendVc ()

@property (nonatomic, weak) DSTrendChartView *chartView;
@property (nonatomic, assign) NSInteger ticketId;

@end

@implementation CXLotteryOpenTrendVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.comefrom.length?@"福彩3D详情走势":@"近期趋势图";
    
    self.ticketId = 11;
    
    DSTrendChartView *view = [[DSTrendChartView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view setTicketId:_ticketId];
    [self.view addSubview:view];
    self.chartView = view;
    
    
    if (self.comefrom.length) {
         self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"预购" titleColor:[UIColor whiteColor] target:self action:@selector(clickOrder) titleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    }
    [self requestData];

}
-(void)requestData{
    [CXNetworkTool getFC3DInfoSuccess:^(id responseObject) {
        
        NSArray *newloterys = [CXSSQModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (!newloterys.count) return ;
        NSMutableArray *fc3dArr = [NSMutableArray arrayWithCapacity:5];
        for (CXSSQModel *fc3d in newloterys) {
            fc3d.type = @"福彩3D";
            [fc3dArr addObject:fc3d];
        }

        self.modelArr = [NSArray arrayWithArray:fc3dArr];
        self.comefrom = @"comefrom";
        [self setUpInfoData];

    } failure:^(NSError *error) {

    }];

}
- (void)clickOrder
{
//    CXLog(@"预购");
    [self.navigationController pushViewController:[[NSClassFromString(@"CX3DVc")  alloc] init] animated:YES];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.chartView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50);
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setUpInfoData
{
    DSTrendChartGainDataInfo *info = [DSTrendChartGainDataInfo new];
    
    info.tikectId = 11;
    info.missingData = @"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
    info.rowCount = 50;
    info.pageSize = 10;
    info.pageCount = 7;
    
//    NSArray *arr = [TTAppcationInstance sharedInstance].kjhms;  //参考底部
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    
    for (CXSSQModel *model in self.modelArr) {
//        CXLog(@"%@ -- %@",model.expect,model.opencode);
        DSTrendChartGainListInfo *listinfo = [[DSTrendChartGainListInfo alloc] init];
        listinfo.ticketPlanId = model.expect;//[CXSSQTool SSQInfoFromSanbox].expect; //期号
        listinfo.ticketOpenNum = model.opencode;//@"9,3,8";
        [arr addObject:listinfo];
    }

    info.openedList = arr;
    [self updateContentInfoForView:info];
    
    
    
//    for (CXSSQModel *model in self.modelArr) {
//        DSTrendChartGainListInfo *listinfo = [[DSTrendChartGainListInfo alloc] init];
//        listinfo.ticketPlanId = model.expect; //期号
//        listinfo.ticketOpenNum = model.opencode;
//        [arr addObject:listinfo];
//    }
//    CXLog(@"%@",arr);
//    info.openedList = arr;
//    [self updateContentInfoForView:info];
    
}

- (void)updateContentInfoForView:(DSTrendChartGainDataInfo *)info
{
    DSTrendChartGainDataInfo *info2 = [DSTrendChartGainDataInfo new];
    info2.openedList = info.openedList;
    info2.missingData = info.missingData;
    [info2 setTikectId:info.tikectId];
    [info2 initData];
    [self.chartView updateViewWithData:info2];
}


/*
 list: [ 开奖列表
 {
 id: "121889",
 issue: "613300", 期号
 kjtime: "1492587720", 开奖时间
 kjhm: { 开奖号码
 n1: "9", 号码1
 n2: "3", 号码2
 n3: "1", 号码3
 n4: "5",
 n5: "4"
 },
 */
/*
- (void)parseServerData:(id)data
{
    if (IS_DICTIONARY(data)) {
        
        id list = data[@"data"][@"list"];
        if (IS_ARRAY(list)){
            NSArray *arr = list;
            
            NSMutableArray *array = [NSMutableArray array];
            
            NSInteger num = arr.count > 20 ? 20 : arr.count;
            
            for (NSInteger i = 0; i < num; i ++) {
                
                NSDictionary *dict = arr[i][@"kjhm"];
                
                DSTrendChartGainListInfo *listinfo = [DSTrendChartGainListInfo new];
                
                NSString *str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",dict[@"n1"],dict[@"n2"],dict[@"n3"],dict[@"n4"],dict[@"n5"]];
                
                listinfo.ticketPlanId = arr[i][@"issue"]; //期号
                listinfo.ticketOpenNum = str;   //9,3,1,5,4
                
                [array addObject:listinfo];
            }
            
            self.kjhms = array;
        }
        
    }
}

*/


@end
