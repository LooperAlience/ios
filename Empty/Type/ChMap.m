//
//  ChMap.m
//  Empty
//
//  Created by SeungChul Kang on 2018. 8. 28..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import "ChMap.h"

@interface ChMap ()
@property (nonatomic, strong) ChType *currType;
@property (nonatomic, strong) id container;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSMutableDictionary *store;
- (BOOL)_set:(id)m :(NSString *)k :(id)v;

@end

@implementation ChMap
- (instancetype)init
{
    self = [super init];
    if (self) {
        _prefix = @"";
        _store = [NSMutableDictionary new];
    }
    return self;
}
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    _store[aKey] = anObject;
}
- (id)objectForKey:(id)aKey {
    return _store[aKey];
}

- (nonnull ChMap*)set:(nonnull NSString *)key :(nonnull id)val { // set("a,b,c", 3)
    if ([key containsString:@","]) {
        NSArray<NSString *> *splited = [key componentsSeparatedByString:@","];
        for (NSString *_k in splited) {
            NSString *k = [_k stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];

            if (![self _set:self :k :val]) {
                @throw([NSException exceptionWithName:@"IllegalArgumentException"
                                               reason:[NSString stringWithFormat:@"invalid arg:%@:%@", k, val]
                                             userInfo:nil]);
            }
        }
    } else {
        if (![self _set:self :key :val]) {
            @throw([NSException exceptionWithName:@"IllegalArgumentException"
                                           reason:[NSString stringWithFormat:@"invalid arg:%@:%@", key, val]
                                         userInfo:nil]);
        }
    }
    return self;
}
- (nullable id)get:(nonnull NSString *)key {
    NSString *k = [NSString stringWithFormat:@"%@%@", self.prefix, key];
    if ([self _isInited:self :k]) return [self _val:self.key];
    return nil;
}

- (nullable id)f32:(nonnull NSString *)key {
    return [ChType.F32 cast:[self get:key]];
}
- (nullable id)f64:(nonnull NSString *)key {
    return [ChType.F64 cast:[self get:key]];
}
- (nullable id)f80:(nonnull NSString *)key {
    return [ChType.F80 cast:[self get:key]];
}
- (nullable id)o:(nonnull NSString *)key {
    return [self get:key];
}
- (nullable id)_val:(nonnull NSString *)key {
    if (!self.currType) return nil;
    id r = [self.currType get:self.container key:key];
    if ([r isKindOfClass:NSString.class]) { // 참조구조
        NSString *s = r;
        if([s characterAtIndex:0] == '@' && [s characterAtIndex:1] == '{') r = [self get:[s substringWithRange:NSMakeRange(2, s.length - 1 - 2)]];
    }
    return r;
}

- (BOOL)_set:(id)m :(NSString *)k :(id)v {
    if (![self _isInited:m :k]) return NO;
    else {
        if ([v isKindOfClass:NSString.class]) {
            [self.currType set:self.container key:self.key val:[ChType parse:v :nil]];
        } else {
            [self.currType set:self.container key:self.key val:v];
        }
        return YES;
    }
}

- (BOOL)_setContainer:(id)v {
    self.container = v;
    self.currType = [ChType is:v];
    return !!self.currType;
}

- (BOOL)_isInited:(id)m :(NSString *)k {
    if (![self _setContainer:m]) return NO;
    self.key = k;
    if ([k containsString:@"."]) {
        NSArray<NSString *> *keys = [k componentsSeparatedByString:@"."];
        NSInteger lastIdx = keys.count - 1;
        for (NSInteger i = 0; i < lastIdx; i++) if (![self _setContainer:[self _val:keys[i]]]) return NO;
        self.key = keys[lastIdx];
    }
    return YES;
}

@end
