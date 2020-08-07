//
//  LWLogQueue.m
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import "LWLogQueue.h"
#import "LWLogStorage.h"

@implementation LWLogQueue


+(instancetype)defaultQueue{
    static LWLogQueue *dque = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dque =[[self alloc]init];
        dque.maxsize = 11;
        
        [dque createQueue];
    });
    return dque;
}

-(void)createQueue{
    self.queue = [[LWLQueue alloc]init];
    self.queue.logData= [NSMutableArray array];
    for (int i =0; i<self.maxsize; i++) {
        [self.queue.logData addObject:@""];
    }
    self.queue.front = 0;
    self.queue.rear = 0;
    self.queue.maxsize = self.maxsize;
}
-(void)traverseQueue{
    int i = self.queue.front;
    NSLog(@"队列中的元素是:\n");
    while (i !=self.queue.rear) {
        NSLog(@"元素:%d = %@",i,self.queue.logData[i]);
        i++;
        i = i % self.maxsize;
    }
}
-(BOOL) isFullQueue{
    if (self.queue.front==((self.queue.rear+1)%self.queue.maxsize)) {
        return YES;
    }
    return NO;
}
-(BOOL)isEmptyQueue{
    if (self.queue.front==self.queue.rear) {
        return YES;
    }
    return NO;
}

-(int)getLength{
    
    return (self.queue.rear- self.queue.front+self.queue.maxsize )% self.queue.maxsize;
}
-(BOOL)EnQueue:(NSString *)log{
    if (self.isFullQueue) {
        NSLog(@"队列已满，插入失败");
        [self updateFileWhenTranverse];
    }
    [self.queue.logData replaceObjectAtIndex:self.queue.rear withObject:log];
    self.queue.rear = (self.queue.rear+1)%self.queue.maxsize;
    return YES;
}

-(BOOL)DeQueue{
    if (self.isEmptyQueue) {
        return NO;
    }
    [self.queue.logData replaceObjectAtIndex:self.queue.front withObject:@""];
    self.queue.front = (self.queue.front +1) %self.queue.maxsize;
    return YES;
}

-(void)updateFileWhenTranverse{
    int i = self.queue.front;
    while (i != self.queue.rear) {
        NSString *fileName = [[LWLogStorage share] createFileName];
        NSString *logStr = self.queue.logData[i];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        BOOL updateFlag = [[LWLogStorage share]updateFile:fileName appendData:data];
        if (updateFlag) {
            [self DeQueue];
        }
        i+=1;
        i = i % self.maxsize;
    }
}


@end
