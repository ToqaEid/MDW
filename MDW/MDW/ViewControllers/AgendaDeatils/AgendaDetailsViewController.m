//
//  AgendaDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDetailsViewController.h"


@implementation AgendaDetailsViewController{
    AgendaDetailsModel * model;
    UITableView *speakersTable;
}


-(void)viewWillAppear:(BOOL)animated{
    
    _titleField.attributedText = [LabelRendering renderHTML:_session.name];
    [_titleField setTextAlignment:NSTextAlignmentCenter];
    
    UIFont *font = _titleField.font;
    _titleField.font = [font fontWithSize:16];

    
    _titleField.numberOfLines = 0;
    _titleField.adjustsFontSizeToFitWidth = YES;
    [_titleField sizeToFit];
    
    
    
    
    _dateField.text = [DateConverter dateStringFromDate: _session.startDate];
    
    
    
    
    _timeField.text = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate: _session.startDate] , [DateConverter stringFromDate: _session.endDate]];
    
    
    
    
//    _detailsField.numberOfLines = 0;
//    _detailsField.lineBreakMode= NSLineBreakByWordWrapping;

    _detailsField.attributedText = [LabelRendering renderHTML:_session.SessionDescription];
    
    
    
//    CGRect frame = _detailsField.frame;
//    frame.size.height = 1;
//    _detailsField.frame = frame;
//    CGSize fittingSize = [_detailsField sizeThatFits:frame.size];
//    frame.size.height = fittingSize.height;
//    _detailsField.frame = frame;
//    _detailsField.adjustsFontSizeToFitWidth = YES;
    
    
//    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
//    
//    CGSize expectedLabelSize = [yourString sizeWithFont:yourLabel.font constrainedToSize:maximumLabelSize lineBreakMode:yourLabel.lineBreakMode];
//    
//    //adjust the label the the new height.
//    CGRect newFrame = yourLabel.frame;
//    newFrame.size.height = expectedLabelSize.height;
//    _detailsField.frame = newFrame;
//    
    
    _locationField.text = _session.location;
    [_starButton setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];


}

-(void)viewDidLoad{
    model = [[AgendaDetailsModel alloc]initWithController:self];
    
    
    //prepare speakers table view
    if((_session.speakers.count > 0)){
        speakersTable = [[UITableView alloc] initWithFrame:CGRectMake(6, 0, 260, 300)];
        speakersTable.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        speakersTable.delegate = self;
        speakersTable.dataSource = self;
        //set background image
        speakersTable.backgroundColor = [UIColor clearColor];
        UIView * speakersView = [self.view viewWithTag:9];
    
        [speakersView addSubview:speakersTable];
    }
    printf(" +++ SessionDetails is Loaded .... \n");
    
    printf("\nsession details %d\n", _session.status);
}

/*========================== Speakers Table ======================*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _session.speakers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.imageView.image = [UIImage imageWithData:[_session.speakers objectAtIndex:indexPath.row].image];
    cell.textLabel.text = [_session.speakers objectAtIndex:indexPath.row].firstName;
    return cell;

}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Speakers";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpeakerDTO * speaker = [_session.speakers objectAtIndex:indexPath.row];
    
    SpeakerDetailsViewController *speakerDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakerDetailsViewController"];
    
    //pass data to detailed view
    speakerDetails.speaker = speaker;
    
    
    //open detailed view
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"MDW"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController pushViewController:speakerDetails animated:YES ];
    
}

/*==== End of Speakers Table ====*/

- (IBAction)ratingAction:(id)sender {
    
    
    if(_session.status == 0){
        
        //register session
        [model registerSessionWithSessionObj:_session AndEnforce:false];
     
        
    }else{
        
        //unregister session
        [model unregisterSession:_session];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        _session.status = 0;
        [realm commitWriteTransaction];
        
        //change star image
        [sender setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];
    }
    
}

-(UIImage*)getSessionStatusImage{
    UIImage *registerStar;
    if(_session.status == 1){
        registerStar = [UIImage imageNamed:@"sessionpending.png"];
    }else if(_session.status == 2){
        registerStar = [UIImage imageNamed:@"sessionapproved.png"];
    }else {
        registerStar = [UIImage imageNamed:@"sessionnotadded.png"];
    }
    return registerStar;

}

-(void) showToast : (NSString *) msg{
    [self.view makeToast:msg];
}




-(void) setStatusFromServer : (NSMutableDictionary*) dict{

    printf("### old = %d , status = %d\n",  [[dict objectForKey:@"oldSession"]intValue], [[dict objectForKey:@"status"]intValue] );
    
    int oldSession =  [[dict objectForKey:@"oldSession"]intValue];
    int status =  [[dict objectForKey:@"status"]intValue];
    
    
    if(oldSession == 0){
        
        ///1. register session
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        _session.status = status;
        [realm commitWriteTransaction];
        ///2. change star image
        [_starButton setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];
        
        ///
        
    }else{
        
        //// alert dialoge
        
        [self presentViewController:[self registerAlert] animated:YES completion:nil];
    
        
        //        //unregister session
        //        [model unregisterSession:_session];
        //        _session.status = 0;
        //
        //        //change star image
        //        UIImage *registerStar = [UIImage imageNamed:@"sessionnotadded.png"];
        //        [sender setBackgroundImage:registerStar forState:UIControlStateNormal];
                
                
            }


}


-(UIAlertController*)registerAlert{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:@"You are registered in another session at the same time !"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* replaceButton = [UIAlertAction
                                    actionWithTitle:@"Replace"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action){
                                        [[AgendaDetailsViewController self] replaceSession];
                                    
                                    }];
    
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
    
    
    
    //Add your buttons to alert controller
    
    [alert addAction:replaceButton];
    [alert addAction:cancelButton];
    
    return alert;
}

-(void) replaceSession{
    
    [model registerSessionWithSessionObj:_session AndEnforce:true];
}

@end
