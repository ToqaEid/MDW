//
//  JETSSideMenu.h
//  MDW
//
//  Created by JETS on 4/10/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JETSSideMenu : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
