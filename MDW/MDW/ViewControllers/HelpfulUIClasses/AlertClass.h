//
//  AlertClass.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertClass : NSObject

+(UIAlertController*)infoAlertwithTitle: (NSString*)title AndMsg: (NSString*)msg;
+(UIActivityIndicatorView*)progressDialog;
@end
