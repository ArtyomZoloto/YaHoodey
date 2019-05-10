//
//  DataSaverViewController.h
//  YaHoodey
//
//  Created by iMac on 09/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WeightServiceProtocol;
@interface DataSaverViewController : UIViewController <UITextFieldDelegate>

-(instancetype) initWithService:(id<WeightServiceProtocol>) service;

@end

NS_ASSUME_NONNULL_END
