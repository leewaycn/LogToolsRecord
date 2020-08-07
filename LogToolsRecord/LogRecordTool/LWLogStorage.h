//
//  LWLogStorage.h
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LWLogStorageProtocol <NSObject>

-(NSString*)getCachePath;
-(BOOL)deleteFile:(NSString*)fileName;
-(BOOL)cleanCache;
-(NSData *)readFile:(NSString*)fileName;
-(BOOL)updateFile:(NSString*)fileName appendData:(NSData *)data;
-(NSString*)createFileName;
-(void)deleteOVerDueLog;



@end


static NSString * const CACHEPATH = @"LogStorage";
static NSString * const ARCHIVE_CACHE_PATH = @"LogStorageArchive";
static int  const THE_WHOLE_DAY_SECONDS = 86400;

@interface LWLogStorage : NSObject<LWLogStorageProtocol>
 
+(instancetype)share;

-(NSString*)getCachePath;
-(BOOL)deleteFile:(NSString*)fileName;
-(BOOL)cleanCache;
-(NSData *)readFile:(NSString*)fileName;
-(BOOL)updateFile:(NSString*)fileName appendData:(NSData *)data;
-(NSString*)createFileName;
-(void)deleteOVerDueLog;




@end

 
