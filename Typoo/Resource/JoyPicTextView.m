//
//  JoyPicTextView.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 4..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//




#import "JoyPicTextView.h"
#define EDIT_BTN_SIZE 36
#define CONTAINER_MARGIN 10

#define DOUBLE 2



CG_INLINE CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2)
{
    //Saving Variables.
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    
    return sqrt((fx*fx + fy*fy));
}

typedef enum editBtnIndex{
    EDIT = 0,
    COPY = 1,
    CANCEL = 2,
    RESIZE = 3
}EditBtnIndex;

@implementation JoyPicTextView{
    
    NSMutableArray * editButtonList;
    CGPoint lastLocation , reisizeLastPos;
    BOOL isPress;
    UIButton * ltView,*lbView,*rtView,*resize;
    UIView * containerView;
    UIView * backView;
    
    
    /*
     ver.1에서는 입력과 출력을 같이 하려고 했음
     UITextView * textView;
     */

    /*
     ver.2는 입력과 출력을 분리 joyPick은 textView를 imageView로 바꾸고
     text->image 컨버터 함수 추가, 이미지뷰와 텍스트를를 property 로 추가하여 동적인 변경을 가능하게 하고
     사이즈를 비래로 변경하게 한다.
     */
    
    
    UIImageView * currentImageView;
    //originImage 이미지는 해당 컨텐츠 이미지 이다. 그러므로 TextMode와 이모티콘 모드에서 사용가능하다.
    UIImage * originImage;
    // bgImage 는 EditViewController의 이미지이으로 Property나 setter/getter 설정을 해야한다.



    CGRect originRect;
    
    //아웃 바운더리에서 사용된다.
    CGRect originJoyPickRect;
    BOOL isOverlay;
    CGPoint pre;

}
@synthesize currentText,selfString,frameString;
-(instancetype)init{
    self = [super init];
    if(self){
    
    }
    
    return self;
}




-(instancetype)initWithFrame:(CGRect)frame bgImage:(UIImage*)image{
    self = [super initWithFrame:frame];
    if(self){

        isOverlay = NO;
        containerView = [[UIView alloc]initWithFrame:CGRectMake(CONTAINER_MARGIN,
                                                                CONTAINER_MARGIN,
                                                                self.frame.size.width-CONTAINER_MARGIN*DOUBLE,
                                                                self.frame.size.height-CONTAINER_MARGIN*DOUBLE)];
        containerView.backgroundColor = [UIColor  clearColor];
        [self addSubview:containerView];
        self.backgroundColor = [UIColor clearColor];
        
        
        currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CONTAINER_MARGIN*DOUBLE, CONTAINER_MARGIN*DOUBLE,
                                                               containerView.frame.size.width-CONTAINER_MARGIN*DOUBLE,
                                                               containerView.frame.size.height-CONTAINER_MARGIN*DOUBLE)];
        currentImageView.backgroundColor = [UIColor clearColor];

        backView = [[UIView alloc]initWithFrame:containerView.frame];
        backView.layer.borderWidth=0.0f;
        backView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapGesture:)];
        [doubleTap setNumberOfTapsRequired:DOUBLE];
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapGesture)];
        [singleTap setNumberOfTapsRequired:1];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detectPan:)];
        self.gestureRecognizers = @[panRecognizer,doubleTap,singleTap];
        
        self.userInteractionEnabled = YES;
        isPress = NO;
        editButtonList = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"drawLayer");


    [self updateCurrentImageView];
    [self addSubview:currentImageView];

    
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview: backView];
    
    
    
    [self editBtnFactory:@"edit_bn"
                WithRect:CGRectMake(-5, -5, EDIT_BTN_SIZE, EDIT_BTN_SIZE)
                selector:@selector(editDetailTextView:) withPan:nil];
    
    [self editBtnFactory:@"copy_bn"
                WithRect:CGRectMake(-5, containerView.frame.size.height-5, EDIT_BTN_SIZE, EDIT_BTN_SIZE)
                selector:@selector(test) withPan:nil];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(risizeWithPan:)];
    
    [self editBtnFactory:@"cancel_bn"
                WithRect:CGRectMake(containerView.frame.size.width-5-2, -3, EDIT_BTN_SIZE, EDIT_BTN_SIZE)
                selector:@selector(removeSelfFromSuperView) withPan:nil];
    
    
    resize = [self editBtnFactory:@"size_bn"
                         WithRect:CGRectMake(containerView.frame.size.width-5-2,
                                             containerView.frame.size.height-5-2,
                                             EDIT_BTN_SIZE, EDIT_BTN_SIZE)
                         selector:@selector(reSizeThisView:)
                          withPan:panRecognizer];
    


}

- (void)drawRect:(CGRect)rect {
    
}
#pragma mark - BackroundImage_Change

-(void)updateCurrentImageView{
    currentImageView.image = nil;

    CGPoint selfOrigin = self.frame.origin;

    CGRect changeRect = CGRectMake(selfOrigin.x+currentImageView.frame.origin.x,
                                   selfOrigin.y+currentImageView.frame.origin.y,
                                   currentImageView.frame.size.width,
                                   currentImageView.frame.size.height);
    self.frameString = NSStringFromCGRect(changeRect);
    [self.delegate moveJoyPickView:self.selfString
                              withFrame:changeRect];
    

}
-(void)changeBackgroundImage:(UIImage *)image{

    [self updateCurrentImageView];
}

#pragma mark - SEL gesture


- (void)detectPan:(UIPanGestureRecognizer *) uiPanGestureRecognizer
{
    
    if(uiPanGestureRecognizer.state == UIGestureRecognizerStateBegan){
        [self.superview bringSubviewToFront:self];
        lastLocation = self.center;
        if(isPress == NO){
            [self singleTapGesture];
        }
        
    }else if(uiPanGestureRecognizer.state == UIGestureRecognizerStateEnded){
        [self performSelector:@selector(showAssistBtn) withObject:nil afterDelay:2.5f];
    }else if(uiPanGestureRecognizer.state == UIGestureRecognizerStateChanged){
        
    }
    CGPoint translation = [uiPanGestureRecognizer translationInView:self.superview];
    self.center = CGPointMake(lastLocation.x + translation.x,
                              lastLocation.y + translation.y);
    

    
    [self updateCurrentImageView];
}

-(void)doubleTapGesture:(id)sender{
    NSLog(@"doubleTapGesture");
    [self.delegate doubleTapToChangeCurrentText:selfString];
  
}

-(void)singleTapGesture{
    NSLog(@"singleTapGesture");
    [self.delegate onclickedThisJoyPick:self.selfString];
    [self showAssistBtnWithBool:NO];
    backView.layer.borderWidth=1.0f;
    [self performSelector:@selector(showAssistBtn) withObject:nil afterDelay:3.0f];
    isPress= YES;
}

-(void)showAssistBtn{

    [self showAssistBtnWithBool:YES];
    backView.layer.borderWidth = 0.0f;
    isPress= NO;
}

-(void)showAssistBtnWithBool:(BOOL)isShow{
    for(UIButton * btn in editButtonList){
        btn.hidden = isShow;
    }
}


-(UIButton *)editBtnFactory:(NSString *)imageName WithRect:(CGRect)rect selector:(SEL)action withPan:(UIPanGestureRecognizer*)gesture{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.userInteractionEnabled = YES;
    
    button.hidden = YES;
    button.frame = rect;
    
    if(gesture){
        [button addGestureRecognizer:gesture];
    }
    
    [self addSubview:button];
    [self bringSubviewToFront:button];
    [editButtonList addObject:button];

    return button;
}


#pragma mark - assist button Selector

-(void)editDetailTextView:(id)sender{
    [self.delegate onclickedDetailEdit:currentImageView];
}



-(void)reSizeThisView:(id)sender{
    
    NSLog(@"reSizeThisView");
}


-(void)test{
    
}


-(void)risizeWithPan:(UIPanGestureRecognizer *)sender{

    CGPoint translation = [sender translationInView:self.superview];
    if(sender.state == UIGestureRecognizerStateBegan){
        [self.superview bringSubviewToFront:self];
        originRect = self.frame;
        reisizeLastPos = resize.center;
        pre = CGPointZero;

        
    }else if(sender.state == UIGestureRecognizerStateChanged){



        resize.center = CGPointMake(reisizeLastPos .x + translation.x,
                                    reisizeLastPos.y + translation.y);

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                originRect.size.width + translation.x,
                                originRect.size.height + translation.y);

        containerView.frame = CGRectMake(containerView.frame.origin.x,
                                         containerView.frame.origin.y,
                                         self.frame.size.width-CONTAINER_MARGIN*DOUBLE,
                                         self.frame.size.height-CONTAINER_MARGIN*DOUBLE);
        
        currentImageView.frame = CGRectMake(currentImageView.frame.origin.x,
                                    currentImageView.frame.origin.y,
                                    self.frame.size.width-CONTAINER_MARGIN*DOUBLE*DOUBLE,
                                    self.frame.size.height-CONTAINER_MARGIN*DOUBLE*DOUBLE);
        
        backView.frame = CGRectMake(backView.frame.origin.x,
                                    backView.frame.origin.y,
                                    self.frame.size.width-CONTAINER_MARGIN*DOUBLE,
                                    self.frame.size.height-CONTAINER_MARGIN*DOUBLE);
        
        UIButton *cancelBtn = editButtonList[CANCEL];
        cancelBtn.frame = CGRectMake(resize.frame.origin.x,
                                     cancelBtn.frame.origin.y,
                                     cancelBtn.frame.size.width,
                                     cancelBtn.frame.size.height);
        UIButton *copyBtn = editButtonList[COPY];
        copyBtn.frame = CGRectMake(copyBtn.frame.origin.x,
                                     resize.frame.origin.y,
                                     copyBtn.frame.size.width,
                                     copyBtn.frame.size.height);
        
        [self updateCurrentImageView];

        
    }else if(sender.state == UIGestureRecognizerStateEnded){

    }

   
    NSLog(@"risizeWithPan");
}

-(void)removeSelfFromSuperView{
    NSLog(@"removeSelfFromSuperView");
    [self.delegate onclickedRemove:self.selfString];
    [self removeFromSuperview];
    
}
@end
