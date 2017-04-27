//
//  SpeakersViewController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "SpeakersModel.h"
#import "SpeakerDTO.h"
#import "SpeakerDetailsViewController.h"

@interface SpeakersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject: (id)object;

-(void)downloadSpeakerImage:(SpeakerDTO *) object;

-(void) setAllSpeakers : (NSMutableArray *) sp;


@end
