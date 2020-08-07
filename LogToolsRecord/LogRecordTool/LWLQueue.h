//
//  LWLQueue.h
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWLQueue : NSObject

@property (nonatomic,strong)NSMutableArray *logData;
@property (nonatomic,assign) int front;
@property (nonatomic,assign) int rear;
@property (nonatomic,assign) int maxsize;


@end

NS_ASSUME_NONNULL_END
