//
//  FirstVcViewController.h
//  NewProject
//
//  Created by Ajith on 3/30/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstVcViewController : UIViewController

@property( strong, nonatomic) NSMutableArray *feedsArray;
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void)refresh;
@property (strong,nonatomic)IBOutlet UITableView *tableview;

@end
