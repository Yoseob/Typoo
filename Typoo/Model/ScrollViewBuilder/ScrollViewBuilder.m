//
//  ScrollViewBuilder.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 2..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "ScrollViewBuilder.h"


#define ZERO 0
#define MARGIN 10
@implementation ScrollViewBuilder
{
    InstaImageSync * instasync;
}

-(instancetype)init{
    self = [super init];
    if(self){
        instasync = [[InstaImageSync alloc]init];
//        [instasync requestImageForScrollView];
    }
    
    return self;
}


-(void)prepareImageWithSender:(id)sender scrollview:(UIScrollView *)scrollView{

    

    NSMutableArray *imageUrlList = [instasync getImageList];
    
    CGFloat contentSize =  scrollView.frame.size.height;
    CGFloat contentX = ZERO;
    scrollView.contentSize = CGSizeMake(contentSize * imageUrlList.count, contentSize);
    
    for(int i = ZERO ; i < imageUrlList.count; i ++){
        UIImageView * contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(contentX, ZERO,  contentSize,  contentSize)];
        contentImageView.backgroundColor = [UIColor redColor];
        contentX+=(contentSize)+MARGIN;
        [self getIndexImageWithUrl:imageUrlList[i] complete:^(id image) {
            contentImageView.image  = (UIImage*)image;
            [scrollView addSubview:contentImageView];
            
        } ];
        
        
    }
    
  
}


-(void)getIndexImageWithUrl:(NSString*)imageUrl complete:(void(^)(id image)) comp {
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *imag = [UIImage imageWithData:data];
    comp(imag);
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];

}

@end
