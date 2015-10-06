//
//  EditViewController.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 2..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "EditViewController.h"
#define KEY_WINDOW 404
@interface EditViewController (){
    CGRect containerTempRect;
    CGRect keyboardBounds;
    NSDictionary * tempUserinfo;
    UITextView * selctedTextView;

    UIImage *tempImage;
    UIImage* originImage;
    NSMutableDictionary * onViewJoyPicDic;
    NSString *currentJpv;
    
    EditContainerView * editContainerView;
    CGRect editContainerFrame;
    NSInteger textCurrentAlign;
    
    UIView * editControlConatinerView;
    UIWindow * keyBoardWindow;
}

@end

@implementation EditViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initValue];
    [self prepareView];
    
}

-(void)initValue{
    onViewJoyPicDic = [[NSMutableDictionary alloc]init];
    textCurrentAlign = 1;
}

-(void)prepareView{
    
    [self.eventBtnContainer setHidden:YES];
    [self.closeDownButton addTarget:self action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.okCommitButton addTarget:self action:@selector(commitEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.imageContainerView.clipsToBounds = YES;
    
    self.bgImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    originImage = [UIImage imageNamed:@"rain"];
    [self customNavibar];
    [self addJoyPickTextView:nil];
    
    containerTempRect = self.imageContainerView.frame;
    [self.bottomContainer setSender:self];
    [self.bottomContainer setColorViewButton:@selector(changeColorViewMake:)];
    [self.bottomContainer setFontViewButton:@selector(changeFontViewMake:)];
    [self.bottomContainer setTextAlignViewButton:@selector(changeTextAlignment:)];
    [self.bottomContainer setTextSpaceViewButton:@selector(changeSpaceLineViewMake:)];
    [self.bottomContainer setKeyBoardButton:@selector(keyboardSelector:)];
}


-(void)customNavibar{
    [self.navigationController setNavigationBarHidden:NO];
    CustomNaviParams * prams = [CustomNaviParams InitWithParams:self];
    prams.backgroundImage = @"top_bg.png";
    prams.titleViewImage = @"title_logo_ic";
    prams.leftBtnImage = @"back_bn";
    prams.leftAction = @selector(leftNaviBarAction:);
    
    [CustomNaviBuilder CustomNavigationBarWithParams:prams];
    self.TextView.hidden = YES;
    
    self.bottomContainer.frame = CGRectMake(0, self.view.frame.size.height,
                                            self.bottomContainer.frame.size.width, 
                                            self.bottomContainer.frame.size.height);


    
}
#pragma makr - KEYBoard Animation

- (void)keyboardWillAnimate:(NSNotification *)notification
{
    
    if(tempUserinfo == nil){
        tempUserinfo = notification.userInfo;
    }
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    if(editContainerView == nil){
        editContainerFrame =CGRectMake(0, self.view.frame.size.height,
                                       keyboardBounds.size.width,
                                       keyboardBounds.size.height);

        editContainerView = [[EditContainerView alloc]initWithFrame:editContainerFrame];
        editContainerView.backgroundColor = [UIColor darkGrayColor];
        [editContainerView setContainerViewSize:keyboardBounds.size withSender:self keyboardUserInfo:tempUserinfo];
        [self.view addSubview:editContainerView];

    }


    [UIView animateWithDuration:0.4 animations:^{
        if([notification name] == UIKeyboardWillShowNotification){
            CGFloat y = self.view.frame.size.height - keyboardBounds.size.height-47;

            [self.bottomContainer setFrame:CGRectMake(self.view.frame.origin.x,
                                                      y,
                                                      self.bottomContainer.frame.size.width,
                                                      self.bottomContainer.frame.size.height)];
            
            if(editControlConatinerView ==nil && keyBoardWindow == nil)
            {

                keyBoardWindow = [[[UIApplication sharedApplication] windows] lastObject];
                NSLog(@"editControlConatinerView Init");
                editControlConatinerView.tag = KEY_WINDOW;
                editControlConatinerView = [[UIView alloc]initWithFrame:keyboardBounds];
                editControlConatinerView.backgroundColor = [UIColor darkGrayColor];
                
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                ColorEditViewController *cevc = [storyBoard instantiateViewControllerWithIdentifier:@"ColorEditViewController"];
                [cevc setButtonContainerViewTarget:self.TextView];
                [cevc setSenderViewController:self withSuperVivew:editControlConatinerView];
                
                FontEditViewController * fevc = [storyBoard instantiateViewControllerWithIdentifier:@"FontEditViewController"];
                [fevc setSuperViewController:self withView:editControlConatinerView withHeight:keyboardBounds.size.height];
                [fevc setTargetTextView:self.TextView];
                
                
                [keyBoardWindow addSubview:editControlConatinerView];
                editControlConatinerView.hidden = YES;
            }
        }
        else if([notification name] == UIKeyboardWillHideNotification){
            {
                [self.bottomContainer setFrame:CGRectMake(self.view.frame.origin.x,
                                                          self.view.frame.size.height,
                                                          self.bottomContainer.frame.size.width,
                                                          self.bottomContainer.frame.size.height)];
   
            }
        }

    }];

}

#pragma mark - customNaviBarBtnSelector


-(void)leftNaviBarAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - JoypicViewFactorMethod
-(JoyPicTextView *)getJoyPickViewWithFrame:(CGRect)rect{
    
    JoyPicTextView * jpv;
    if(originImage){
        jpv = [[JoyPicTextView alloc]initWithFrame:rect bgImage:originImage];
    }else{
        jpv = [[JoyPicTextView alloc]initWithFrame:rect];
    }
    jpv.delegate = self;
    jpv.currentText =[NSString stringWithFormat:@"Double Tap\nTo\nEdit"];
    jpv.selfString = [NSString stringWithFormat:@"%@",jpv];
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    jpv.textFontAttributes =@{NSFontAttributeName: [UIFont fontWithName: @"AnjelikaRose" size:30],
                              NSForegroundColorAttributeName: UIColor.whiteColor,
                              NSParagraphStyleAttributeName: textStyle};


    [onViewJoyPicDic setObject:jpv forKey:jpv.selfString];
    [self drawImageInRect:rect withSender:jpv.selfString];
  
    return jpv;
}


#pragma mark - ibaction
int imageindex = 1;
- (IBAction)changeDefaultImage:(id)sender {
    if(imageindex == 10)
    {
        imageindex = 1;
    }
    originImage = [UIImage imageNamed:[NSString stringWithFormat:@"bgImage_%d",imageindex++]];
}


- (IBAction)addJoyPickTextView:(id)sender {
    
    const CGRect jpyRect = CGRectMake(self.TextView.frame.origin.x - self.imageContainerView.frame.origin.x,
                                self.TextView.frame.origin.y-self.imageContainerView.frame.origin.x,
                                self.TextView.frame.size.width ,150 );
    JoyPicTextView * jpy =[self getJoyPickViewWithFrame:jpyRect];
    [self.imageContainerView addSubview:jpy];
    
}



#pragma mark - JoyPicDelegate 
-(void)onclickedDetailEdit:(UIView *)view{
    NSLog(@"onclickedDetailEdit");
//    [UIView animateWithDuration:0.3f animations:^{
//        containerTempRect = self.imageContainerView.frame;
//        [self.navigationController setNavigationBarHidden:YES];
//        self.imageContainerView.frame = CGRectMake(0, 0,
//                                                   self.imageContainerView.frame.size.width,
//                                                   self.imageContainerView.frame.size.height);
//    }completion:^(BOOL finished) {
//        [self createStateSlider];
//    }];
//
//    [self.TextView becomeFirstResponder];
    
    
}

-(void)onclickedRemove:(NSString *)senderString{
    [onViewJoyPicDic removeObjectForKey:senderString];
    [self drawImageInRect:CGRectZero  withSender:@""];
}

-(void)moveJoyPickView:(NSString *)joyPic withFrame:(CGRect)rect{
    [self drawImageInRect:rect withSender:joyPic];
}
-(void)onclickedThisJoyPick:(NSString *)joyPic{
    currentJpv = joyPic;
}

-(void)doubleTapToChangeCurrentText:(NSString*)sender{
    NSLog(@"doubleTapGesture");

    CGRect changeRect = CGRectZero;
    BOOL isFirst = NO;
    if(![self.TextView isFirstResponder]){
        
        tempImage = self.bgImageView.image;
        self.bgImageView.image = originImage;
        [self.TextView becomeFirstResponder];
        isFirst = YES;
        
        changeRect =  CGRectMake(0, 0,
                                 self.imageContainerView.frame.size.width,
                                 self.imageContainerView.frame.size.height);

    }else{
        [self.TextView resignFirstResponder];
        changeRect = containerTempRect;

    }
    
    [UIView animateWithDuration:0.4f animations:^{
    
 
        //클린된 Jpv의 정보를 텍스트 뷰에 셋팅 한다.
        self.TextView.hidden = !isFirst;
        for(NSString *key  in onViewJoyPicDic.allKeys){
            JoyPicTextView * jpv = [onViewJoyPicDic objectForKey:key];
            if(jpv.selfString == sender){
                
                NSString * string = [NSString stringWithFormat:@"%@" ,jpv.textFontAttributes[@"NSParagraphStyle"] ];
                NSArray * arr = [string componentsSeparatedByString:@","];
                NSString * textAli = arr[0];
                NSTextAlignment textAlignment =[textAli characterAtIndex:textAli.length-1]-'0';
                
                self.TextView.font = jpv.textFontAttributes[@"NSFont"];
                self.TextView.textColor =jpv.textFontAttributes[@"NSColor"];
                self.TextView.text = jpv.currentText;
                self.TextView.textAlignment = textAlignment;
            }
            jpv.hidden = isFirst;

        }

        [[UIApplication sharedApplication]setStatusBarHidden:isFirst];
        [self.eventBtnContainer setHidden:!isFirst];
        [self.navigationController setNavigationBarHidden:isFirst];
        self.imageContainerView.frame = changeRect;
    }completion:^(BOOL finished) {
//        [self createStateSlider];
    }];
}


#pragma mark - slidier
-(void)createStateSlider{
    
    const float sliderHeight = self.imageContainerView.frame.size.height;
    
    UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake( self.imageContainerView.frame.size.width - sliderHeight/2-10,
                                                                  self.imageContainerView.frame.origin.y +self.imageContainerView.frame.size.width/2-10 ,
                                                                  sliderHeight-40, 50) ];
    
    [slider setMaximumValue:1.0f];
    [slider setMinimumValue:0.0f];
    [slider setMinimumTrackTintColor:[UIColor cyanColor]];

    [slider setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [slider setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)sliderValueChange:(UISlider *)sender{

    NSLog(@"%lf" , sender.value);
    

}
#pragma mark - UITextViewDelegate
-(void)doubleTapGesture:(id)sender{
    
    
    
}

#pragma mark - bottomBarAction


-(void)shutDownEditContainerView{
    [UIView animateWithDuration:1.0 animations:^{
        editContainerView.frame = editContainerFrame;
    }];
}
-(void)commitEvent:(id)sender{
    [self shutDownEditContainerView];
    editControlConatinerView.hidden = YES;
    for(NSString *key  in onViewJoyPicDic.allKeys){
        JoyPicTextView * jpv = [onViewJoyPicDic objectForKey:key];
        if(jpv.selfString == currentJpv){
            jpv.currentText = self.TextView.text;
            NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            textStyle.alignment = self.TextView.textAlignment;
            jpv.textFontAttributes = nil;
            jpv.textFontAttributes =@{NSFontAttributeName: self.TextView.font,
                                      NSForegroundColorAttributeName: self.TextView.textColor,
                                      NSParagraphStyleAttributeName: textStyle};
            [self drawImageInRect:CGRectFromString(jpv.frameString) withSender:currentJpv];
        }
    }
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [self doubleTapToChangeCurrentText:@""];
}

-(void)cancelEvent:(id)sender{
    [self shutDownEditContainerView];
    [self doubleTapToChangeCurrentText:@""];
}

-(void)changeFontViewMake:(id)sender{
    NSLog(@"changeFontViewMake");
    [self showThisViewWith:font_edit];
    editControlConatinerView.hidden = NO;
    [self.bottomContainer updateCurrentSelectedButton:(UIButton*)sender];
}

-(void)changeColorViewMake:(id)sender{
    NSLog(@"changeColorViewMake");
    [self showThisViewWith:color_edit];
    editControlConatinerView.hidden = NO;
    [self.bottomContainer updateCurrentSelectedButton:(UIButton*)sender];
}

-(void)changeSpaceLineViewMake:(id)sender{
    NSLog(@"changeSpaceLineViewMake");
    editControlConatinerView.hidden = NO;
    [self.bottomContainer updateCurrentSelectedButton:(UIButton*)sender];
    
}
-(void)keyboardSelector:(id)sender{
    NSLog(@"keboardSelector : %ld",[[UIApplication sharedApplication] windows].count);
    editControlConatinerView.hidden = YES;
    [self.bottomContainer updateCurrentSelectedButton:(UIButton*)sender];
}

-(void)showThisViewWith:(edit_tag)tag{
    for(UIView * view  in editControlConatinerView.subviews){
        if(view.tag == tag){
            view.hidden = NO;
        }else{
            view.hidden = YES;
        }
    }
}
-(void)changeTextAlignment:(id)sender{
    NSString * imageName;
    if(textCurrentAlign > 3) textCurrentAlign =1;
    switch (textCurrentAlign++) {
        case 1:
            imageName =@"left-align";
            [self.TextView setTextAlignment:NSTextAlignmentRight];
            break;
        case 2:
            imageName =@"center-align";
            [self.TextView setTextAlignment:NSTextAlignmentLeft];
            break;
        case 3:
            [self.TextView setTextAlignment:NSTextAlignmentCenter];
            imageName =@"right-align";
            break;
            
    }
    
    [self.bottomContainer changeTextAlignImage:imageName];
}


#pragma mark - TextToImage

- (UIImage*)placeImage:(NSString*)sender onImage:(UIImage*)image changeRect:(CGRect)rect{


    CGSize size = image.size;
    
    if ([UIScreen instancesRespondToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0f);

    } else {
        UIGraphicsBeginImageContext(size);

    }
    [image drawAtPoint:CGPointMake(0, 0)];
    

    for(NSString *key  in onViewJoyPicDic.allKeys){
        JoyPicTextView * jpv = [onViewJoyPicDic objectForKey:key];
        if(key == sender){
            //이미지 캐싱으로 조금이나마 빠른 속도를 낼수 있을것임..
            [[self convertTextToImage:jpv] drawInRect:rect
                                            blendMode:kCGBlendModeOverlay alpha:1.0f];
        }else{
            [[self convertTextToImage:jpv] drawInRect:CGRectFromString(jpv.frameString)
                                                        blendMode:kCGBlendModeOverlay alpha:1.0f];
        }

        
        
    }
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return result;
}


-(UIImage *)convertTextToImage:(JoyPicTextView *)sender{
    
    return [self imageFromString:sender.currentText
                      attributes:sender.textFontAttributes
                            size:[sender.currentText sizeWithAttributes:sender.textFontAttributes]];
}

- (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [string drawInRect:CGRectMake(0 , 0, size.width, size.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



-(void)drawImageInRect:(CGRect)rect withSender:(NSString*)sender{
    self.bgImageView.image = [self placeImage:sender onImage:originImage changeRect:rect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
