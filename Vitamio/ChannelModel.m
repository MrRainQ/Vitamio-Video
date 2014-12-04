//
//  ChannelModel.m
//  NesTV
//
//  Created by sen5labs on 14-8-21.
//  Copyright (c) 2014年 linger. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.db_id = [dict[@"db_id"] intValue];                         //  频道id
        self.db_ts_id = [dict[@"db_ts_id"] integerValue] ;              //  播放的频点
        self.name = dict[@"name"];                                      //  频道名
        self.service_type = [dict[@"service_type"]integerValue];        //  服务类型
        self.scrambled_flag = [dict[@"scrambled_flag"] integerValue];   //  费用
        self.hd = [dict[@"hd"] integerValue];                           //  高清
        self.chan_num = [dict[@"chan_num"] integerValue];               //  频道号
        self.skip = [dict[@"skip"] integerValue];                       //  隐藏
        self.lock = [dict[@"lock"] integerValue];                       //  加密
        self.favor = [dict[@"favor"] integerValue];                     //  喜爱
        self.db_sat_para_id = [dict[@"db_sat_para_id"] integerValue];   //  卫星的id
        self.chan_order = [dict[@"chan_order"] integerValue];           //  频道顺序
        self.vid_pid = [dict[@"vid_pid"] integerValue];
        self.aud_pids = dict[@"aud_pids"];
        self.pmt_pid  = [dict[@"pmt_pid"] integerValue];
    }
    return self;
}

@end
