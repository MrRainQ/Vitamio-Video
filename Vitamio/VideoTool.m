//
//  VideoTool.m
//  VLC
//
//  Created by sen5labs on 14-11-18.
//  Copyright (c) 2014年 sen5labs. All rights reserved.
//

#import "VideoTool.h"
#import "ChannelModel.h"

@implementation VideoTool
static NSArray *_videos;
static ChannelModel *_playingVideo;


/**
 *  返回所有的频道
 */
+ (NSArray *)videos
{
 
    return _videos;
}
/**
 *  设置所有频道
 */
+ (void)setVideos:(NSArray *)videos
{
    _videos = videos;
}

/**
 *  返回正在播放的频道
 */
+ (ChannelModel *)playingVideo
{
    return _playingVideo;
}


+ (void)setPlayingVideo:(ChannelModel *)playingVideo
{
    if (!playingVideo || ![[self videos] containsObject:playingVideo]) return;
    
    if (_playingVideo == playingVideo) return;
    
    _playingVideo = playingVideo;
}

/**
 *  下一频道
 */
+ (ChannelModel *)nextVideo
{
    int nextIndex = 0;
    if (_playingVideo) {
        int playingIndex = (int)[[self videos] indexOfObject:_playingVideo];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self videos].count) {
            nextIndex = 0;
        }
    }
    return [self videos][nextIndex];
}

/**
 *  上一频道
 */
+ (ChannelModel *)previousVideo
{
    int previousIndex = 0;
    if (_playingVideo) {
        int playingIndex = (int)[[self videos] indexOfObject:_playingVideo];
        previousIndex = playingIndex - 1;
        if (previousIndex < 0 ) {
            previousIndex = (int)[self videos].count - 1;
        }
    }
    return [self videos][previousIndex];
}
@end
