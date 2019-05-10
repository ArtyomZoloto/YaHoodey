
#import "WeightModel.h"

@implementation WeightModel
-(instancetype) initWithDate: (NSDate*) date andValue: (CGFloat) value
{
    self = [super init];
    if (self) {
        _date = date;
        _value = value;
    }
    return self;
}
@end
