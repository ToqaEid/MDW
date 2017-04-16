//
//  AgendaDetailsViewController.h
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleField;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (weak, nonatomic) IBOutlet UILabel *timeField;
@property (weak, nonatomic) IBOutlet UILabel *detailsField;

@end
