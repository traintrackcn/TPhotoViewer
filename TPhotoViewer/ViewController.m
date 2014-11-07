//
//  ViewController.m
//  TPhotoViewer
//
//  Created by traintrackcn on 6/11/14.
//  Copyright (c) 2014 t. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end




@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 320, 40)];
    [btn setTitle:@"Open Album" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didTapOpen:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapOpen:(id)sender{
    [self openAlbum];
}

- (void)openAlbum{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = NO;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:picker animated:YES completion:nil];
//    [[AGRootViewController singleton] presentVC:picker];
}

#pragma mark - UIPhotoPickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    [self createFullScreenImageView:image];
}


- (void)createFullScreenImageView:(UIImage *)img{
    UIImageView *v = [[UIImageView alloc] initWithImage:img];
    [v setContentMode:UIViewContentModeScaleAspectFit];
    [v setFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:v];
    [v setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *gc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView:)];
    [v addGestureRecognizer:gc];
}

- (void)didTapImageView:(id)sender{
    NSLog(@"sender -> %@",sender);
    UIImageView *imgV  = (UIImageView *)[(UITapGestureRecognizer *)sender view];
    
    [imgV removeFromSuperview];
}

@end
