//
//  LWLogGenerator.h
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LWDebugLevel) {
    LWDLevelDebug,
    LWDLevelInfo,
    LWDLevelWarning,
    LWDLevelError
};
typedef NS_ENUM(NSUInteger, LWOperateType) {
    LWONetwork,
    LWONative
};

NS_ASSUME_NONNULL_BEGIN

@interface LWLogGenerator : NSObject

+(void)debug:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function ;
+(void)info:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function ;
+(void)warning:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function ;
+(void)error:(Class)targetClass :(NSString*)content :(int)line :(NSString*)function ;

@end

NS_ASSUME_NONNULL_END
