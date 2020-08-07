//
//  LWLogStorage.m
//  LogToolsRecord
//
//  Created by tql on 2020/8/6.
//  Copyright © 2020 tqlLW. All rights reserved.
//

#import "LWLogStorage.h"

@interface LWLogStorage ()

@property (nonatomic,strong)NSFileManager *fileManager;

@end

@implementation LWLogStorage

+(instancetype)share{
    static LWLogStorage *snil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snil = [[self alloc]init];
    });
    return snil;
}
-(NSString*)getCachePath{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    if ([cacheDir hasSuffix:@"/"]) {
       cacheDir =  [cacheDir stringByAppendingString:@"/"];
    }
    cacheDir = [NSString stringWithFormat:@"%@%@%@",cacheDir,CACHEPATH,@"/"];
    return cacheDir;
}

-(NSFileManager*)fileManager{
    return [NSFileManager defaultManager];
}

-(NSString*)createFileName{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *fileName = [formatter stringFromDate:[NSDate date]] ;
    fileName = [fileName stringByAppendingString:@".txt"];
    return fileName;
}
-(BOOL)deleteFile:(NSString *)filePath{
    if (![self filePathExits:filePath]) {
        return YES;
    }
    @try {
        [self.fileManager removeItemAtPath:filePath error:nil];
    } @catch (NSException *exception) {
        return NO;
    }
    return YES;
}
-(NSData*)readFile:(NSString *)fileName{
    
    
    if (![self getFilePathIffileExists:fileName]) {
        return nil;
    }
    
    return [self readFileFromeCache:[self getFilePathIffileExists:fileName]];
}
-(NSData*)readFileFromeCache:(NSString*)path{
    
    return nil;;
}

-(NSString*)getFilePathIffileExists:(NSString*)fileName{
    NSString *cachePath = [self getCachePath];
    if (![self dirExists:cachePath]) {
        return nil;
    }
    NSString *filePath = [cachePath stringByAppendingString:fileName];
    return [self filePathExits:filePath]?filePath:nil;
}
-(BOOL)filePathExits:(NSString*)path{
    return [self dirExists:path];
}
-(BOOL)dirExists:(NSString *)dir{
    return [self.fileManager fileExistsAtPath:dir];
}
-(NSString*)getArchivePath{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    if (![cacheDir hasSuffix:@"/"]) {
        cacheDir = [cacheDir stringByAppendingString:@"/"];
    }
    return cacheDir;
}
-(void)deleteOVerDueLog{
    NSString *path = [self getCachePath];
    NSError *error = nil;
    NSArray *listArray = [self.fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        
        NSLog(@"%@",error);
    }else{
        NSArray *shouldDeleteList = [self shouldDeleteFileList:listArray];
        for (NSString *fileName in shouldDeleteList) {
            [self deleteFile:fileName];
            NSLog(@"delete:%@",fileName);
        }
        
    }
    
}
-(NSArray*)shouldDeleteFileList:(NSArray *)fileLst{
    NSMutableArray *shouldDeleteList =[NSMutableArray array];
    for (NSString *fileName in fileLst) {
        
        if ([fileName rangeOfString:@"."].location!= NSNotFound) {
            NSString *fileSimpleName = [fileName componentsSeparatedByString:@"."].firstObject;
            if (fileSimpleName==nil) {
                continue;
            }
            if ([self checkFileIsOverDue:fileSimpleName]) {
                [shouldDeleteList addObject:fileName];
            }
            
        }
    }
    
    return shouldDeleteList.copy;
}
-(BOOL)checkFileIsOverDue:(NSString*)dateStr{
    NSDateFormatter *formater = [NSDateFormatter new];
    formater.dateFormat = @"yyyy-MM-dd";
    NSDate *fileDate = [formater dateFromString:dateStr];
    NSTimeInterval fileTimestamp = [fileDate timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    if (now - fileTimestamp > THE_WHOLE_DAY_SECONDS*7) {
        return YES;
    }
    return NO;;
}


-(BOOL)updateFile:(NSString *)fileName appendData:(NSData *)data{
    NSString *filePath = [self getFilePathIffileExists:fileName];
    if (!filePath) {
    
         [self createFilePathIfNotExits:fileName];
        
        return [self writeFile:fileName appendData:data];
        return NO;
        
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    
//    fileHandle.seekToEndOfFile()
//    fileHandle.write(data)
//    fileHandle.closeFile()

    [fileHandle seekToEndOfFile];
    NSError *error = nil;
    
    [fileHandle writeData:data error:&error];
    [fileHandle closeFile];
    if (!error) {
        return YES;
    }
    
    
    return NO;
    
}

-(BOOL)writeFile:(NSString*)fileName appendData:(NSData*)data{
    NSString *filePath = [self createFilePathIfNotExits:fileName];
    if (!filePath) {
        return NO;
    }
    @try {
        [data writeToURL:[NSURL fileURLWithPath:filePath] atomically:YES];
    } @catch (NSException *exception) {
        return NO;
    }
    return YES;
}

-(BOOL)createDir:(NSString*)dir{
    NSError *error = nil;
    [self.fileManager createDirectoryAtURL:[NSURL fileURLWithPath:dir] withIntermediateDirectories:YES attributes:nil error:&error];
    if (!error) {
        return YES;
    }
    
    return NO;
}
-(NSString*)createFilePathIfNotExits:(NSString*)fileName{
    NSString *cachePath = [self getCachePath];
    if (![self dirExists:cachePath] && ![self createDir:cachePath   ]) {
        
        return nil;
    }
    if (fileName.length==0) {
        return nil;
    }
    
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    if ([self filePathExits:filePath]) {
        
        NSError *error =nil;
        
        [self.fileManager removeItemAtPath:filePath error:&error];
        if (error) {
            return nil;
        }
    }
    return filePath;
}


@end
