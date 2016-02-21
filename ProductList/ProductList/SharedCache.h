//
//  ShareCache.h
//  ProductList
//
//  Created by Arpit Mishra on 21/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedCache : NSObject

+ (SharedCache *)defaultManager;
- (BOOL)addItemToCache:(id)item withKey:(NSString *)itemKey;
- (instancetype)getItemForKey:(NSString *)itemKey;
- (BOOL)removeItemFromCacheWithKey:(NSString *)itemKey;
- (void)clearGlobalCache;

+(instancetype) alloc __attribute__((unavailable("alloc not available, call defaultManager instead")));
-(instancetype) init  __attribute__((unavailable("init not available, call defaultManager instead")));
+(instancetype) new   __attribute__((unavailable("new not available, call defaultManager instead")));
@end
