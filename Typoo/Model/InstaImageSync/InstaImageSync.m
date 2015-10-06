    //
//  InstaImageSync.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 2..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//


//아이디:joy_pic 비번: dldygks
#import "InstaImageSync.h"
#define ZERO 0
#define INSTA_URL @"https://api.instagram.com/v1/users/44037846/media/recent?access_token=44037846.1fb234f.b7c90faa45fe4ab799cb66bc6341f650"
#define WANT_IMAGE_COUNT 10
@implementation InstaImageSync
{
    NSMutableArray *imageUrlList;
}
-(void)requestImageForScrollView{
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    
    
    NSURL * url = [NSURL URLWithString:INSTA_URL];
    NSData * resultData = [NSData dataWithContentsOfURL:url];
    NSError * error = nil;
    
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:&error];
    NSArray * arr = result[@"data"];
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    imageUrlList = [[NSMutableArray alloc]init];
    int count = 0;

    for(NSDictionary * detailDic in arr){
        if(count == WANT_IMAGE_COUNT){
            break;
        }
        NSDictionary * imageDic = [detailDic objectForKey:@"images"];
        [imageUrlList addObject:[imageDic objectForKey:@"low_resolution"][@"url"]];
        count ++;
    }

    
}

-(NSMutableArray *)getImageList{
    if(!imageUrlList){
        [self requestImageForScrollView];
    }
    return imageUrlList;
}

-(NSInteger)imageListCount{
    if(imageUrlList == nil) {
        return ZERO;
    }
    return imageUrlList.count;
}


@end
