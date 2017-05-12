//
//  FirstVcViewController.m
//  NewProject
//
//  Created by Ajith on 3/30/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import "FirstVcViewController.h"
#import "SecondVc.h"
#import "RootViewController.h"  
#import "FirstVccell.h"
#import "AppDelegate.h"

@interface FirstVcViewController ()<UITableViewDataSource,UITableViewDelegate>
   {
    FirstVccell *cell;
    }

@end
@implementation FirstVcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"RSS Feeds..!";
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(refresh)];

    self.feedsArray = [[AppDelegate sharedAppDelegate] feedSource];
       [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

-(void)addItemViewController:(SecondVc *)controller didFinishEnteringItem:(NSString *)title
{
    self.feedsArray = [[AppDelegate sharedAppDelegate] feedSource];
    NSLog(@"feed array %@",_feedsArray);
    [self.tableview reloadData];
    
}
-(void)refresh

   {
    SecondVc *n=[[SecondVc alloc]initWithNibName:@"SecondVc" bundle:nil];
    n.delegate=self;
   [self.navigationController pushViewController:n animated:YES];
       
   }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.feedsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
  {
    static NSString * cellIdentifier = @"cells";
    cell = (FirstVccell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
      {
        cell= (FirstVccell *)[[[NSBundle mainBundle]loadNibNamed:@"FirstVccell" owner:self options:nil] objectAtIndex:0];
        
          
          if([[self.feedsArray objectAtIndex:indexPath.row]objectForKey:@"feedTitle"])
          {
              //
              cell.lbl.text = [[self.feedsArray objectAtIndex:indexPath.row]objectForKey:@"feedTitle"];
              cell.img.image=[UIImage imageNamed:@"rssfeed.png"];
          }
          else
          {
              cell.lbl.text = [[self.feedsArray objectAtIndex:indexPath.row]objectForKey:@"feedURL"];
              cell.img.image=[UIImage imageNamed:@"rssfeed.png"];
          }
        
    }
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
       RootViewController *root = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
       root.feedInfo =[self.feedsArray objectAtIndex:indexPath.row];
       [self.navigationController pushViewController:root animated:YES];
}





@end
