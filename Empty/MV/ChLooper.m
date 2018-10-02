//
//  ChLooper.m
//  Empty
//
//  Created by SeungChul Kang on 2018. 9. 11..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import "ChLooper.h"

@interface ChLooper ()
@property (nonatomic, strong) NSMutableArray<ChLooperItem *> *items;
@property (nonatomic) NSTimeInterval pausedTime;
@property (nonatomic) NSTimeInterval old;
@property (nonatomic) NSTimeInterval p;
@property (nonatomic) float fps;
@end

@implementation ChLooper

static dispatch_queue_t serialQueue;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [NSMutableArray<ChLooperItem *> new];
        _old = 1;
        _pausedTime = 0;
        _p = 0;
        _fps = 0;
        self.frame = CGRectMake(1, -1, 1, 1);
        serialQueue = dispatch_queue_create("com.davin.serialqueue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(serialQueue, ^{
            while (1) {
                usleep(16000);
                dispatch_sync(dispatch_get_main_queue(), ^{
//                    NSLog(@"setNeedsDisplay");
                    self.frame = CGRectMake(self.frame.origin.x * -1, -1, 1, 1);
                    [self setNeedsDisplay];
                });
            }
        });
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSTimeInterval curr = NSDate.timeIntervalSinceReferenceDate;
    NSTimeInterval d = curr - _old;
    if (d != 0) _fps = 1000 / (curr - _old);
    _old = curr;
    NSInteger j = _items.count;
    if (j > 0) {
        NSTimeInterval c = curr - _pausedTime;
        double rate;
        BOOL r, isEnd;
        for (NSInteger i = j - 1; i >= 0; i--) {
            ChLooperItem *item = _items[i];
            if (item.start > curr) continue;
            item.isTurn = isEnd = NO;
            if (item.end <= c) {
                item.loop--;
                if (item.loop == 0) {
                    rate = 1;
                    isEnd = YES;
                } else {
                    rate = 0;
                    item.isTurn = YES;
                    item.start = curr;
                    item.end = curr + item.term;
                }
            } else {
                rate = item.term == 0 ? 0 : (c - item.start) / item.term;
            }
            item.rate = rate;
            if (!item.isPaused) {
                r = item.f(curr, item);
                if (r || isEnd) {
                    if (item.ended != NULL) item.ended();
                    [item recycle];
                    [_items removeObjectAtIndex:i];
                }
            }
        }
    }
}

- (nonnull ChLooperItem *)add:(nonnull NSString *)key :(nonnull ANI_FUNC)f :(NSInteger)s :(double)t :(double)e :(NSInteger)l :(nullable ANI_ENDED)ed {
    ChLooperItem *r = [[ChLooperItem alloc] init:key :f :s :(e - s) :e :l :ed];
    [_items addObject:r];
    return r;
}

@end


@interface ChLooperItem ()
@property (nonatomic) NSTimeInterval p;
@end

@implementation ChLooperItem
- (nonnull instancetype)init:(nonnull NSString *)k :(nonnull ANI_FUNC)fn :(NSInteger)s :(double)t :(double)e :(NSInteger)l :(nullable ANI_ENDED)ed {
    self = [super init];
    if (self) {
        _key = k;
        _f = fn;
        _start = s;
        _term = t;
        _end = e;
        _loop = l;
        _ended = ed;
        _isPaused = NO;
    }
    return self;
}

- (void)recycle {

}

- (void)pause {
    if(_isPaused) return;
    _isPaused = YES;
    _p = NSDate.timeIntervalSinceReferenceDate;
}

- (void)resume {
    if(!_isPaused) return;
    _isPaused = NO;
    _p = NSDate.timeIntervalSinceReferenceDate - _p;
    _start += _p;
    _end += _p;
    _p = 0;
}

- (double)linear:(double)from :(double)to {
    return from + _rate * (to - from);
}

- (double)sineOut:(double)from :(double)to {
    return (to-from)*sin(_rate*M_PI_2)+from;
}

@end
