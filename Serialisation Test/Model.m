//
//  Model.m
//  Serialisation Test
//
//  Created by Johnnie Walker on 09/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (id)model {
    Model *model = [Model new];
    model.UUID = [[NSUUID UUID] UUIDString];
    model.point = NSMakePoint(arc4random(), arc4random());
    model.rect = NSMakeRect(model.point.x, model.point.y, arc4random(), arc4random());
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.UUID forKey:@"UUID"];
    [aCoder encodeObject:NSStringFromPoint(self.point) forKey:@"point"];
    [aCoder encodeObject:NSStringFromRect(self.rect) forKey:@"rect"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (self) {
        self.UUID = [decoder decodeObjectForKey:@"UUID"];
        self.point = NSPointFromString([decoder decodeObjectForKey:@"point"]);
        self.rect = NSRectFromString([decoder decodeObjectForKey:@"rect"]);
    }
    return self;
}

- (NSDictionary *)dict {
    return @{
             @"UUID": self.UUID,
             @"point": NSStringFromPoint(self.point),
             @"rect": NSStringFromRect(self.rect)
             };
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary {
    Model *model = [Model new];
    model.UUID = [dictionary objectForKey:@"UUID"];
    model.point = NSPointFromString([dictionary objectForKey:@"point"]);
    model.rect = NSRectFromString([dictionary objectForKey:@"rect"]);     
    return model;
}


@end
