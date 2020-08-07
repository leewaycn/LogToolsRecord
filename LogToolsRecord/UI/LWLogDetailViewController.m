//
//  LWLogDetailViewController.m
//  LogToolsRecord
//
//  Created by tql on 2020/8/7.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import "LWLogDetailViewController.h"

@interface LWLogDetailViewController ()

@property (nonatomic,strong)UITextView *contenView;


@end

@implementation LWLogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    NSError *error = nil;
    NSString *fileContent = [NSString stringWithContentsOfFile:self.logFilePath encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@",fileContent);

    self.contenView = [[UITextView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.contenView];
    self.contenView.text = fileContent;
    self.contenView.editable = NO;
    self.contenView.font = [UIFont systemFontOfSize:15];
    
    
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
