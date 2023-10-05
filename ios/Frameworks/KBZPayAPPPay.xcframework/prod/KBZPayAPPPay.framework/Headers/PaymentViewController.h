//
//  PaymentViewController.h
//  PWASdkDemo
//
//  Created by mac2 on 2019/6/11.
//  Copyright © 2019年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentViewController : UIViewController

/**
 Start Pay API
 @param orderInfo orderInformation
 @param signType signType defalut SHA256
 @param sign sign = SHA256(orderInfo+key)
 @param appScheme your app url schemes
 */
- (void)startPayWithOrderInfo:(NSString *)orderInfo signType:(NSString *)signType sign:(NSString *)sign appScheme:(NSString *)appScheme;

@end

NS_ASSUME_NONNULL_END
