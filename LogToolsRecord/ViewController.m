//
//  ViewController.m
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import "ViewController.h"

#import "LWLogObjcConst.h"


@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    for (int i = 0; i<10; i++) {
        
        [LWLogGenerator debug:self.class  :@"debug" :__LINE__ :[NSString stringWithFormat:@"%s", __func__] ];
        [LWLogGenerator info:self.class  :@"debug" :__LINE__ :[NSString stringWithFormat:@"%s", __func__] ];
        [LWLogGenerator warning:self.class  :@"debug" :__LINE__ :[NSString stringWithFormat:@"%s", __func__] ];
        [LWLogGenerator error: self.class  :@"debug" :__LINE__ :[NSString stringWithFormat:@"%s", __func__] ];
        
    }
    
    NSLog(@"%@",[LWLogStorage share].getCachePath);
    
    
}


@end
