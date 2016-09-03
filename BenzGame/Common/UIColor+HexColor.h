//
//  UIColor+HexColor.h
//  NiceApp
//
//  Created by lz on 13-12-3.
//  Copyright (c) 2013年 brixd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorWithHexStr:(NSString *)hex;
+ (UIColor *)colorWithHexStr:(NSString *)hex alpha:(CGFloat)alpha;
- (NSString *)hexStringFromColor;
@end
