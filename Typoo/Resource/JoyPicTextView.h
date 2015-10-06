//
//  JoyPicTextView.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 4..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JoyPickDelegate <NSObject>
-(void)onclickedRemove:(NSString*)senderString;

-(void)onclickedDetailEdit:(UIView * )textView;

-(void)moveJoyPickView:(NSString *)joyPic withFrame:(CGRect)rect ;

-(void)onclickedThisJoyPick:(NSString *)joyPic;

-(void)doubleTapToChangeCurrentText:(NSString*)senderString;
@end


@interface JoyPicTextView : UIView <UIGestureRecognizerDelegate , UITextViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame bgImage:(UIImage*)image;


@property(nonatomic,strong)id <JoyPickDelegate> delegate ;
@property(nonatomic,strong)NSString * currentText;
@property(nonatomic,strong)UIImageView * centerImageView;
@property(nonatomic,strong)NSString * selfString;
@property(nonatomic,strong)NSString *frameString;
@property(nonatomic,strong)NSDictionary* textFontAttributes;
@end
