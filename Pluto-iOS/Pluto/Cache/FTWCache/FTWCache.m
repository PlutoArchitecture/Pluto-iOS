//
//  FTWCache.m
//  FTW
//
//  Created by Soroush Khanlou on 6/28/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import "FTWCache.h"
#import "Pluto.h"
static NSTimeInterval cacheTime =  (double)7200;
NSString *const NET_CACHE = @"netcache";
@implementation FTWCache

- (void) resetCache:(NSString *)filepath{
    [[NSFileManager defaultManager] removeItemAtPath:[self cacheDirectory:filepath] error:nil];
}

- (NSString*) cacheDirectory:(NSString *)filepath {
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",[Pluto getInstance].APP_CACHE_FILE,filepath]];
    //NSLog(@"cacheDirectory-->%@",cacheDirectory);
    return cacheDirectory;
}

- (void) deleteCacheFilePath:(NSString *) filepath filename:(NSString *) key{
    
    NSString *absolutefilename = [[self cacheDirectory:filepath] stringByAppendingPathComponent:key];
    [[NSFileManager defaultManager] removeItemAtPath:absolutefilename error:nil];
}

- (NSData*) objectForKey:(NSString*)key filepath:(NSString *)filepath{
    
    [self readyPathExist:filepath];
    
    //NSLog(@"缓存位置-->%@",[self cacheDirectory:filepath]);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [[self cacheDirectory:filepath] stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename])
    {
        NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
        if ([modificationDate timeIntervalSinceNow] > cacheTime) {
            [fileManager removeItemAtPath:filename error:nil];
        } else {
            NSData *data = [NSData dataWithContentsOfFile:filename];
            return data;
        }
    }
    return nil;
}

-(id) objectForKeyWithoutExpire:(NSString *)key filepath:(NSString *)filepath{
    
    [self readyPathExist:filepath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [[self cacheDirectory:filepath] stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename])
    {
        NSData *data = [NSData dataWithContentsOfFile:filename];
        return data;
        
    }
    return nil;
}
/**
 *  判断文件是否存在
 *
 *  @param key      缓存key
 *  @param filePath 缓存文件夹路径
 *
 *  @return 是或否
 */
-(BOOL) isExistFileWithKey:(NSString *)key filePath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [[self cacheDirectory:filePath] stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename])
    {
       
        return YES;
        
    }
    return NO;
}

//根据缓存是否过期获取缓存内容
-(NSData *) objectForKey:(NSString *) key cacheTimeSeconds:(int) cacheTime filepath:(NSString *)filepath{
    
    [self readyPathExist:filepath];
    
    
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * filename = [[self cacheDirectory:filepath] stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename]) {
        NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
        if (fabs([modificationDate timeIntervalSinceNow])>cacheTime) {
            [fileManager removeItemAtPath:filename error:nil];
        }else{
            NSData *data = [NSData dataWithContentsOfFile:filename];
            return data;
        }
    }
    return nil;
    
}

//根据缓存是否过期
-(BOOL) isExpiredWithKey:(NSString *) key cacheTimeMin:(NSInteger) cacheTime {
    
    [self readyPathExist:NET_CACHE];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * filename = [[self cacheDirectory:NET_CACHE] stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename]) {
        NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
        if (fabs([modificationDate timeIntervalSinceNow])>cacheTime*60) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
    
}

- (void) setObject:(NSData*)data forKey:(NSString*)key filepath:(NSString *)filepath{
    
    [self readyPathExist:filepath];
    
    NSString * filename = [[self cacheDirectory:filepath] stringByAppendingPathComponent:key];
    NSLog(@"缓存位置-->%@",filename);
    NSError *error;
    @try {
        [data writeToFile:filename options:NSDataWritingAtomic error:&error];

        //BOOL isSuccess = [data writeToFile:filename options:NSDataWritingAtomic error:&error];
        //NSLog(@"文件写入error-->%@isSuccess--%d",error,isSuccess);
    }
    @catch (NSException * e) {
        //NSLog(@"文件写入error-->%@",e.reason);
        
        //TODO: error handling maybe
    }
}

-(void)readyPathExist:(NSString *)pathsStr{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    
    if (![fileManager fileExistsAtPath:[self cacheDirectory:pathsStr] isDirectory:&isDir]) {
        
        if (![fileManager fileExistsAtPath:[self cacheDirectory:@""] isDirectory:&isDir]) {
            [fileManager createDirectoryAtPath:[self cacheDirectory:@""] withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSArray *paths = [pathsStr componentsSeparatedByString:@"/"];
        for (int i = 0; i<paths.count; i++) {
            NSString *addPath = @"";
            for (int j=0; j<=i; j++) {
                addPath = [addPath stringByAppendingPathComponent:paths[j]];
                NSLog(@"路径--->%@",addPath);
            }
            if (![fileManager fileExistsAtPath:[self cacheDirectory:addPath] isDirectory:&isDir]) {
                [fileManager createDirectoryAtPath:[self cacheDirectory:addPath] withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
    }else{
        
    }
    
}

-(NSString *) fileRelatvePathWithKey:(NSString *)key filePath:(NSString *) filePath {
	
    NSString *cacheDir = [self cacheDirectory:filePath];
    
    NSString * filename = [cacheDir stringByAppendingPathComponent:key];
    
    return filename;
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:[self cacheDirectory:folderPath]]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
   
    
}

- (float)readerCacheSize{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"Reader/"];
    
    if (![manager fileExistsAtPath:cacheDirectory]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cacheDirectory] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [cacheDirectory stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

-(void)saveData:(id)data key:(NSString *)key{
    if ([data isKindOfClass:[NSData class]]) {
        [self setObject:data forKey:key filepath:NET_CACHE];
    }else{
        [self setObject:[data dataUsingEncoding:NSUTF8StringEncoding] forKey:key filepath:NET_CACHE];
    }
}
    
-(id)queryData:(NSString *)key{
    
    NSData *data = [self objectForKey:key filepath:NET_CACHE];
    
    return data;
}
-(void)updateData:(id)data key:(NSString *)key{
    [self setObject:[data dataUsingEncoding:NSUTF8StringEncoding] forKey:key filepath:NET_CACHE];
}
-(void)deleteData:(NSString *)key{
    [self deleteCacheFilePath:NET_CACHE filename:key];
}

@end
