//
//  AgendaDetailsViewController.h
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//
@class AgendaDetailsModel;

#import <UIKit/UIKit.h>
#import "AgendaDetailsModel.h"
#import "SessionDTO.h"
#import "DateConverter.h"
#import "UIView+Toast.h"

@interface AgendaDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleField;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (weak, nonatomic) IBOutlet UILabel *timeField;
@property (weak, nonatomic) IBOutlet UILabel *detailsField;
@property (weak, nonatomic) IBOutlet UILabel *locationField;
- (IBAction)ratingAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *speakersView;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@property SessionDTO * session;

-(void) showToast : (NSString *) msg;

-(void) setStatusFromServer : (NSMutableDictionary*) dict;


@end
