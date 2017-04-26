//
//  AgendaDay1.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AgendaDayModel.h"
#import "LabelRendering.h"
#import "DateConverter.h"
#import "SessionDTO.h"
#import "AgendaDetailsViewController.h"
#import "Connection.h"
#import "AgendaImages.h"
#import "VisitedViews.h"

@interface AgendaDay : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;



-(void) setAllSessionsArray : (NSMutableArray* ) sessions;
-(void)showErrorToast : (NSString *)toastMsg;


@end
