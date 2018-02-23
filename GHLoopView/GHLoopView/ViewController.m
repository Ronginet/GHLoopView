//
//  ViewController.m
//  GHLoopView
//
//  Created by Rong on 2017/10/24.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "ViewController.h"
#import "GHLoopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<3; i++) {
//        NSLog(@"%@",[NSString stringWithFormat:@"%.2d.jpg",i + 1]);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%.2d.jpg",i + 1]];
        [array addObject:image];
    }
    
    GHLoopView *loopView = [[GHLoopView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100)];
//    loopView.frame = CGRectMake(0, 64, self.view.frame.size.width, 100);
    loopView.images = array.copy;
    [self.view addSubview:loopView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
