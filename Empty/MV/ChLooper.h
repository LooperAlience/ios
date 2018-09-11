//
//  ChLooper.h
//  Empty
//
//  Created by SeungChul Kang on 2018. 9. 11..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChLooper : UIView
@property (nonatomic, strong, nonnull) UIView *target;
- (nonnull instancetype)init:(UIView *)view;
@end
