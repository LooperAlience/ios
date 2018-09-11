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

//+ (nonnull ChType *)EMPTY;
@interface EMPTY: ChType
@end
@implementation EMPTY
- (nonnull NSString *)schema { return @"empty"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v {
    ChType *ch = v;
    return [ch isKindOfClass:ChType.class] && [ch.schema isEqualToString:@"empty"];
}
- (id)_fromS:(NSString *)v { return ChType.EMPTY; }
- (id)_fromN:(NSNumber *)v { return ChType.EMPTY; }
- (BOOL)isSame:(id)a :(id)b { return [self is:a] && [self is:b]; }
@end


@interface B: ChType
@end
@implementation B
- (nonnull NSString *)schema { return @"b"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v {
    if ([v isKindOfClass:NSNumber.class]) {
        NSNumber *num = v;
        return CFGetTypeID((__bridge CFTypeRef)(num)) == CFBooleanGetTypeID();
    }
    return NO;
}
- (id)_fromS:(NSString *)v { return [@"true" isEqualToString:v] ? @YES : @NO; }
- (id)_fromN:(NSNumber *)v { return [@0 compare:v] == NSOrderedSame ? @NO: @YES; }
- (BOOL)isSame:(id)a :(id)b { return [a boolValue] == [b boolValue]; }
@end

@interface I8: ChType
@end
@implementation I8
- (nonnull NSString *)schema { return @"i8"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 1; }
- (id)_fromS:(NSString *)v { return [[NSNumber alloc] initWithChar:v.integerValue]; }
- (id)_fromN:(NSNumber *)v { return @(v.charValue); }
- (BOOL)isSame:(id)a :(id)b { return [a charValue] == [b charValue]; }
@end

@interface I16: ChType
@end
@implementation I16
- (nonnull NSString *)schema { return @"i16"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 2; }
- (id)_fromS:(NSString *)v { return [[NSNumber alloc] initWithShort:v.integerValue]; }
- (id)_fromN:(NSNumber *)v { return @(v.shortValue); }
- (BOOL)isSame:(id)a :(id)b { return [a shortValue] == [b shortValue]; }
@end

@interface I32: ChType
@end
@implementation I32
- (nonnull NSString *)schema { return @"i32"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 3; }
- (id)_fromS:(NSString *)v { return [[NSNumber alloc] initWithInt:(int)v.integerValue]; }
- (id)_fromN:(NSNumber *)v { return [[NSNumber alloc] initWithInt:(int)v.integerValue]; }
- (BOOL)isSame:(id)a :(id)b { return [a integerValue] == [b integerValue]; }
@end

@interface I64: ChType
@end
@implementation I64
- (nonnull NSString *)schema { return @"i64"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 4; }
- (id)_fromS:(NSString *)v { return @(v.integerValue); }
- (id)_fromN:(NSNumber *)v { return @(v.integerValue); }
- (BOOL)isSame:(id)a :(id)b { return [a integerValue] == [b integerValue]; }
@end

static double epsilon32 = 0.000000001;

@interface F32: ChType
@end
@implementation F32
- (nonnull NSString *)schema { return @"f32"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 5; }
- (id)_fromS:(NSString *)v { return @(v.floatValue); }
- (id)_fromN:(NSNumber *)v { return @(v.floatValue); }
- (BOOL)isSame:(id)a :(id)b {
    return fabsf([a floatValue] - [b floatValue]) < epsilon32;
}
@end

static double epsilon64 = 0.000000001;

@interface F64: ChType
@end
@implementation F64
- (nonnull NSString *)schema { return @"f64"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 6; }
- (id)_fromS:(NSString *)v { return @(v.doubleValue); }
- (id)_fromN:(NSNumber *)v { return @(v.doubleValue); }
- (BOOL)isSame:(id)a :(id)b {
    return fabs([a doubleValue] - [b doubleValue]) < epsilon64;
}
@end

@interface F80: ChType
@end
@implementation F80
- (nonnull NSString *)schema { return @"f80"; }
- (BOOL)isValue { return YES; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSNumber.class] && CFNumberGetType((__bridge CFNumberRef)((NSNumber *)v)) == 6; }
- (id)_fromS:(NSString *)v { return @(v.floatValue); }
- (id)_fromN:(NSNumber *)v { return @(v.floatValue); }
- (BOOL)isSame:(id)a :(id)b { return [a floatValue] == [b floatValue]; }
@end

@interface MAP: ChType
@end
@implementation MAP
- (nonnull NSString *)schema { return @"map"; } //map://{k:parse,k:parse,...}
- (BOOL)isValue { return NO; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSDictionary.class]; }
- (id)_parse:(NSString *)subType :(NSArray *)info :(NSString *)body {
    return [ChType parseMAP:body];
}
- (id)get:(id)container key:(NSString *)k {
    return ((NSDictionary *)container)[k];
}
- (id)set:(id)container key:(NSString *)k val:(id)v {
    NSMutableDictionary *dic = container;
    [dic setObject:v forKey:k];
    return container;
}
@end

@interface LIST: ChType
@end
@implementation LIST
- (nonnull NSString *)schema { return @"list"; } //list://[1, 1.5, true, "abc"]
- (BOOL)isValue { return NO; }
- (BOOL)is:(id)v { return [v isKindOfClass:NSArray.class]; }
- (id)_parse:(NSString *)subType :(NSArray *)info :(NSString *)body {
    return [ChType parseArr:body];
}
- (id)get:(id)container key:(NSString *)k {
    return ((NSArray *)container)[k.integerValue];
}
- (id)set:(id)container key:(NSString *)k val:(id)v {
    NSMutableArray *array = container;
    array[k.integerValue] = v;
    return container;
}
@end

@interface ChType()
@end

@implementation ChType
static BOOL isInited;
static EMPTY *empty;
static B *b;
static I8 *i8;
static I16 *i16;
static I32 *i32;
static I64 *i64;
static F32 *f32;
static F64 *f64;
static F80 *f80;
static MAP *map;
static LIST *list;
static NSDictionary *schemeType;
+ (void)INIT {
    if(isInited) return;
    isInited = YES;
    empty = [EMPTY new];
    b     = [B new];
    i8    = [I8 new];
    i16   = [I16 new];
    i32   = [I32 new];
    i64   = [I64 new];
    f32   = [F32 new];
    f64   = [F64 new];
    f80   = [F80 new];
    map   = [MAP new];
    list  = [LIST new];
    schemeType = @{
       empty.schema: empty,
       b.schema: b,
       i8.schema: i8,
       i16.schema: i16,
       i32.schema: i32,
       i64.schema: i64,
       f32.schema: f32,
       f64.schema: f64,
       f80.schema: f80,
       map.schema: map,
       list.schema: list
   };
}
+ (nonnull ChType *)EMPTY { return empty; }
+ (nonnull ChType *)B     { return b; }
+ (nonnull ChType *)I8    { return i8; }
+ (nonnull ChType *)I16   { return i16; }
+ (nonnull ChType *)I32   { return i32; }
+ (nonnull ChType *)I64   { return i64; }
+ (nonnull ChType *)F32   { return f32; }
+ (nonnull ChType *)F64   { return f64; }
+ (nonnull ChType *)F80   { return f80; }
+ (nonnull ChType *)MAP   { return map; }
+ (nonnull ChType *)LIST  { return list; }

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
        NSMutableDictionary *dic = ret;
        for (NSString *key in dic.allKeys) {
            dic[key] = [ChType parse:dic[key] :nil];
        }

        return dic;
    }
    return nil;
}
+ (nullable NSArray<NSString *> *)parseSArr:(nonnull NSString *)v {
    id ret;
    if ((ret = [NSJSONSerialization JSONObjectWithData:[v dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:NULL]) && [ret isKindOfClass:NSArray.class]) {
        NSArray *_ret = ret;
        NSMutableArray *array = [[NSMutableArray alloc] init];
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
        NSMutableArray *array = [[NSMutableArray alloc] init];
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
- (nullable id)_fromS:(nonnull NSString *)v {
    return [ChType parse:v :nil];
}
- (nullable id)_fromN:(NSNumber *)v {
    return nil;
}
- (nullable id)_parse:(NSString *)subType :(NSArray *)info :(NSString *)body {
    return [self _fromS:body];
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
