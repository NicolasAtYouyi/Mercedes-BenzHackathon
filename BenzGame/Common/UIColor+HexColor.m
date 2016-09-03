//
//  UIColor+HexColor.m
//  NiceApp
//
//  Created by lz on 13-12-3.
//  Copyright (c) 2013年 brixd. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)


+ (UIColor *)colorWithHexStr:(NSString *)hex
{
    return [self colorWithHexStr:hex alpha:1.f];
}

+ (UIColor *)colorWithHexStr:(NSString *)hex alpha:(CGFloat)alpha
{
    if ([hex hasPrefix:@"0X"])
        hex = [hex substringFromIndex:2];
    if ([hex hasPrefix:@"#"])
        hex = [hex substringFromIndex:1];
    
    if ([hex length]!=6 && [hex length]!=3)
    {
        return nil;
    }
    
    NSUInteger digits = [hex length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    int resultR = 0;
    NSString *strR = [hex substringWithRange:NSMakeRange(0, digits)];
    sscanf([strR UTF8String], "%x", &resultR);
    
    int resultG = 0;
    NSString *strG = [hex substringWithRange:NSMakeRange(digits, digits)];
    sscanf([strG UTF8String], "%x", &resultG);
    
    int resultB = 0;
    NSString *strB = [hex substringWithRange:NSMakeRange(2*digits, digits)];
    sscanf([strB UTF8String], "%x", &resultB);
    
    CGFloat red = resultR/maxValue;
    CGFloat green = resultG/maxValue;
    CGFloat blue = resultB/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)hexStringFromColor{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end
