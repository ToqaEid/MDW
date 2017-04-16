//
//  SpeakersViewController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

-(void) getSpeakersArray :(NSMutableArray*) speakersArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
