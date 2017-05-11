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

@implementation ViewController{
    
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
        
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];

        self.navigationItem.leftBarButtonItem = revealButtonItem;
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //QR
    QRBarController * qr = [QRBarController new];
    AttendeeDTO * user = [MyContactModel getUser];
    CGImageRef cgImage = [qr encodeQRCode : [self formEncodedData : user]];    UIImage * qrImage = [[UIImage alloc]initWithCGImage:cgImage];
    _QRImage.image = qrImage;
    
    
    //data
    _mobile.text = [user.mobiles objectAtIndex:0];
    _email.text = user.email;
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
//    return [NSString stringWithFormat:@"BEGIN:VCARD\nVERSION:3.0\nN:%@;%@\nFN:\nORG:%@\nTITLE:%@\nADR:;;;%@;;;%@\nTEL;WORK;VOICE:%@\nTEL;CELL:%@\nTEL;FAX:\nEMAIL;WORK;INTERNET:%@\nURL:\nEND:VCARD", @"sdf", @"sdffdsa", @"comp", @"stu", @"cairo", @"egy", @"010065565", @"5655656565", @"t.e@gmail.com" ];


-(NSString *)formEncodedData: (AttendeeDTO*)user{
    return [NSString stringWithFormat:@"BEGIN:VCARD\nVERSION:3.0\nN:%@;%@\nFN:\nORG:%@\nTITLE:%@\nADR:;;;%@;;;%@\nTEL;WORK;VOICE:%@\nTEL;CELL:%@\nTEL;FAX:\nEMAIL;WORK;INTERNET:%@\nURL:\nEND:VCARD", user.lastName, user.firstName, user.companyName, user.title, user.cityName, user.countryName, [user.phones objectAtIndex:0], [user.mobiles objectAtIndex:0], user.email ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
