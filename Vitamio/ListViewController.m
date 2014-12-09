//
//  ListViewController.m
//  VLC
//
//  Created by sen5labs on 14-11-13.
//  Copyright (c) 2014年 sen5labs. All rights reserved.
//

#import "ListViewController.h"
#import "VideoTool.h"
#import "ChannelModel.h"
#import "MJRefresh.h"

#import "PlayViewController.h"
@interface ListViewController ()
@property (nonatomic,strong) NSMutableArray *medias;
@end

@implementation ListViewController

- (NSMutableArray *)medias
{
    if (!_medias) {
        // 播放列表
        NSMutableArray *medias = [NSMutableArray array];
        for (int i = 0; i<=16; i++) {
            NSString *bundleName = [NSString stringWithFormat:@"minion_0%d.mp4",i % 5 + 1];
            ChannelModel *chan = [[ChannelModel alloc]init];
            chan.name = bundleName;
            [medias addObject:chan];
        }
        self.medias = medias;
    }
    return _medias;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // 2.集成刷新控件
    [self setupRefresh];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [VideoTool setVideos:self.medias];
    return self.medias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    ChannelModel *ch = self.medias[indexPath.row];
    cell.textLabel.text = ch.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [VideoTool setPlayingVideo:[VideoTool videos][indexPath.row]];

    PlayViewController *player = [[PlayViewController alloc]init];
    [self presentViewController:player animated:NO completion:nil];
}




#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        NSString *bundleName = [NSString stringWithFormat:@"minion_0%d.mp4",i % 5 + 1];
        ChannelModel *chan = [[ChannelModel alloc]init];
        chan.name = bundleName;
        [self.medias insertObject:chan atIndex:0];
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        NSString *bundleName = [NSString stringWithFormat:@"minion_0%d.mp4",i % 5 + 1];
        ChannelModel *chan = [[ChannelModel alloc]init];
        chan.name = bundleName;
        [self.medias addObject:chan];
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}



@end
