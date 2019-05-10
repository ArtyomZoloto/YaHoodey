//
//  Service.h
//  YaHoodey
//
//  Created by iMac on 09/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeightServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeightService : NSObject <WeightServiceProtocol>
@property(strong, nonatomic, readonly) NSMutableArray<WeightModel*>* data;
@end

NS_ASSUME_NONNULL_END
