//
//  Service.m
//  YaHoodey
//
//  Created by iMac on 09/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import "WeightService.h"
#import "Record.h"

@interface WeightService ()
@end

@implementation WeightService
- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_records){
            _records = [NSMutableArray new];
        }
    }
    return self;
}

- (BOOL)save:(CGFloat)weight {
    long was = self.records.count;
    NSDate *curDate = [NSDate date];
    Record *wm = [[Record alloc] initWithDate:curDate andValue:weight];
    [self.records addObject:wm];
    return self.records.count > was;
}


- (NSString *)stringDateForIndexPath:(NSIndexPath *)indexPath {
    NSArray *key = [self recordsByMonths].allKeys[indexPath.section];
    Record *record = [self recordsByMonths][key][indexPath.row];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd.MM.yy"];
    return [dateFormatter stringFromDate:record.date];
}


- (CGFloat)valueForIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self recordsByMonths].allKeys[indexPath.section];
    Record *record = [self recordsByMonths][key][indexPath.row];
    return record.value;
}


-(NSDictionary*) recordsByMonths{
    NSMutableDictionary *result = [NSMutableDictionary new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    for (Record *record in self.records){
        NSInteger unit = [calendar component:NSCalendarUnitMonth fromDate:record.date] - 1;
        NSString *month = [calendar monthSymbols][unit];
        NSMutableArray *recordsByMonth = result[month];
        if (!recordsByMonth){
            recordsByMonth = [NSMutableArray new];
            [result setObject:recordsByMonth forKey:month];
        }
        [recordsByMonth addObject:record];
    }
    return result;
}







@end
