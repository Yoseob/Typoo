//
//  FonteEditViewController.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 8. 12..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
#import "FontTableViewCell/FontTableViewCell.h"
@interface FontEditViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fontTable;


-(void)setSuperViewController:(UIViewController *)sender withView:(UIView*)view withHeight:(CGFloat)height;


-(void)setTargetTextView:(UITextView*)targerView;
@end
