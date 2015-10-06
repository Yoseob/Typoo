//
//  ColorEditViewController.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 8. 9..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "ColorEditViewController.h"


@interface ColorEditViewController(){
    UITextView * targetTextView;
    UIButton * preButton;
    EditViewController * senderViewController;
}

@end
@implementation ColorEditViewController

-(void)setSenderViewController:(UIViewController*)vc withSuperVivew:(UIView*)view{
    senderViewController = (EditViewController*)vc;
    [senderViewController addChildViewController:self];
    self.colorContainer.hidden = YES;
    [view addSubview:self.colorContainer];
    self.colorContainer.tag = color_edit;
    
}

-(void)setButtonContainerViewTarget:(UITextView *)textView{
    NSLog(@"ColorEditViewController");
    targetTextView =textView;

    NSMutableArray * colorArr = [[NSMutableArray alloc]initWithArray:@[[UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:222/255.f green:142/255.f blue:100/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:255/255.f green:175/255.f blue:64/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:255/255.f green:121/255.f blue:77/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:242/255.f green:121/255.f blue:172/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:255/255.f green:89/255.f blue:103/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:189/255.f green:83/255.f blue:84/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:157/255.f green:193/255.f blue:94/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:104/255.f green:191/255.f blue:96/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:51/255.f green:204/255.f blue:191/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:173/255.f green:217/255.f blue:239/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:109/255.f green:176/255.f blue:242/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:80/255.f green:130/255.f blue:229/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:120/255.f green:112/255.f blue:204/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:244/255.f green:245/255.f blue:211/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:166/255.f green:101/255.f blue:99/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:71/255.f green:76/255.f blue:85/255.f alpha:1.0],
                                                                       [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0],]];
    
    NSInteger colorIndex = 0;
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.colorContainer.backgroundColor = [UIColor clearColor];
    for(UIButton * button in self.colorContainer.subviews){
        button.layer.cornerRadius =  button.frame.size.width/2;
        button.backgroundColor = (UIColor*)[colorArr objectAtIndex:colorIndex++];
        [button addTarget:self action:@selector(selectedColorButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    preButton = [self.colorContainer.subviews objectAtIndex:0];
}


-(void)selectedColorButton:(UIButton *)sender{
    NSLog(@"%@",[targetTextView text]);
    preButton.layer.borderWidth = 0;
    sender.layer.borderWidth =1;
    sender.layer.borderColor = [UIColor whiteColor].CGColor;
    preButton = sender;
    [targetTextView setTextColor:sender.backgroundColor];
    

}
@end
