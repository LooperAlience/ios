//
//  ChType.m
//  Empty
//
//  Created by SeungChul Kang on 2018. 8. 14..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//
#import "ChType.h"

@interface NSString (IndexOf)
- (NSInteger)indexOf:(NSString *)t;
@end

@implementation NSString (IndexOf)
- (NSInteger)indexOf:(NSString *)t {
    unichar f = [t characterAtIndex:0];
    NSInteger k, l = t.length;
    BOOL isOk;
    for (NSInteger i = 0, j = self.length - l; i <= j; i++) {
        if([self characterAtIndex:i] == f) {
            for(isOk = YES, k = 1; k < l; k++) {
                if ([self characterAtIndex:i+k] != [t characterAtIndex:k]) {
                    isOk = NO;
                    break;
                }
            }
            if(isOk) return i;
        }
    }
    return -1;
}
@end


@interface B: ChType
@end
@implementation B
- (NSString *)schema {
    return @"b";
}
@end



@interface ChType()
@end

@implementation ChType
static BOOL isInited;
static B *b;
static NSDictionary *schemeType;
+ (void)INIT {
    if(isInited) return;
    isInited = YES;
    b = [B new];
    schemeType = @{ b.schema: b };
}

+ (BOOL)isSameNumber:(nonnull NSNumber *)a :(nonnull NSNumber *)b {
    return NO;
}
+ (nullable id)parse:(nonnull id)o :(nullable NSString *)subT {
    [self INIT];
    if(![o isKindOfClass:NSString.class]) return o;
    NSString *v = o;
    if(!!subT) v = [NSString stringWithFormat:@"@%@://%@", subT, v];
    if([v characterAtIndex:0] != '@') return v;
    if([v characterAtIndex:1] == '{') return o;
    NSInteger i = [v indexOf:@"://"];
    if (i == -1) return v;
    NSString *header = [v substringWithRange:NSMakeRange(1, i - 1)];
    NSInteger subSep = [header indexOf:@"<"];
    NSString *noSub = subSep == -1 ? header : [header substringToIndex:subSep];
    NSInteger infoSep = [noSub indexOf:@"["];
    NSString *type = infoSep == -1 ? noSub : [noSub substringToIndex:infoSep];

    id r = schemeType[type];

    NSLog(@"type := %@, o := %@", type, r);

    if(!r) return v;

    return [r _parse:(subSep == -1 ? nil : [header substringWithRange:NSMakeRange(subSep + 1, header.length - (subSep + 1))])
                    :infoSep == -1 ? nil : [self parseArr:[noSub substringWithRange:NSMakeRange(infoSep, noSub.length - infoSep)]]
                    :[v substringFromIndex:i + 3]];
}

+ (nullable NSDictionary *)parseMAP:(nonnull NSString *)v {
    id ret;
    if ((ret = [NSJSONSerialization JSONObjectWithData:[v dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:NULL]) && [ret isKindOfClass:NSDictionary.class]) {
        return ret;
    }
    return nil;
}
+ (nullable NSArray<NSString *> *)parseSArr:(nonnull NSString *)v {
    id ret;
    if ((ret = [NSJSONSerialization JSONObjectWithData:[v dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:NULL]) && [ret isKindOfClass:NSArray.class]) {
        NSArray *_ret = ret;
        NSMutableArray *array = [NSMutableArray init];
        for (id item in _ret) {
            id t = [self parse:item :nil];
            ChType *type = [self is:t];
            [array addObject:type == nil ? @"" : [type castS:t]];
        }
        return ret;
    }
    return nil;
}
+ (nullable NSArray *)parseArr:(nonnull NSString *)v {
    id ret;
    if ((ret = [NSJSONSerialization JSONObjectWithData:[v dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:NULL]) && [ret isKindOfClass:NSArray.class]) {
        NSArray *_ret = ret;
        NSMutableArray *array = [NSMutableArray init];
        for (id o in _ret) {
            id parsed;
            if (!!(parsed = [self parse:o :nil])) [array addObject:parsed];
        }
        return ret;
    }
    return nil;
}
+ (nullable ChType *)is:(nullable id)v {
    if (!v) return nil;
    for (ChType *type in schemeType.allValues) {
        if ([type is:v]) return type;
    }
    return nil;
}
+ (nullable id)get:(nonnull id)container key:(nonnull NSString *)k {
    return [[self is:container] get:container key:k];
}
+ (nullable id)set:(nonnull id)container key:(nonnull NSString *)k val:(nullable id)v {
    return [[self is:container] set:container key:k val:v];
}
- (BOOL)isValue {
    return NO;
}
- (BOOL)is:(id)v {
    return NO;
}
- (NSString *)schema {
    return nil;
}
- (id)_fromS:(NSString *)v {
    return nil;
}
- (id)_fromN:(NSNumber *)v {
    return nil;
}
- (id)_parse:(NSString *)subType :(NSArray *)info :(NSString *)body {
    return nil;
}
- (void)_item:(id)container :(NSMutableArray *)list {

}
- (NSMutableArray *)list:(id)container {
    return nil;
}
- (id)get:(id)container key:(NSString *)k {
    return nil;
}
- (id)set:(id)container key:(NSString *)k val:(id)v {
    return nil;
}
- (BOOL)isSame:(id)a :(id)b {
    return NO;
}
- (id)cast:(id)v {
    return nil;
}
- (NSInteger)castI:(id)v {
    return 0;
}
- (float)castF:(id)v {
    return 0;
}
- (double)castD:(id)v {
    return 0;
}
- (BOOL)castB:(id)v {
    return NO;
}
- (NSString *)castS:(id)v {
    return nil;
}

@end
