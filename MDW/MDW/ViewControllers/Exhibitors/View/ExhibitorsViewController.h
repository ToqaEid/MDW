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
#import "VisitedViews.h"
#import "UIView+Toast.h"


@interface ExhibitorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) setAllExhibitors : (NSMutableArray *)exhibitors;

//-(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject:(id)object;

@end
