//
//  ViewController.m
//  MDW
//
//  Created by JETS on 4/9/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QRBarController * qr = [QRBarController new];
    CGImageRef cgImage = [qr encodeQRCode];
    UIImage * qrImage = [[UIImage alloc]initWithCGImage:cgImage];
    _QRImage.image = qrImage;
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
