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

+ (BOOL)isSameNumber:(NSNumber *)a :(NSNumber *)b {
    return NO;
}
+ (id)PARSE:(id)o :(NSString *)subT {
    [self INIT];
    if(![o isKindOfClass:NSString.class]) return o;
    NSString *v = o;
    if(!!subT) v = [NSString stringWithFormat:@"@%@://%@", subT, v];
    if([v characterAtIndex:0] != '@') return v;
    if([v characterAtIndex:1] == '{') return o;
    NSInteger i = [v indexOf:@"://"];
    if (i == -1) return v;
    NSString *header = [v substringWithRange:NSMakeRange(1, i)];
    NSInteger subSep = [header indexOf:@"<"];
    NSString *noSub = subSep == -1 ? header : [header substringToIndex:subSep];
    NSInteger infoSep = [noSub indexOf:@"["];
    NSString *type = infoSep == -1 ? noSub : [noSub substringToIndex:infoSep];

    id r = schemeType[type];

    NSLog(@"type := %@, o := %@", type, r);

    if(!r) return v;
//    [r _parse];





    return nil;
}
+ (NSDictionary *)parseMAP:(NSString *)v {
    return nil;
}
+ (NSArray<NSString *> *)parseSArr:(NSString *)v {
    return nil;
}
+ (NSArray *)parseArr:(NSString *)v {
    return nil;
}
+ (ChType *)IS:(id)v {
    return nil;
}
+ (id)GET:(id)container key:(NSString *)k {
    return nil;
}
+ (id)SET:(id)container key:(NSString *)k val:(id)v {
    return nil;
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
