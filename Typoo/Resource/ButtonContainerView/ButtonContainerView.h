//
//  ButtonContainerView.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 7. 18..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonContainerView : UIView

-(void)setSender:(id)sender;


-(void)setKeyBoardButton:(SEL)selector;
-(void)setFontViewButton:(SEL)selector;
-(void)setColorViewButton:(SEL)selector;
-(void)setTextSpaceViewButton:(SEL)selector;
-(void)setTextAlignViewButton:(SEL)selector;


-(void)changeTextAlignImage:(NSString *)imageName;
-(void)updateCurrentSelectedButton:(UIButton *)sender;


@end
