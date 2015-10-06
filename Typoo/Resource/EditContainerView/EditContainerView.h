//
//  EditContainerView.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 7. 19..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditContainerView : UIView
-(void)setContainerViewSize:(CGSize)size withSender:(id)target keyboardUserInfo:(NSDictionary *)userinfo;


-(BOOL)isFirstResponder;
-(void)resignFirstResponder;
-(void)becomeFirstResponder;
@end
