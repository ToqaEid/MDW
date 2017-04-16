//
//  ExhibitorsViewController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) getExhibitorssArray :(NSMutableArray*) speakersArr;

@end
