//
//  VideoTool.h
//  VLC
//
//  Created by sen5labs on 14-11-18.
//  Copyright (c) 2014年 sen5labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChannelModel;
@interface VideoTool : NSObject



/**
 *  返回所有的歌曲
 */
+ (NSArray *)videos;


+ (void)setVideos:(NSArray *)videos;


/**
 *  返回正在播放的歌曲
 */
+ (ChannelModel *)playingVideo;
+ (void)setPlayingVideo:(ChannelModel *)playingVideo;

/**
 *  下一首歌曲
 */
+ (ChannelModel *)nextVideo;

/**
 *  上一首歌曲
 */
+ (ChannelModel *)previousVideo;

@end
