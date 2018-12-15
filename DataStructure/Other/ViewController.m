//
//  ViewController.m
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //并不会执行dowork,因为子线程的runloop默认是未启动的
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dowork) userInfo:nil repeats:YES];
    });
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(dowork)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    self.view.layer.contents = (__bridge id)[UIImage new].CGImage;
}

- (void)dowork {
    NSLog(@"working...");
}

@end



