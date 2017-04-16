//
//  MyTicketViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyTicketViewController.h"

@implementation MyTicketViewController

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
    QRBarController * qr = [QRBarController new];
    NSString* encodedData = @"BEGIN:VCARD\nVERSION:3.0\nN:lastname;firstname\nFN:firstname lastname\nORG:organization\nTITLE:jobtitle\nADR:;;street;city;state;zipcode;country\nTEL;WORK;VOICE:0101671542\nTEL;CELL:mobilenum\nTEL;FAX:fax\nEMAIL;WORK;INTERNET:emailaddresss\nURL:website\nEND:VCARD";
    CGImageRef cgImage = [qr encodeQRCode : encodedData];
    UIImage * qrImage = [[UIImage alloc]initWithCGImage:cgImage];
    _ticketImage.image = qrImage;
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
