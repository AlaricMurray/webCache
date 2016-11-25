//
//  ViewController.m
//  网络缓存
//
//  Created by MyMac on 2016/11/11.
//  Copyright © 2016年 hengshuimofangkeji. All rights reserved.
//

#import "ViewController.h"
#import "MyRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"21");
    self.view.backgroundColor = [UIColor whiteColor];
    [MyRequest GET:@"http://www.zimozibao.com:8080/zimoAppWS/cxf/rest/kecheng/getallKecheng?_type=json&index=1&size=20" CacheTime:60 isLoadingView:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
