//
//  MyRequest.m
//  AFCache
//
//  Created by tc on 2016/11/10.
//  Copyright © 2016年 tc. All rights reserved.
//
#define IsNilString(__String)   (__String==nil || [__String isEqualToString:@"null"] || [__String isEqualToString:@"<null>"])

#import "MyRequest.h"
#import "AFNetworking.h"
#import "EGOCache.h"
#import "LoadingView.h"
@implementation MyRequest


+(void)GET:(NSString *)url CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    
    EGOCache *cache = [EGOCache globalCache];
    
    if ([cache hasCacheForKey:url]) {
        
        NSData *responseObject = [cache dataForKey:url];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        success(responseObject,YES,dict);
        
//        return;
    }
    
    if (!IsNilString(loadString)) {
        
        [LoadingView showProgressHUD:loadString];

    }
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (!IsNilString(loadString)) {
            [LoadingView hideProgressHUD];
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        BOOL succe = NO;
        if ([[dict objectForKey:@"code"] isKindOfClass:[NSNumber class]]) {
            if ([[dict valueForKey:@"code"] isEqualToNumber:@100]) {
                succe = YES;
            } else
                succe = NO;;
        } else if ([[dict objectForKey:@"code"] isKindOfClass:[NSString class]]) {
            if ([[dict valueForKey:@"code"] isEqualToString:@"100"]) {
                succe = YES;
            } else
                succe = NO;
        }
        if (CacheTime && succe){
            
            if (CacheTime == -1) {
                [cache setData:responseObject forKey:url];
            }else{
                [cache setData:responseObject forKey:url withTimeoutInterval:CacheTime];
            }
        }
        success(responseObject,succe,dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (!IsNilString(loadString)) {
            [LoadingView hideProgressHUD];
        }
        [LoadingView showAlertHUD:@"网络没有连接上" duration:2];

        failure(error);
    }];


}

+ (void)POST:(NSString *)url withParameters:(NSDictionary *)parmas CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    EGOCache *cache = [EGOCache globalCache];
    
    if ([cache hasCacheForKey:url]) {
        
        NSData *responseObject = [cache dataForKey:url];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        success(responseObject,YES,dict);
        
        return;
    }
    
    if (!IsNilString(loadString)) {
        
        [LoadingView showProgressHUD:loadString];
        
    }
    [manager POST:url  parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (!IsNilString(loadString)) {
            [LoadingView hideProgressHUD];
            
        }

        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"message:%@",[dict valueForKey:@"msg"]);

        BOOL succe = NO;
        if ([[dict objectForKey:@"code"] isKindOfClass:[NSNumber class]]) {
            if ([[dict valueForKey:@"code"] isEqualToNumber:@100]) {
                succe = YES;
            } else
                succe = NO;
        } else if ([[dict objectForKey:@"code"] isKindOfClass:[NSString class]]) {
            if ([[dict valueForKey:@"code"] isEqualToString:@"100"]) {
                succe = YES;
            } else
                succe = NO;
        }
        if (CacheTime && succe){
            
            if (CacheTime == -1) {
                [cache setData:responseObject forKey:url];
            }else{
                [cache setData:responseObject forKey:url withTimeoutInterval:CacheTime];
            }
        }

        success(responseObject,succe,dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        if (!IsNilString(loadString)) {
            [LoadingView hideProgressHUD];
        }
        [LoadingView showAlertHUD:@"网络没有连接上" duration:2];

        failure(error);
    }];

}














@end
