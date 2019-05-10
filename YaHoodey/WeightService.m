//
//  Service.m
//  YaHoodey
//
//  Created by iMac on 09/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import "WeightService.h"
#import "WeightModel.h"

@interface WeightService ()
@end

@implementation WeightService
- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_data){
            _data = [NSMutableArray new];
        }
    }
        return self;
}

- (BOOL)save:(CGFloat)weight {
    long was = self.data.count;
    NSDate *curDate = [NSDate date];
    WeightModel *wm = [[WeightModel alloc] initWithDate:curDate andValue:weight];
    [self.data addObject:wm];
    return self.data.count > was;
}


- (NSString *)stringDateForRow:(NSInteger)row {
    NSDate *date = self.data[row].date;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd.MM.yy"];
    return [dateFormatter stringFromDate:date];
}


- (CGFloat)valueForRow:(NSInteger)row {
    return self.data[row].value;
}




@end
