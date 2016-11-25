//
//  MyRequest.h
//  AFCache
//
//  Created by tc on 2016/11/10.
//  Copyright © 2016年 tc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessCallBack)     (id responseObject,BOOL succe,NSDictionary *jsonDic);
typedef void (^FailureCallBack)     (NSError *error);

@interface MyRequest : NSObject


/*
 url : 请求的url
 cacheTime :缓存时间，以秒为单位 -1 为永久缓存  0 为不缓存
 loadString : @""代表只加载风火轮  nil或者null 代表不加载 @“字符串” 代表显示风火轮和下面的文字
 success:成功的回掉
 failure：失败的回掉
 */
+(void)GET:(NSString *)url CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure;

/*
 url : 请求的url
 cacheTime :缓存时间，以秒为单位  -1 为永久缓存 0 为不缓存
 loadString : @""代表只加载风火轮  nil或者null 代表不加载 @“字符串” 代表显示风火轮和下面的文字
 success:成功的回掉
 failure：失败的回掉
 */

+ (void)POST:(NSString *)url withParameters:(NSDictionary *)parmas CacheTime:(NSInteger )CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure;


@end
