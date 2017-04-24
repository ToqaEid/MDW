//
//  JETSSideMenu.m
//  MDW
//
//  Created by JETS on 4/10/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "JETSSideMenu.h"

@implementation JETSSideMenu{
    NSArray * cellsItems;

}



-(void)viewDidLoad{
    cellsItems = @[@"Agenda", @"MyAgenda", @"Speakers", @"Exhibitors", @"Profile", @"Logout"];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftSideMenuBackground.png"]];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return cellsItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = [cellsItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == cellsItems.count-1){
        //logout
        printf("logout\n");
        
        //go to login view
        
        [self dismissViewControllerAnimated:YES completion:^{
            //remove user data from nsuserdefaults
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"user"];
            [defaults synchronize];
        }];
    }
}
@end
