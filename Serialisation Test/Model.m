//
//  Model.m
//  Serialisation Test
//
//  Created by Johnnie Walker on 09/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "Model.h"

NSString * const UUIDKey = @"UUID";
NSString * const PointKey = @"point";
NSString * const RectKey = @"rect";

@implementation Model

+ (id)model {
    Model *model = [Model new];
    model.UUID = [[NSUUID UUID] UUIDString];
    model.point = NSMakePoint(arc4random(), arc4random());
    model.rect = NSMakeRect(model.point.x, model.point.y, arc4random(), arc4random());
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if ([aCoder allowsKeyedCoding]) {
        [aCoder encodeObject:self.UUID forKey:UUIDKey];
        [aCoder encodePoint:self.point forKey:PointKey];
        [aCoder encodeRect:self.rect forKey:RectKey];
    } else {
        [aCoder encodeObject:self.UUID];
        [aCoder encodePoint:self.point];
        [aCoder encodeRect:self.rect];
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        if ([decoder allowsKeyedCoding]) {
            self.UUID = [decoder decodeObjectForKey:UUIDKey];
            self.point = [decoder decodePointForKey:PointKey];
            self.rect = [decoder decodeRectForKey:RectKey];
        } else {
            self.UUID = [decoder decodeObject];
            self.point = [decoder decodePoint];
            self.rect = [decoder decodeRect];
        }
    }
    return self;
}

- (NSDictionary *)dict {
    return @{
             UUIDKey: self.UUID,
             PointKey: NSStringFromPoint(self.point),
             RectKey: NSStringFromRect(self.rect)
             };
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary {
    Model *model = [Model new];
    model.UUID = [dictionary objectForKey:UUIDKey];
    model.point = NSPointFromString([dictionary objectForKey:PointKey]);
    model.rect = NSRectFromString([dictionary objectForKey:RectKey]);     
    return model;
}


@end
