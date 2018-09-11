//
//  Ch.m
//  Empty
//
//  Created by SeungChul Kang on 2018. 9. 4..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import "Ch.h"

@interface Ch ()
//@property (class, readonly, nonatomic) ChMap *map;
@end

@implementation Ch
+ (nonnull id)sss:(id)arg1, ... {
    va_list args;
    va_start(args, arg1);

    for (id arg = arg1; arg != nil; arg = va_arg(args, id)) {
        NSLog(@"Argument: %@", arg);
    }
    va_end(args);

    return nil;
}

+ (nonnull ChMap *)map {
    static ChMap *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{   // dispatch_once를 통해 객체를 획득하는 부분의 상호배제
        if (!instance) {
            instance = [ChMap new];
        }
    });
    return instance;

}

+ (void)set:(nonnull NSString *)k :(nonnull id)v {
    @synchronized(self.map) {
        [self.map set:k :v];
    }
}

+ (nonnull id)get:(nonnull NSString *)k {
    id ret;
    @synchronized(self.map) {
        ret = [self.map get:k];
        if (!ret) ret = ChType.EMPTY;
    }
    return ret;
}

@end
