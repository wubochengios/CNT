//
//  ChangePictureViewController.m
//  MShow
//
//  Created by 姚旭 on 2017/2/9.
//  Copyright © 2017年 YaoXu. All rights reserved.
//

#import "ChangePictureViewController.h"

@interface ChangePictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UIImagePickerController *pickerController;
@property (nonatomic, strong)UIImage *selectedImage;

@end

@implementation ChangePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.view.backgroundColor = [UIColor blackColor];
    
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.pickerController.delegate = self;
    self.pickerController.allowsEditing = YES;
    [self.view addSubview:self.pickerController.view];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    self.selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(PhotoAction:)
               withObject:self.selectedImage
               afterDelay:1];
}

- (void)PhotoAction:(UIImage *)image     
{
    
        [self dismissViewControllerAnimated:YES completion:^{
            [_delegate image:image AndChangeNumber:self.changeNumber];
            
        }];

    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
