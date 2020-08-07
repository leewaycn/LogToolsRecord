//
//  LWLogGenerator.m
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import "LWLogGenerator.h"
#import "LWLogQueue.h"

@interface NSDate (ext)
-(NSString*)toString;
@end
@implementation NSDate (ext)

-(NSString*)toString{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:self];
}

@end

//@interface NSObject (clasnameext)
//@end




@implementation LWLogGenerator

+(void)debug:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function {
  NSString *log =   [self createLog:LWDLevelDebug :targetClass :LWONative :content :line :function];
    
    [self EnQueue:log];
    
}

+(void)info:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function {
   NSString *log =  [self createLog:LWDLevelInfo :targetClass :LWONative :content :line :function];
    
    [self EnQueue:log];

}

+(void)warning:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function {
   NSString *log =  [self createLog:LWDLevelWarning :targetClass :LWONative :content :line :function];
    
    [self EnQueue:log];

}

+(void)error:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function {
   NSString *log =  [self createLog:LWDLevelError :targetClass :LWONative :content :line :function];
    [self EnQueue:log];

}

+(NSString*)createLog:(LWDebugLevel)level :(Class)targetClass :(LWOperateType)type :(NSString*)content  :(int)line :(NSString*)function {
    NSString *lineStr = [NSString stringWithFormat:@"line:%d",line];
    NSString *levelStr = [self levelToString:level];
    NSString *seperator = @"|";
    NSString *classSeperator = @"_";
    NSString *log = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@\n",
                     [[NSDate date] toString ],seperator,levelStr,seperator,NSStringFromClass(targetClass),
                     classSeperator,function,classSeperator,lineStr,seperator,content];
    NSLog(@"log::%@",log);
    
    return log;
    
}
+(NSString*)levelToString:(LWDebugLevel)level{
    NSString *levelStr = @"Debug";
    switch (level) {
        case LWDLevelDebug:
            levelStr = @"Debug";
            break;

            case LWDLevelInfo:
                levelStr = @"Info";
                break;
            
        case LWDLevelWarning:
                levelStr = @"Warning";
                break;
            
        case LWDLevelError:
            levelStr = @"Error";
            break;
            
        default:
            break;
    }
    return levelStr;
}

+(BOOL)EnQueue:(NSString*)log{
   return  [[LWLogQueue defaultQueue] EnQueue:log];
}




@end

