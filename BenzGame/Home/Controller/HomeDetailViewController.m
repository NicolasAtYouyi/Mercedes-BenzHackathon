//
//  HomeDetailViewController.m
//  BenzGame
//
//  Created by Nicolas on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
//    for (NSString *ziti in [UIFont familyNames]) {
//        if ([ziti hasPrefix:@"f"] || [ziti hasPrefix:@"F"] || [ziti hasPrefix:@"H"] || [ziti hasPrefix:@"h"]) {
//            NSLog(@"#%@#", ziti);
//        }
//        if ([ziti isEqualToString:@"icomoon"]) {
//            for (NSString *name in [UIFont fontNamesForFamilyName:ziti]) {
//                //                NSLog(@"  %@", name);
//            }
//        }
//    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
