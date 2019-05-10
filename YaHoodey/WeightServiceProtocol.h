#import <UIKit/UIKit.h>

@class WeightModel;
@protocol WeightServiceProtocol
-(BOOL) save: (CGFloat) weight;
-(NSArray<WeightModel*>*) data;
-(NSString*) stringDateForRow: (NSInteger) row;
-(CGFloat) valueForRow: (NSInteger) row;
@end
