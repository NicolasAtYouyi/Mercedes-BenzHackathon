//
//  BGDataUtil.m
//  BenzGame
//
//  Created by wangyangyang on 16/9/3.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

#import "BGDataUtil.h"
@interface BGDataUtil()

@property (strong, nonatomic) NSMutableArray *questionsArr;
@property (strong, nonatomic) NSMutableArray * usersArr;

@end

@implementation BGDataUtil

+(instancetype)sharedInstance {
    static BGDataUtil *singleton = nil;
    if (! singleton) {
        singleton = [[self alloc] init];
    }
    return singleton;
}

- (NSMutableArray *)getQuestionArr{
    
    if (_questionsArr == nil || _questionsArr.count <= 0) {
        
        
        
        
        
        
    }
    
    return _questionsArr;
}




@end
