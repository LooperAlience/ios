//
//  ChMap.h
//  Empty
//
//  Created by SeungChul Kang on 2018. 8. 28..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChType.h"

@interface ChMap : NSMutableDictionary
- (nonnull ChMap*)set:(nonnull NSString *)_ :(nonnull id)_;
- (id)get:(nonnull NSString *)_;
- (nullable id)o:(nonnull NSString *)_;
@end
