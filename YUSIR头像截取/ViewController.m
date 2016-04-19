//
//  ViewController.m
//  YUSIR头像截取
//
//  Created by sq-ios40 on 16/3/23.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)selectImageClicked:(UIButton *)sender {
    // 1.创建UIImagePickerController
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];

    UIAlertController*actionSheet = [UIAlertController alertControllerWithTitle:@"actionSheet" message:@"上传头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *testAction = [UIAlertAction actionWithTitle:@"网上寻找" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheet addAction:testAction];
    //拍照片
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnullaction) {
        // 拍照
        // 1)配置拾取源
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 2)设置摄像头(选择前置/后置)
        // UIImagePickerControllerCameraDeviceRear 后置
        // UIImagePickerControllerCameraDeviceFront 前置
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置编辑模式
        imagePickerController.allowsEditing = YES;
        // 设置代理
        imagePickerController.delegate = self;
        
        // 3.显示
        [self presentViewController:imagePickerController animated:YES completion:nil];

    }];
    [actionSheet addAction:photoAction];
    
//    选择图库截图
    UIAlertAction*defaultAction = [UIAlertAction actionWithTitle:@"图库"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnullaction) {
                // 从相册中获取照片
        // 配置拾取源
        // 默认值为图片库
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置编辑模式
        imagePickerController.allowsEditing = YES;
        // 设置代理
        imagePickerController.delegate = self;
        
        // 3.显示
        [self presentViewController:imagePickerController animated:YES completion:nil];

    }];
    [actionSheet addAction:defaultAction];
    UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnullaction) {
    }];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - iamge picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"didFinishPickingMediaWithInfo");
    
    // 从结果字典中获取media type, 根据其类型做不同操作
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // 选择本机照片或拍照
        // 根据编辑模式选择显示原始图片/编辑图片
        if (picker.allowsEditing) {
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            self.headImageView.image = image;
        } else {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            self.headImageView.image = image;
        }
        
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        // 摄像头摄像
        // 获取拍摄的视频信息
        NSURL *movieURL = [info objectForKey:UIImagePickerControllerMediaURL];
        // 获取路径
        NSString *filePath = movieURL.path;
        // 保存
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(filePath)) {
            // 保存到相簿
//            UISaveVideoAtPathToSavedPhotosAlbum(filePath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    
    // dismiss
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"取消操作");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
