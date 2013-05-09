//
//  Model.h
//  Serialisation Test
//
//  Created by Johnnie Walker on 09/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject <NSCoding>
@property (nonatomic) NSRect rect;
@property (nonatomic) NSPoint point;
@property (nonatomic, copy) NSString *UUID;

+ (id)model;
- (NSDictionary *)dict;
+ (id)modelWithDictionary:(NSDictionary *)dictionary;

@end
