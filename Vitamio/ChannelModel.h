//
//  ChannelModel.h
//  NesTV
//
//  Created by sen5labs on 14-8-21.
//  Copyright (c) 2014年 linger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

@property (nonatomic,assign) int db_id;           //  频道id
@property (nonatomic,assign) NSInteger db_ts_id;        //  播放的频点
@property (nonatomic,copy) NSString *name;              //  频道名
@property (nonatomic,assign) NSInteger service_type;    //  服务类型

@property (nonatomic,assign) NSInteger scrambled_flag;    //  费用
@property (nonatomic,assign) NSInteger hd;              //  高清标示
@property (nonatomic,assign) NSInteger chan_num;        //  频道号

@property (nonatomic,assign) NSInteger skip;            //  隐藏
@property (nonatomic,assign) NSInteger lock;            //  加密
@property (nonatomic,assign) NSInteger favor;           //  喜爱

@property (nonatomic,assign) NSInteger db_sat_para_id;  //  卫星的id
@property (nonatomic,assign) NSInteger chan_order;      //  频道顺序

@property (nonatomic,assign) NSInteger vid_pid;         // video
@property (nonatomic,  copy) NSString  *aud_pids;       // audio
@property (nonatomic,assign) NSInteger pmt_pid;         // pmt

- (id)initWithDict:(NSDictionary *)dict;
@end
