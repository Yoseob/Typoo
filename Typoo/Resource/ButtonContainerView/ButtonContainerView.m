//
//  ButtonContainerView.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 7. 18..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "ButtonContainerView.h"
#define SELF_HEIGHT 47

typedef enum BUTTON_TAG{
    KEY_BOARD = 1,
    FONT_BTN = 2,
    COLOR_BTN = 3,
    TEXTSPACE_BTN = 4,
    TEXTALIGN_BTN = 5,
}buttonTag;

@implementation ButtonContainerView
{
    SEL cancelSel , commitSel;
    UIView * preButton;
    UIViewController * target;
    NSMutableArray * editButtons;
    NSMutableArray * bgViews;
}


-(void)setSender:(id)sender{
    
    
    
    target = sender;
    editButtons = [[NSMutableArray alloc]init];
    bgViews = [[NSMutableArray alloc]init];
    //in -> self
    //out => target
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    CGFloat xPoint = 0.0f;
    [bgViews addObject:[UIView new]];
    for(int i = 0; i< 4;i ++){
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(xPoint, 0, target.view.frame.size.width/5,SELF_HEIGHT)];
        [self insertSubview:bgView atIndex:1];
        xPoint +=bgView.frame.size.width;
        [bgViews addObject:bgView];
        
    }

    UIView * one = [bgViews objectAtIndex:KEY_BOARD];
    one.backgroundColor = [UIColor darkGrayColor];
    preButton = one;
}


-(void)updateCurrentSelectedButton:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);

    preButton.backgroundColor = [UIColor clearColor];
    UIView * currentView =[bgViews objectAtIndex:sender.tag];
    currentView.backgroundColor = [UIColor darkGrayColor];
    preButton = currentView;
}

-(void)changeTextAlignImage:(NSString *)imageName{
    UIButton * textAlignViewButton = [self getBtnWithTag:TEXTALIGN_BTN];
    [textAlignViewButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}





-(void)setFontViewButton:(SEL)selector{
    UIButton * fontViewButtn = [self getBtnWithTag:FONT_BTN];
    [self bindButtonWithSelector:fontViewButtn selector:selector];
}
-(void)setColorViewButton:(SEL)selector{
    UIButton * colroViewButton = [self getBtnWithTag:COLOR_BTN];
    [self bindButtonWithSelector:colroViewButton selector:selector];
}
-(void)setTextSpaceViewButton:(SEL)selector{
    UIButton * textSpaceViewButton = [self getBtnWithTag:TEXTSPACE_BTN];
    [self bindButtonWithSelector:textSpaceViewButton selector:selector];
}
-(void)setTextAlignViewButton:(SEL)selector{
    UIButton * textAlignViewButton = [self getBtnWithTag:TEXTALIGN_BTN];
    [self bindButtonWithSelector:textAlignViewButton selector:selector];
}
-(void)setKeyBoardButton:(SEL)selector{
    UIButton * textAlignViewButton = [self getBtnWithTag:KEY_BOARD];
    [self bindButtonWithSelector:textAlignViewButton selector:selector];

}

-(UIButton *)getBtnWithTag:(buttonTag)tag{
    return (UIButton*)[self viewWithTag:tag];
}

-(void)bindButtonWithSelector:(UIButton *)button selector:(SEL)selector{
    [editButtons addObject:button];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setUserInteractionEnabled:YES];
}

- (void)keyboardWillAnimate:(NSNotification *)notification{
    

    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardBounds = [target.view convertRect:keyboardBounds toView:nil];
    [UIView animateWithDuration:0.4 animations:^{
        if([notification name] == UIKeyboardWillShowNotification)
        {
            
            
            CGFloat selfY = target.view.frame.size.height - keyboardBounds.size.height-SELF_HEIGHT;
            
            [self setFrame:CGRectMake(target.view.frame.origin.x,
                                                      selfY,
                                                      self.frame.size.width,
                                                      self.frame.size.height)];
            
        }
        else if([notification name] == UIKeyboardWillHideNotification)
        {
            [self setFrame:CGRectMake(target.view.frame.origin.x,
                                                  target.view.frame.size.height,
                                                  self.frame.size.width,
                                                  self.frame.size.height)];
            
            
        }
        
    }];
    
    
}



@end
