//
//  BGDataUtil.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGDataUtil.h"
@interface BGDataUtil()

@end

@implementation BGDataUtil

+(instancetype)sharedInstance {
    static BGDataUtil *singleton = nil;
    if (! singleton) {
        singleton = [[self alloc] init];
        singleton.usersArr = @[@{@"id":@1, @"name": @"邦德", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"阿甘", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"云儿", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"小熊熊", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"Bob", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"老范", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"小明", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"o2海马", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"孙行者", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"洛奇", @"avatar": @"avatar_1", @"level": @1, @"identity": @1},
                               @{@"id":@1, @"name": @"查尔斯", @"avatar": @"avatar_1", @"level": @1, @"identity": @1}];
        
        
        singleton.shopListArr = @[@{@"name":@"G-Klasse,G500",@"price":@"¥2,318,000",@"country":@1},
                                  @{@"name":@"GLA-Class 2013,CLA 250 4MATIC",@"price":@"¥2,318,000",@"country":@2}];
    }
    return singleton;
}




@end
