//
//  CustomNaviBuilder.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 4..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "CustomNaviBuilder.h"

@implementation CustomNaviBuilder

+(void)CustomNavigationBarWithParams:(CustomNaviParams *)prams{
    if(prams){
        if(prams.sender){
            UINavigationController *navCon = ((UIViewController *)prams.sender).navigationController;
            UINavigationItem *navItem = ((UIViewController *)prams.sender).navigationItem;
            if(prams.backgroundImage){
                [navCon.navigationBar setBackgroundImage:[UIImage imageNamed:prams.backgroundImage]
                                           forBarMetrics:UIBarMetricsDefault];
            }
            
            if(prams.titleViewImage){
                UIImage * logoImage = [UIImage imageNamed:prams.titleViewImage];
                UIImageView * logoImageView = [[UIImageView alloc] initWithImage: logoImage];
                [logoImageView setFrame:CGRectMake(0, 100.0f,logoImage.size.width, logoImage.size.height)];
                navItem.titleView = logoImageView;
                
            }
            
            
            if(prams.leftBtnImage){
                UIImage *navLeftBtnImage = [UIImage imageNamed:prams.leftBtnImage];
                UIButton *navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, navLeftBtnImage.size.width/1.5f, navLeftBtnImage.size.height/1.5f)];
                UIBarButtonItem *navLeftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
                [navLeftBtn setBackgroundImage:navLeftBtnImage forState:UIControlStateNormal];
                UIBarButtonItem *navLeftPadding = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                [navLeftPadding setWidth:-5.0f];    // 왼쪽 Bar 버튼 공백 제거
                
                if(prams.leftAction){
                    [navLeftBtn addTarget:prams.sender action:prams.leftAction forControlEvents:UIControlEventTouchUpInside];
                }
                navItem.leftBarButtonItems = [NSArray arrayWithObjects:navLeftPadding, navLeftBarBtn, nil];
            }
            
        }
    }
}

+ (void)customNavigationBar:(id)sender bgNavBarName:(NSString*)bgNavBarName imgLogoName:(NSString*)imgLogoName imgLogoSelectedName:(NSString *)imgLogoSelectedName logoAction:(BOOL)isLogoAction textLogoName:(NSString*)textLogoName btnLeftMenuName:(NSString*)btnLeftMenuName btnLeftMenuSelectedName:(NSString*)btnLeftMenuSelectedName btnLeftText:(NSString *)leftBtnText btnRightMenuName:(NSString*)btnRightMenuName btnRightMenuSelectedName:(NSString*)btnRightMenuSelectedName btnRightText:(NSString *)rightBtnText
{
    UINavigationController *navCon = ((UIViewController *)sender).navigationController;
    UINavigationItem *navItem = ((UIViewController *)sender).navigationItem;
    
    [navCon.navigationBar setBackgroundImage:[UIImage imageNamed:bgNavBarName] forBarMetrics:UIBarMetricsDefault];
    
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];   // 네비게이션바 그림자 제거
    
    if(imgLogoName != nil)
    {
        if (isLogoAction == NO)
        {
            UIImage * logoImage = [UIImage imageNamed:imgLogoName];
            
            UIImageView * logoImageView = [[UIImageView alloc] initWithImage: logoImage];
            //            [logoImageView setFrame:CGRectMake(0, 10.0f,65.0f, 27.0f)];
            
            [logoImageView setFrame:CGRectMake(0, 100.0f,logoImage.size.width, logoImage.size.height)];
            navItem.titleView = logoImageView;
        }
        else
        {
            UIImage *logoImg = [UIImage imageNamed:imgLogoName];
            UIButton *logoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, logoImg.size.width, logoImg.size.height)];
            [logoBtn setImage:logoImg forState:UIControlStateNormal];
            
            if (imgLogoSelectedName != nil)
            {
                UIImage *logoBtnSelectedImage = [UIImage imageNamed:imgLogoSelectedName];
                [logoBtn setBackgroundImage:logoBtnSelectedImage forState:UIControlStateHighlighted];
            }
            
            [logoBtn addTarget:sender action:@selector(logoButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
            
            navItem.titleView = logoBtn;
        }
    }
    else
    {
        // 네비게이션바 타이틀에 폰트 설정
        
        //         UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, navCon.navigationBar.frame.size.width, navCon.navigationBar.frame.size.height)];
        
        CGFloat navHeight = navCon.navigationBar.frame.size.height;
        CGFloat navWidth = navCon.navigationBar.frame.size.width;
        UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(navWidth/2-50.0f, 0.0f,100.0f, navHeight)];
        
        [navTitleLabel setBackgroundColor:[UIColor clearColor]];
        [navTitleLabel setText:textLogoName];
        [navTitleLabel setTextColor:[UIColor whiteColor]];
        [navTitleLabel setTextAlignment:NSTextAlignmentCenter];
        //[navTitleLabel setFont:[UIFont fontWithName:@"SeoulNamsanB" size:20.0f]];
        [navTitleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [navTitleLabel setAdjustsFontSizeToFitWidth:YES];
        [navItem setTitleView:navTitleLabel];
        
        
        navItem.title = textLogoName;
    }
    
    if (btnLeftMenuName != nil)
    {
        UIImage *navLeftBtnImage = [UIImage imageNamed:btnLeftMenuName];
        UIButton *navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, navLeftBtnImage.size.width/2, navLeftBtnImage.size.height/2)];
        UIBarButtonItem *navLeftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
        [navLeftBtn setBackgroundImage:navLeftBtnImage forState:UIControlStateNormal];
        
        if (btnLeftMenuSelectedName != nil)
        {
            UIImage *navLeftBtnSelectedImage = [UIImage imageNamed:btnLeftMenuSelectedName];
            [navLeftBtn setBackgroundImage:navLeftBtnSelectedImage forState:UIControlStateHighlighted];
        }
        if(leftBtnText != nil){
            [navLeftBtn setTitle:leftBtnText forState:UIControlStateNormal];
            UILabel * leftTextLabel = [navLeftBtn titleLabel];
            [leftTextLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
            
        }
        
        UIBarButtonItem *navLeftPadding = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [navLeftPadding setWidth:-5.0f];    // 왼쪽 Bar 버튼 공백 제거
        
        [navLeftBtn addTarget:sender action:@selector(leftButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
        navItem.leftBarButtonItems = [NSArray arrayWithObjects:navLeftPadding, navLeftBarBtn, nil];
    }
    else
    {
        [navItem setHidesBackButton:YES];
    }
    
    if (btnRightMenuName != nil)
    {
        
        //이미지 사이즈 조정 절대적이지 않다.
        UIImage *navRightBtnImage = [UIImage imageNamed:btnRightMenuName];
        UIButton *navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, navRightBtnImage.size.width/2, navRightBtnImage.size.height/2)];
        UIBarButtonItem *navRightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
        [navRightBtn setBackgroundImage:navRightBtnImage forState:UIControlStateNormal];
        
        if (btnRightMenuSelectedName != nil)
        {
            UIImage *navRightBtnSelectedImage = [UIImage imageNamed:btnRightMenuSelectedName];
            [navRightBtn setBackgroundImage:navRightBtnSelectedImage forState:UIControlStateHighlighted];
        }
        if(rightBtnText != nil){
            if([rightBtnText intValue] > 1){
                UILabel * rightTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(18.0f, 6.0f, 10.0f, 10.0f)];
                [rightTextLabel setTextColor:[UIColor whiteColor]];
                [rightTextLabel setText:rightBtnText];
                [rightTextLabel setBackgroundColor:[UIColor clearColor]];
                [rightTextLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
                [navRightBtn addSubview:rightTextLabel];
                
            }else{
                
                [navRightBtn setTitle:rightBtnText forState:UIControlStateNormal];
                UILabel * rightTextLabel = [navRightBtn titleLabel];
                [rightTextLabel setTextColor:[UIColor whiteColor]];
                [rightTextLabel setBackgroundColor:[UIColor clearColor]];
                [rightTextLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
                
            }
        }
        
        UIBarButtonItem *navRightPadding = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [navRightPadding setWidth:-5.0f];   // 오른쪽 Bar 버튼 공백 제거
        
        [navRightBtn addTarget:sender action:@selector(rightButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
        navItem.rightBarButtonItems = [NSArray arrayWithObjects:navRightPadding, navRightBarBtn, nil];
    }
}


@end
