//
//  YZPlayVideoViewController.m
//  Demo
//
//  Created by administrator on 2020/7/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZPlayVideoViewController.h"
#import <AVFoundation/AVFoundation.h> // 基于AVFoundation,通过实例化的控制器来设置player属性

#import <AVKit/AVKit.h>  // 1. 导入头文件  iOS 9 新增


@interface YZPlayVideoViewController ()
@property (nonatomic, strong)AVPlayer *avplayer;
@end

@implementation YZPlayVideoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIButton * btn = [[UIButton alloc]initWithFrame:self.view.frame];
    
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点击播放" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];
    
       //读取本地视频路径
       NSString *path = [[NSBundle mainBundle] pathForResource:@"开屏页竖版改" ofType:@"m4v"];
        //为即将播放的视频内容进行建模
        AVPlayerItem *avplayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
    //创建监听（这是一种KOV的监听模式）
        [avplayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
        //给播放器赋值要播放的对象模型
        AVPlayer *avplayer = [AVPlayer playerWithPlayerItem:avplayerItem];
    //指定显示的Layer
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.bounds;
        [self.view.layer addSublayer:layer];
    [layer.player play];
    self.avplayer = avplayer;
    [self addNotification];
    
}

- (void)dealloc {
    [self removeNotification];
}
/**
 *  添加播放器通知，通过AVPlayerItemDidPlayToEndTimeNotification字段判断播放器播放情况
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avplayer.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.avplayer seekToTime:CMTimeMake(0, 1)];
    [self.avplayer play];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [self.avplayer play];
}
- (void)viewDidDisappear:(BOOL)animated {
    [self.avplayer pause];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    AVPlayerItem *item = object;
    //判断监听对象的状态
    if ([keyPath isEqualToString:@"status"]) {
    
        if (item.status == AVPlayerItemStatusReadyToPlay) {//准备好的
            NSLog(@"AVPlayerItemStatusReadyToPlay");
        } else if(item.status ==AVPlayerItemStatusUnknown){//未知的状态
           NSLog(@"AVPlayerItemStatusUnknown");
        }else if(item.status ==AVPlayerItemStatusFailed){//有错误的
            NSLog(@"AVPlayerItemStatusFailed");
        }
        
    }
    
}

-(void)btnClick{
    // 本地资源文件
NSString *filePath = [[NSBundle mainBundle]pathForResource:@"开屏页竖版改.m4v" ofType:nil];
// 2. 创建视频播放控制器
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    // 3. 设置视频播放器 (这里为了简便,使用了URL方式,同样支持playerWithPlayerItem:的方式)
    playerViewController.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
//    [playerViewController.player play];
//    [self.view addSubview:playerViewController.view];

    // 4. modal展示
    
    [self presentViewController:playerViewController animated:YES completion:^{
        
        [playerViewController.player play];
        
    }];

}

@end
