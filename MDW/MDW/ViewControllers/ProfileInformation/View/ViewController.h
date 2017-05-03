//
//  ViewController.h
//  MDW
//
//  Created by JETS on 4/9/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRBarController.h"
#import "SWRevealViewController.h"
#import "AttendeeDTO.h"
#import "MyContactModel.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIImageView *QRImage;

-(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView;

@end

