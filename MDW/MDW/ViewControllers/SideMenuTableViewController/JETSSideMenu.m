//
//  JETSSideMenu.m
//  MDW
//
//  Created by JETS on 4/10/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "JETSSideMenu.h"
#import "AppDelegate.h"

@implementation JETSSideMenu{
    NSArray * cellsItems;

}



-(void)viewDidLoad{
    cellsItems = @[@"Agenda", @"MyAgenda", @"Speakers", @"Exhibitors", @"Profile", @"Logout"];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftSideMenuBackground.png"]];
    
}

-(void)dealloc{
    printf("**********side dismissed dealloc***********\n");

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
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
        [app.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        
        app.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        
        [self.view.window makeKeyAndVisible];
        
        
        //remove user data from nsuserdefaults
        [NSUserDefaultForObject removeObjectWithKey:@"user"];
        
        //make all views unvisited
        [VisitedViews setAllViewsAsUnVisited];
        
        
        
        
    }
}
@end
