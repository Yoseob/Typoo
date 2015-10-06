//
//  EditContainerView.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 7. 19..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "EditContainerView.h"

@implementation EditContainerView
{
    BOOL isShow;
    CGSize keyboardBounds;
    UIViewController * sender;
    NSDictionary * tempUserinfo;
}
-(void)setContainerViewSize:(CGSize)size withSender:(id)target keyboardUserInfo:(NSDictionary *)userinfo{
    sender = target;
    keyboardBounds = size;
    tempUserinfo = userinfo;
    
}

-(BOOL)isFirstResponder{
    return isShow;
}
-(void)resignFirstResponder{
    isShow = NO;
    [self performSelector:@selector(hideContainerView:) withObject:nil afterDelay:0];
}

-(void)hideContainerView:(id)_sender{
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(0,
                                sender.view.frame.size.height,
                                keyboardBounds.width,
                                keyboardBounds.height);
    }completion:^(BOOL finished) {
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardWillHideNotification
                                                       object:nil
                                                     userInfo:tempUserinfo];
    
    
}
-(void)becomeFirstResponder{
    isShow = YES;
    [self performSelector:@selector(showContainerView:) withObject:nil afterDelay:0.3];
    
}

-(void)showContainerView:(id)_sender{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(0,
                                sender.view.frame.size.height - keyboardBounds.height,
                                keyboardBounds.width,
                                keyboardBounds.height);
    }completion:^(BOOL finished) {
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardWillShowNotification
                                                       object:nil
                                                     userInfo:tempUserinfo];
    
}

@end
