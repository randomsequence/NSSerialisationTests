//
//  Serialisation_TestTests.m
//  Serialisation TestTests
//
//  Created by Johnnie Walker on 09/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "Serialisation_TestTests.h"
#import "Model.h"

#define ITERATIONS 100000

@interface Serialisation_TestTests ()
@property (nonatomic, strong) NSArray *models;
@end

@implementation Serialisation_TestTests

- (void)setUp {
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (NSInteger i=0; i<ITERATIONS; i++) {
        [models addObject:[Model model]];
    }
    self.models = models;
}

- (void)tearDown {
    self.models = nil;
}

- (void)testNSCodingAll {
    NSDate *startDate = [NSDate date];
    
    NSArray *models = self.models;
    
    NSData *data = [NSArchiver archivedDataWithRootObject:models];
    
    NSDate *endDate = [NSDate date];
    NSLog(@"NSArchiver all: %li duration: %f", (unsigned long)[models count], [endDate timeIntervalSinceDate:startDate]);
    
    [data writeToFile:[[NSString stringWithFormat:@"~/Desktop/%@.dat", NSStringFromSelector(_cmd)] stringByExpandingTildeInPath] atomically:NO];
}

- (void)testNSCoding
{
    NSDate *startDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [array addObject:[NSArchiver archivedDataWithRootObject:model]];
    }
    NSMutableArray *models1 = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (NSData *data in array) {
        [models1 addObject:[NSUnarchiver unarchiveObjectWithData:data]];
    }    
    NSDate *endDate = [NSDate date];
    
    NSLog(@"NSArchiver models: %li duration: %f", (unsigned long)[models1 count], [endDate timeIntervalSinceDate:startDate]);
}

- (void)testNSKeyedCodingAll {
    NSDate *startDate = [NSDate date];
    
    NSArray *models = self.models;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:models];
    
    NSDate *endDate = [NSDate date];
    NSLog(@"NSKeyedArchiver all: %li duration: %f", (unsigned long)[models count], [endDate timeIntervalSinceDate:startDate]);
    
    [data writeToFile:[[NSString stringWithFormat:@"~/Desktop/%@.dat", NSStringFromSelector(_cmd)] stringByExpandingTildeInPath] atomically:NO];
}

- (void)testNSKeyedCoding
{
    NSDate *startDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [array addObject:[NSKeyedArchiver archivedDataWithRootObject:model]];
    }
    NSMutableArray *models1 = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (NSData *data in array) {
        [models1 addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    NSDate *endDate = [NSDate date];
    
    NSLog(@"NSKeyedArchiver models: %li duration: %f", (unsigned long)[models1 count], [endDate timeIntervalSinceDate:startDate]);
}


- (void)testPropertyListSerialisation
{
    NSDate *startDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [array addObject:[NSPropertyListSerialization dataWithPropertyList:[model dict] format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil]];
    }
    NSMutableArray *models1 = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (NSData *data in array) {
        [models1 addObject:
         [Model modelWithDictionary:
          [NSPropertyListSerialization propertyListWithData:data
                                                    options:NSPropertyListImmutable
                                                     format:NULL
                                                      error:nil]]];
    }
    NSDate *endDate = [NSDate date];
    
    NSLog(@"NSPropertyListSerialization models: %li duration: %f", (unsigned long)[models1 count], [endDate timeIntervalSinceDate:startDate]);
}

- (void)testPropertyListSerialisationAll {
    NSDate *startDate = [NSDate date];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [models addObject:[model dict]];
    }
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:models format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
    
    NSDate *endDate = [NSDate date];
    NSLog(@"NSPropertyListSerialization all: %li duration: %f", (unsigned long)[models count], [endDate timeIntervalSinceDate:startDate]);
    
    [data writeToFile:[[NSString stringWithFormat:@"~/Desktop/%@.dat", NSStringFromSelector(_cmd)] stringByExpandingTildeInPath] atomically:NO];
}

- (void)testJSONSerialisation
{
    NSDate *startDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [array addObject:[NSJSONSerialization dataWithJSONObject:[model dict] options:0 error:nil]];
    }
    NSMutableArray *models1 = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (NSData *data in array) {
        [models1 addObject:[Model modelWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]];
    }    
    NSDate *endDate = [NSDate date];
    
    NSLog(@"NSJSONSerialization models: %li duration: %f", (unsigned long)[models1 count], [endDate timeIntervalSinceDate:startDate]);
}

- (void)testJSONSerialisationAll {
    NSDate *startDate = [NSDate date];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [models addObject:[model dict]];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:models options:0 error:nil];
    
    NSDate *endDate = [NSDate date];
    NSLog(@"NSJSONSerialization all: %li duration: %f", (unsigned long)[models count], [endDate timeIntervalSinceDate:startDate]);
    
    [data writeToFile:[[NSString stringWithFormat:@"~/Desktop/%@.dat", NSStringFromSelector(_cmd)] stringByExpandingTildeInPath] atomically:NO];
}
@end
