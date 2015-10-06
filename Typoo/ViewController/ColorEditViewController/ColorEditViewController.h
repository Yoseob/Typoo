//
//  ColorEditViewController.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 8. 9..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
@interface ColorEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *colorContainer;


-(void)setSenderViewController:(UIViewController *)vc withSuperVivew:(UIView*)view;
-(void)setButtonContainerViewTarget:(id)sender;
@end
