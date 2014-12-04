//
//  PlayViewController.h
//  VLC
//
//  Created by sen5labs on 14-11-12.
//  Copyright (c) 2014年 sen5labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlayViewDelegate <NSObject>

- (void)rotateScreen:(BOOL)isRotate;

@end

@interface PlayViewController : UIViewController

@property (nonatomic,weak) id <PlayViewDelegate>delegate;

@end
