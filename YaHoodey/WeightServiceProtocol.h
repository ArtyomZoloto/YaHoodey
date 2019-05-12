#import <UIKit/UIKit.h>

@class Record;
@protocol WeightServiceProtocol
-(BOOL) save: (CGFloat) weight;
-(NSArray<Record*>*) records;
-(NSString*) stringDateForIndexPath: (NSIndexPath*) indexPath;
-(CGFloat) valueForIndexPath: (NSIndexPath*) indexPath;
-(NSDictionary*) recordsByMonths;
@end
