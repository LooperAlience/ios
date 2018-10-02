//
//  ChLooper.h
//  Empty
//
//  Created by SeungChul Kang on 2018. 9. 11..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChLooperItem;
typedef BOOL(^ANI_FUNC)(NSTimeInterval, ChLooperItem * _Nonnull);
typedef void(^ANI_ENDED)(void);

@interface ChLooper : UIView
@property (nonatomic, strong, nonnull) UIView *target;
- (nonnull ChLooperItem *)add:(nonnull NSString *)key :(nonnull ANI_FUNC)f :(NSInteger)s :(double)t :(double)e :(NSInteger)l :(nullable ANI_ENDED)ed;
@end

@interface ChLooperItem : NSObject
@property (nonatomic) double rate;
@property (nonatomic, strong) NSString *key;
@property (nonatomic) NSInteger loop;
@property (nonatomic) BOOL isTurn;
@property (nonatomic) double term;
@property (nonatomic, copy) ANI_FUNC f;
@property (nonatomic) NSInteger start;
@property (nonatomic) double end;
@property (nonatomic) BOOL isPaused;
@property (nonatomic, copy) ANI_ENDED ended;

- (nonnull instancetype)init:(nonnull NSString *)k :(nonnull ANI_FUNC)fn :(NSInteger)s :(double)t :(double)e :(NSInteger)l :(nullable ANI_ENDED)ed;
- (void)recycle;
- (void)pause;
- (void)resume;
- (double)linear:(double)from :(double)to;
- (double)sineOut:(double)from :(double)to;

@end
