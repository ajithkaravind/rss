//
//  DisplayViewController.m
//  MWFeedParser
//
//  Created by Ajith on 4/5/17.
//  Copyright © 2017 Michael Waterfall. All rights reserved.
//

#import "DisplayViewController.h"
#import "NSString+HTML.h"

@interface DisplayViewController ()
{
      NSString *str;
}

@end
@implementation DisplayViewController
@synthesize item, dateString, summaryString,titlestring;
@synthesize  stringlink;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     self.title=@"Details";
     str=[[NSString alloc]init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    [button setImage:[UIImage imageNamed:@"web.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(link) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
     self.navigationItem.rightBarButtonItem=barButton;
   if (item.summary)
        {
        self.summaryString = [item.summary stringByConvertingHTMLToPlainText];
        self.text1.text=[NSString stringWithFormat:@"%@",self.summaryString];
        self.text1.font=[UIFont fontWithName:@"Arial" size:15];
        }
    
    else
        {
        self.summaryString = @"[No Summary]";
        }
    
    
    if (item.title)
    
    {
        str = [item.title stringByConvertingHTMLToPlainText];
        self.label.numberOfLines=0;
        self.label.text=[NSString stringWithFormat:@"%@",str];
        self.label.font=[UIFont fontWithName:@"Arial-BoldMT" size:20];
        
    }
    else
        {
        self.titlestring = @"[No title]";
        }
    
}
-(void)link
{
     stringlink =item.link ? item.link : @"[No Link]";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringlink]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
