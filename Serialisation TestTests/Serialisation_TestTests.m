//
//  Serialisation_TestTests.m
//  Serialisation TestTests
//
//  Created by Johnnie Walker on 09/05/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "Serialisation_TestTests.h"
#import "Model.h"
#import "TIKSyncCoder.h"

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

- (void)test01NSCoding
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

- (void)test01NSKeyedCoding
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


- (void)test03PropertyListSerialisation
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

- (void)test04JSONSerialisation
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

- (void)test05TIKSyncCoderSerialisation
{
    NSDate *startDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:ITERATIONS];
    for (Model *model in self.models) {
        [array addObject:[TIKSyncCoder newLogTxnWithType:@"model" andKVPairs:[model dict]]];
    }
    NSMutableArray *models1 = [NSMutableArray arrayWithCapacity:ITERATIONS];
    NSMutableDictionary *scratchDict = [NSMutableDictionary dictionaryWithCapacity:4];
    for (NSString *txn in array) {
        [scratchDict removeAllObjects];
        [TIKSyncCoder parseKVPairsFromString:txn intoDict:scratchDict];
        [models1 addObject:[scratchDict copy]];
    }
    NSDate *endDate = [NSDate date];
    
    NSLog(@"TIKSyncCoder models: %li duration: %f", (unsigned long)[models1 count], [endDate timeIntervalSinceDate:startDate]);
}

@end
