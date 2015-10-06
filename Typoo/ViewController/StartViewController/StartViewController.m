//
//  StartViewController.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 5. 29..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "StartViewController.h"


#define CORNER_RADIUS  10.0f
#define HALF  2

@interface StartViewController ()
{
    NSMutableArray * imageUrlList ;
}
@end
@implementation StartViewController
@synthesize writingBtn , cameraBtn , pickerViewBtn;
@synthesize imageScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    for ( NSString *familyName in [UIFont familyNames] )
    {
        NSLog(@"%@", familyName);
        for ( NSString *fontName in [UIFont fontNamesForFamilyName:familyName] )
            NSLog(@"\t%@", fontName);
    }
    [self decorateButtons];
    [self settingScrollView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



-(void)settingScrollView{
    ScrollViewBuilder *builder = [[ScrollViewBuilder alloc]init];
//    [builder prepareImageWithSender:self scrollview:self.imageScrollView];

}



-(void)decorateButtons{
    self.pickerViewBtn.layer.cornerRadius = CORNER_RADIUS;
    self.cameraBtn.layer.cornerRadius = CORNER_RADIUS;

}
-(void)buttonDecoratorWithButton:(UIButton *)btn imageName:(NSString *)imageName{
    UIImage * image = [UIImage imageNamed:imageName];
    UIImageView * buttonImage = [[UIImageView alloc]initWithImage:image];

    [buttonImage setFrame:CGRectMake( btn.frame.size.width/HALF - image.size.width/HALF,
                                     btn.frame.size.height/HALF - image.size.height/HALF ,
                                     image.size.width, image.size.height)];

    [btn addSubview:buttonImage];
}



#pragma mark -UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Save image
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"UIImagePickerController: User pressed cancel button");
}


#pragma mark - IBActions
- (IBAction)nextCustomImageView:(id)sender {
        NSLog(@"1");
}
- (IBAction)showCameraView:(id)sender {


    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

    // Set source to the camera
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Show image picker
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (IBAction)showImagePickerView:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationPopover;
    
    [self showViewController:picker sender:sender];
}

@end
