//
//  ShareCache.m
//  ProductList
//
//  Created by Arpit Mishra on 21/02/16.
//  Copyright © 2016 Arpit Mishra. All rights reserved.
//

#import "SharedCache.h"

@interface SharedCache()

@property (strong, nonatomic)NSCache *cache;
@end

@implementation SharedCache

+ (SharedCache *)defaultManager {
    static SharedCache *tempCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tempCache) {
            tempCache = [[super allocWithZone:NULL] initUniqueInstance];
        }
    });
    return tempCache;
}

- (instancetype) initUniqueInstance {
    _cache = [[NSCache alloc] init];
    return [super init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [SharedCache defaultManager];
}
- (BOOL)addItemToCache:(id)item withKey:(NSString *)itemKey{
    NSString *trimmedItemKey = [itemKey stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    BOOL isSuccessfullyAdded = NO;
    if (trimmedItemKey.length && item) {
        [self.cache setObject:item forKey:trimmedItemKey];
        isSuccessfullyAdded = YES;
    }
    return isSuccessfullyAdded;
}
- (id)getItemForKey:(NSString *)itemKey{
    id item = nil;
    NSString *trimmedItemKey = [itemKey stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    if (trimmedItemKey.length) {
        item = [self.cache objectForKey:trimmedItemKey];
    }
    return item;
}
- (BOOL)removeItemFromCacheWithKey:(NSString *)itemKey{
    NSString *trimmedItemKey = [itemKey stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    BOOL isSuccessfullyRemoved = NO;
    if (trimmedItemKey.length) {
        [self.cache removeObjectForKey:trimmedItemKey];
    }
    return isSuccessfullyRemoved;
}
- (void)clearGlobalCache{
    [self.cache removeAllObjects];
    self.cache = nil;
}

@end
