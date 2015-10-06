//
//  InstaImageSync.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 2..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface InstaImageSync : NSObject

-(void)requestImageForScrollView;
-(NSInteger)imageListCount;
-(NSMutableArray *)getImageList;
@end
