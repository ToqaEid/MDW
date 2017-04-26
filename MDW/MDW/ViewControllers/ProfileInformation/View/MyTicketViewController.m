//
//  MyTicketViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyTicketViewController.h"

@implementation MyTicketViewController{
    
    MyContactModel * model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //side menu
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:revealViewController
                                                                            action:@selector(revealToggle:)];
        
        
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //QR
    QRBarController * qr = [QRBarController new];
    
    
    
    AttendeeDTO * user = user = [MyContactModel getUser];;
    CGImageRef cgImage = [qr encodeQRCode : user.code];
    UIImage * qrImage = [[UIImage alloc]initWithCGImage:cgImage];
    _ticketImage.image = qrImage;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
