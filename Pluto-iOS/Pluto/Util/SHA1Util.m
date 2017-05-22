//
//  SHA1Util.m
//  Reader
//
//  Created by minggo on 16/7/11.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "SHA1Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SHA1Util

+(NSString *) getSHA1Pass:(NSString *)pass {
    const char *cstr = [pass cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:pass.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
