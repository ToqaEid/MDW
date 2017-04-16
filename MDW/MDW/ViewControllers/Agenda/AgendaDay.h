//
//  AgendaDay1.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface AgendaDay : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) getDayAgendaArray :(NSMutableArray*) agenda;

@end
