//
//  ChLooper.m
//  Empty
//
//  Created by SeungChul Kang on 2018. 9. 11..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import "ChLooper.h"

@implementation ChLooper

static dispatch_queue_t serialQueue;
- (instancetype)init
{
    self = [super init];
    if (self) {
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

- (instancetype)init:(UIView *)view
{
    self = [super init];
    if (self) {
        _target = view;
        self.frame = CGRectMake(1, -1, 1, 1);
        serialQueue = dispatch_queue_create("com.davin.serialqueue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(serialQueue, ^{
            while (1) {
                usleep(16000);
                dispatch_sync(dispatch_get_main_queue(), ^{
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
    NSLog(@"looper");
    self.target.frame = CGRectMake(self.target.frame.origin.x + 1, self.target.frame.origin.y, self.target.frame.size.width, self.target.frame.size.height);
}

@end
