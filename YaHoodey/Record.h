//
//  WeightModel.h
//  YaHoodey
//
//  Created by iMac on 09/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Record : NSObject
@property (copy, nonatomic) NSDate *date;
@property (assign, nonatomic) CGFloat value;

-(instancetype) initWithDate: (NSDate*) date andValue: (CGFloat) value;
@end
