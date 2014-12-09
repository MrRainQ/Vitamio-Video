//
//  ChannelModel.h
//  NesTV
//
//  Created by sen5labs on 14-8-21.
//  Copyright (c) 2014年 linger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

@property (nonatomic,copy) NSString *name;  


- (id)initWithDict:(NSDictionary *)dict;
@end
