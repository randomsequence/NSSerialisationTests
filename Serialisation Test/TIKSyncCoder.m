//
//  TIKSyncCoder.m
//  Serialisation Test
//
//  Created by Johnnie Walker on 10/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "TIKSyncCoder.h"

@implementation TIKSyncCoder
+(NSString*)encodeURLParam:(NSString*)unencodedString {
    if(!unencodedString) return@"";
    NSString* str = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                          (CFStringRef)unencodedString,
                                                                                          NULL,
                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                          kCFStringEncodingUTF8));
    return str;
}


+(NSString*)newLogTxnWithType:(NSString*)txnType andKVPairs:(NSDictionary*)dict
{
    NSMutableString* txnStr = [NSMutableString new];
    if(txnType) [txnStr appendString:txnType];
    [txnStr appendString:@":"];
    
    BOOL firstItem = TRUE;
    for(id key in dict) {
        if(firstItem) {
            firstItem = FALSE;
        } else {
            [txnStr appendString:@"&"];
        }
        
        NSString* val = [dict objectForKey:key];
        [txnStr appendString:[self encodeURLParam:key]];
        [txnStr appendString:@"="];
        [txnStr appendString:[self encodeURLParam:val]];
    }
    [txnStr appendString:@"\n"];
    return txnStr;
}


/*
 parses the given URL-formatted key-value pairs into an NSDictionary. Returns TRUE iff
 there was anything to parse from the given string.
 */
+(BOOL)parseKVPairsFromString:(NSString*)kvString intoDict:(NSMutableDictionary*)dict
{
    kvString = [kvString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(!kvString || [kvString length]<=0) return FALSE;
    
    NSArray* pairs = [kvString componentsSeparatedByString:@"&"];
    for(NSString* pair in pairs) {
        NSRange eqRange = [pair rangeOfString:@"="];
        
        if(eqRange.location==NSNotFound) {
            NSString* key = [[pair
                              stringByReplacingOccurrencesOfString:@"+" withString:@" "]
                             stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [dict setObject:@"" forKey:key];
        } else {
            NSString* key = [[[pair substringToIndex:eqRange.location]
                              stringByReplacingOccurrencesOfString:@"+" withString:@" "]
                             stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString* val = [[[pair substringFromIndex:eqRange.location+1]
                              stringByReplacingOccurrencesOfString:@"+" withString:@" "]
                             stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if(!val || !key) {
                NSLog(@"got nil value (%@) or key (%@) in line %@", val, key, pairs);
            } else {
                [dict setObject:val forKey:key];
            }
        }
    }
    return TRUE;
}

@end
