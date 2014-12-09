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
    
        self.name = dict[@"name"];                                      //  频道名
    
    }
    return self;
}

@end
