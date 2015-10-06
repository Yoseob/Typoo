//
//  EditViewController.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 6. 2..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CustomNaviBuilder.h"
#import "JoyPicTextView.h"
#import "ButtonContainerView.h"
#import "EditContainerView.h"
#import "ColorEditViewController.h"
#import "FontEditViewController.h"
typedef enum  editViewsTag{
    color_edit = 10,
    font_edit = 11
}edit_tag;



@interface EditViewController : UIViewController  <JoyPickDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet ButtonContainerView *bottomContainer;

@property (weak, nonatomic) IBOutlet UIButton *okCommitButton;
@property (weak, nonatomic) IBOutlet UIButton *closeDownButton;
@property (weak, nonatomic) IBOutlet UIView *eventBtnContainer;



@end
