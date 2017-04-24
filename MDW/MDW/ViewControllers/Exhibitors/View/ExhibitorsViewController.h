//
//  ExhibitorsViewController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

@class ExhibitorModel;

#import <UIKit/UIKit.h>
#import "ExhiptorsDTO.h"
#import "ExhibitorModel.h"

@interface ExhibitorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
