//
//  MyAgenda.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

@class MyAgendaModel;

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "SessionDTO.h"
#import "AgendaDetailsViewController.h"
#import "MyAgendaModel.h"
#import "DateConverter.h"
#import "LabelRendering.h"
#import "Connection.h"

@interface MyAgenda : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


-(void) getDayAgendaArray :(NSMutableArray*) agenda;

@end
