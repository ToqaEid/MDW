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
    return 60;
}
@end
