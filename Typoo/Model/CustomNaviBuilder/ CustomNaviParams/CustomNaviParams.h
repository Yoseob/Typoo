//
//  CustomNaviParams.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 4..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomNaviParams : NSObject

+(id)InitWithParams:(id)sender;

@property(nonatomic,strong)id sender;
@property(nonatomic,copy)NSString * backgroundImage;
@property(nonatomic,copy)NSString * titleViewImage;

@property(nonatomic,copy)NSString * leftBtnImage;
@property(nonatomic)SEL leftAction;

@property(nonatomic,copy)NSString * rightBtnImage;
@property(nonatomic)SEL rightAction;
@end
