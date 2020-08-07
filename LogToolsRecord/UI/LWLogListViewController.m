//
//  LWLogListViewController.m
//  LogToolsRecord
//
//  Created by tql on 2020/8/7.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import "LWLogListViewController.h"
#import "LWLogObjcConst.h"
#import "LWLogDetailViewController.h"

@interface LWLogListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) UITableView *lsitTableView;

@property (nonatomic,strong)NSMutableArray *list;

@end

@implementation LWLogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initUI];
    NSString *cachePath = [[LWLogStorage share]getCachePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    NSArray *tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:cachePath error:nil]];
    
    NSLog(@"tempFileList:%@",tempFileList);
    
    self.list = [NSMutableArray arrayWithArray:tempFileList];
    
    [self.lsitTableView reloadData];
}

-(void)initUI{
    self.lsitTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.lsitTableView];
    self.lsitTableView.delegate = self;
    self.lsitTableView.dataSource = self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xx"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"xx"];
    }
    cell.textLabel.text = self.list [indexPath.row];
    
    
    UIButton *sharebtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 10, 80, 30)];
    sharebtn.backgroundColor = [UIColor redColor];
    [sharebtn setTitle:@"share" forState:UIControlStateNormal];
    sharebtn.tag = 100+indexPath.row;
    [cell addSubview:sharebtn];
    [sharebtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)shareAction:(UIButton*)btn{
    
    NSInteger row = btn.tag - 100;
    
    NSString *text = self.list[row];
    NSString *strURL = [[[LWLogStorage share] getCachePath] stringByAppendingPathComponent:self.list[row]] ;
    NSURL *fileURL = [NSURL fileURLWithPath:strURL];
    
    
    NSArray *activityItems = @[text,fileURL];
    
    // 服务类型控制器
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.modalInPopover = true;
    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)])
    {
        activityViewController.popoverPresentationController.sourceView = self.view;
    }
    
    [self presentViewController:activityViewController animated:YES completion:nil];
    
    // 选中分享类型
    [activityViewController setCompletionWithItemsHandler:^(UIActivityType  __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
        // 显示选中的分享类型
        NSLog(@"act type %@",activityType);
        
        if (completed) {
            NSLog(@"ok");
            
            if (activityType==UIActivityTypeCopyToPasteboard) {
             }else{
            
              
            }
        }else {
            NSLog(@"no ok");
         
        }
        
    }];
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWLogDetailViewController *vc =[LWLogDetailViewController new];
    vc.logFilePath  = [[[LWLogStorage share] getCachePath] stringByAppendingPathComponent:self.list[indexPath.row]];
    [self presentViewController:vc animated:YES completion:nil];

    
}





 

@end
