//
//  AlertClass.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AlertClass.h"

@implementation AlertClass


+(UIAlertController*)infoAlertwithTitle: (NSString*)title AndMsg: (NSString*)msg{

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:nil];
    
    
    
    //Add your buttons to alert controller
    
    [alert addAction:okButton];
    return alert;
}


@end
