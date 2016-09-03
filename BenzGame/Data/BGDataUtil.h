//
//  BGDataUtil.h
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGDataUtil : NSObject

@property (strong, nonatomic) NSMutableArray *questionsArr;
@property (strong, nonatomic) NSArray * usersArr;


+(instancetype)sharedInstance;

@end
