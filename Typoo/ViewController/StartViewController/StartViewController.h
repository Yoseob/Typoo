//
//  StartViewController.h
//  Typoo
//
//  Created by LeeYoseob on 2015. 5. 29..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewBuilder.h"

@interface StartViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIButton *writingBtn;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UIButton *pickerViewBtn;

@end
