//
//  HistoryTableViewController.h
//  YaHoodey
//
//  Created by igor on 08/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@protocol WeightServiceProtocol;

@interface HistoryTableViewController : UITableViewController
-(instancetype) initWithService: (id<WeightServiceProtocol>) service;
@end

NS_ASSUME_NONNULL_END
