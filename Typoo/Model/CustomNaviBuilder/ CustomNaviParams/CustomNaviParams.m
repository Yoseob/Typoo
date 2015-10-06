//
//  CustomNaviParams.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 4..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "CustomNaviParams.h"

@implementation CustomNaviParams

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}
+(id)InitWithParams:(id)sender{
    
    CustomNaviParams * params = [[CustomNaviParams alloc]init];
    params.sender = sender;
    return params;
}

@end
