//
//  LWLogQueue.h
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWLQueue.h"

//struct LQueue {
//    template logData[];
//    int front;
//    int rear;
//    int maxsize;
//}



@protocol LWQueueProtocol <NSObject>

-(void)createQueue;
-(void)traverseQueue;
-(BOOL)isFullQueue;
-(BOOL)isEmptyQueue;
-(BOOL)EnQueue:(NSString*)log;
-(BOOL)DeQueue;

@end






@interface LWLogQueue : NSObject<LWQueueProtocol>

+(instancetype)defaultQueue;
@property (nonatomic,strong)LWLQueue *queue;
@property (nonatomic,assign) int maxsize;



-(void)createQueue;
-(void)traverseQueue;
-(BOOL)isFullQueue;
-(BOOL)isEmptyQueue;
-(BOOL)EnQueue:(NSString*)log;
-(BOOL)DeQueue;



@end

 
