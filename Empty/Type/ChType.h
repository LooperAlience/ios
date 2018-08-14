//
//  ChType.h
//  Empty
//
//  Created by SeungChul Kang on 2018. 8. 14..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ChType: NSObject
+ (BOOL)isSameNumber:(NSNumber *)a :(NSNumber *)b;
+ (id)PARSE:(id)o :(NSString *)subT;
+ (NSDictionary *)parseMAP:(NSString *)v;
+ (NSArray<NSString *> *)parseSArr:(NSString *)v;
+ (NSArray *)parseArr:(NSString *)v;
+ (ChType *)IS:(id)v;
+ (id)GET:(id)container key:(NSString *)k;
+ (id)SET:(id)container key:(NSString *)k val:(id)v;
- (BOOL)isValue;
- (BOOL)is:(id)v;
- (NSString *)schema;
- (id)_fromS:(NSString *)v;
- (id)_fromN:(NSNumber *)v;
- (id)_parse:(NSString *)subType :(NSArray *)info :(NSString *)body;
- (void)_item:(id)container :(NSMutableArray *)list;
- (NSMutableArray *)list:(id)container;
- (id)get:(id)container key:(NSString *)k;
- (id)set:(id)container key:(NSString *)k val:(id)v;
- (BOOL)isSame:(id)a :(id)b;
- (id)cast:(id)v;
- (NSInteger)castI:(id)v;
- (float)castF:(id)v;
- (double)castD:(id)v;
- (BOOL)castB:(id)v;
- (NSString *)castS:(id)v;
@end
