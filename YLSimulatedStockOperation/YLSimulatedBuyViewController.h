//
//  YLSimulatedBuyViewController.h
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/13/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBuyStockModel;
@interface YLSimulatedBuyViewController : UIViewController
@property(nonatomic,copy)NSString *stockNumber;
@property(nonatomic,copy)NSString *selfTitle;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *stockBuyNumber;
@property(nonatomic,assign)BOOL ifSell;
@property(nonatomic,strong)YLBuyStockModel *SELLModel;
@end
