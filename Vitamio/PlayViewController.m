//
//  PlayViewController.m
//  VLC
//
//  Created by sen5labs on 14-11-12.
//  Copyright (c) 2014年 sen5labs. All rights reserved.
//

#import "PlayViewController.h"
#import "VideoTool.h"
#import "ChannelModel.h"
#import "UIView+RQ.h"
#import "Vitamio.h"


@interface PlayViewController ()<VMediaPlayerDelegate>
@property (nonatomic, copy)   NSURL *videoURL;

@property (weak, nonatomic) IBOutlet UIView *movieView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *activityView ;

@property (nonatomic,strong) VMediaPlayer *mediaPlayer;

@property (nonatomic,assign) BOOL isPlay;
@property (nonatomic,assign) BOOL isRotation;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)  NSTimer *stateTimer;
@property (nonatomic,strong) ChannelModel *playingVideo;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator; // 加载指示器


@end

@implementation PlayViewController

#pragma mark - 懒加载
- (VMediaPlayer *)mediaPlayer
{
    if (!_mediaPlayer) {
        _mediaPlayer = [VMediaPlayer sharedInstance];
        [_mediaPlayer setupPlayerWithCarrierView:self.movieView withDelegate:self];
    }
    return _mediaPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                              UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    
    [self playVideo];
    
    [self addTimer];
    
    [self addStateTimer];
}


#pragma mark - 播放状态监听器
- (void)addStateTimer
{
    self.stateTimer = [NSTimer timerWithTimeInterval:0.5f target:self selector:@selector(monitorPlayStates) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.stateTimer forMode:NSRunLoopCommonModes];
}

- (void)monitorPlayStates
{
    if ([self.mediaPlayer isPlaying]) {
        [self removeStateTimer];
        [self.activityIndicator stopAnimating];
    }else{
        [self.activityIndicator startAnimating];
    }
}

- (void)removeStateTimer
{
    [self.stateTimer invalidate];
    self.stateTimer = nil;
}


- (void)quicklyReplayMovie:(NSURL*)fileURL
{
    [self.mediaPlayer reset];
    [self quicklyPlayMovie:fileURL];
}


#pragma mark - Convention Methods
-(void)quicklyPlayMovie:(NSURL*)fileURL
{
	NSString *abs = [fileURL absoluteString];
	if ([abs rangeOfString:@"://"].length == 0) {
		NSString *docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
		NSString *videoUrl = [NSString stringWithFormat:@"%@/%@", docDir, abs];
		self.videoURL = [NSURL fileURLWithPath:videoUrl];
	} else {
		self.videoURL = fileURL;
	}
    [self.mediaPlayer setDataSource:fileURL header:nil];
    [self.mediaPlayer prepareAsync];
}

//#pragma mark - VMediaPlayerDelegate Implement
#pragma mark VMediaPlayerDelegate Implement / Required
- (void)mediaPlayer:(VMediaPlayer *)player didPrepared:(id)arg
{
	[player setVideoFillMode:VMVideoFillModeStretch];
    [player start];
}

#pragma mark VMediaPlayerDelegate Implement / Optional
- (void)mediaPlayer:(VMediaPlayer *)player setupPlayerPreference:(id)arg
{
    [player setBufferSize:512*1024];
    
	[player setVideoQuality:VMVideoQualityHigh];
    
    player.useCache = YES;
	[player setCacheDirectory:[self getCacheRootDirectory]];
}

- (NSString *)getCacheRootDirectory
{
	NSString *cache = [NSString stringWithFormat:@"%@/Library/Caches/MediasCaches", NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cache]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache
								  withIntermediateDirectories:YES
												   attributes:nil
														error:NULL];
    }
	return cache;
}

- (void)mediaPlayer:(VMediaPlayer *)player setupManagerPreference:(id)arg{}

- (void)mediaPlayer:(VMediaPlayer *)player playbackComplete:(id)arg{}

- (void)mediaPlayer:(VMediaPlayer *)player error:(id)arg{}
//******************************************************************************
#pragma mark - 播放器按钮的控制操作
#pragma make 播放
- (void)playVideo
{
    self.playingVideo = [VideoTool playingVideo];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.playingVideo.name withExtension:nil];
 
    [self quicklyReplayMovie:url];
}

#pragma mark 开始暂停
- (IBAction)startPauseBtnClick:(UIButton *)sender {

    sender.selected = !sender.selected;
	if ([self.mediaPlayer isPlaying]) {
        [self.mediaPlayer pause];
	} else {
		[self.mediaPlayer start];
	}
}


#pragma mark 上一台
- (IBAction)prevChannelAction:(UIButton *)sender {
    
    [self.mediaPlayer reset];
    
     [VideoTool setPlayingVideo:[VideoTool previousVideo]];
    
     [self addStateTimer];
    
     [self playVideo];

}

#pragma mark 下一台
- (IBAction)nextChannelAction:(UIButton *)sender{
   
    [self.mediaPlayer reset];

     [VideoTool setPlayingVideo:[VideoTool nextVideo]];
   
     [self addStateTimer];
    
     [self playVideo];

}

#pragma mark  横竖屏切换
- (IBAction)fullScreen:(UIButton *)sender{
    
 
}

// top 和 bottom 部分的控制
#pragma mark - 时间计时器
- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:10.f target:self selector:@selector(hiddenTopAndBottomView) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)hiddenTopAndBottomView
{
    [UIView animateWithDuration:.2f animations:^{
        self.topView.alpha = 0.0f;
        self.bottomView.alpha = 0.0f;
    }completion:^(BOOL finished) {
        [self removeTimer];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.topView.alpha == 0.0f) {
        self.topView.alpha = 1.0f;
        self.bottomView.alpha = 1.0f;
        [self addTimer];
    }else{
        self.topView.alpha = 0.0f;
        self.bottomView.alpha = 0.0f;
    }
}

@end
