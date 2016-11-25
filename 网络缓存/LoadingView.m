//
//  LoadingView.m
//  AFCache
//
//  Created by tc on 2016/11/11.
//  Copyright © 2016年 tc. All rights reserved.
//

UIWindow *mainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

#import "LoadingView.h"
#import "MBProgressHUD.h"

static MBProgressHUD  *s_progressHUD = nil;

@implementation LoadingView


+ (void)showProgressHUD:(NSString *)aString duration:(CGFloat)duration {
    [self hideProgressHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:mainWindow()];
    [mainWindow() addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.labelText = aString;
    
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.opacity = 0.7;
    [progressHUD show:NO];
    [progressHUD hide:YES afterDelay:duration];
}

+ (void)showProgressHUD:(NSString *)aString {
    if (!s_progressHUD) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            s_progressHUD = [[MBProgressHUD alloc] initWithView:mainWindow()];
        });
    }else{
        [s_progressHUD hide:NO];
    }
    [mainWindow() addSubview:s_progressHUD];
    s_progressHUD.removeFromSuperViewOnHide = YES;
    s_progressHUD.animationType = MBProgressHUDAnimationZoom;
    if ([aString length]>0) {
        s_progressHUD.labelText = aString;
    }
    else s_progressHUD.labelText = nil;
    
    s_progressHUD.opacity = 0.7;
    [s_progressHUD show:YES];
    
}

+ (void)showAlertHUD:(NSString *)aString duration:(CGFloat)duration {
    [self hideProgressHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:mainWindow()];
    [mainWindow() addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.labelText = aString;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.opacity = 0.7;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD show:NO];
    [progressHUD hide:YES afterDelay:duration];
}

+ (void)hideProgressHUD {
    if (s_progressHUD) {
        [s_progressHUD hide:YES];
    }
}

+ (void)updateProgressHUD:(NSString*)progress {
    if (s_progressHUD) {
        s_progressHUD.labelText = progress;
    }
}


@end
