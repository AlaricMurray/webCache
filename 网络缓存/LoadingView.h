//
//  LoadingView.h
//  AFCache
//
//  Created by tc on 2016/11/11.
//  Copyright © 2016年 tc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingView : NSObject

+ (void)showAlertHUD:(NSString *)aString duration:(CGFloat)duration;
+ (void)showProgressHUD:(NSString *)aString duration:(CGFloat)duration;
+ (void)showProgressHUD:(NSString *)aString;
+ (void)hideProgressHUD;
+ (void)updateProgressHUD:(NSString*)progress;

@end
