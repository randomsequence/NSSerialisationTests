//
//  TIKSyncCoder.h
//  Serialisation Test
//
//  Created by Johnnie Walker on 10/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIKSyncCoder : NSObject

+(BOOL)parseKVPairsFromString:(NSString*)kvString intoDict:(NSMutableDictionary*)dict;
+(NSString*)newLogTxnWithType:(NSString*)txnType andKVPairs:(NSDictionary*)dict;
@end
