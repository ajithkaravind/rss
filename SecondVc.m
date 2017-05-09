//
//  SecondVc.m
//  NewProject
//
//  Created by Ajith on 3/30/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import "SecondVc.h"
#import "RootViewController.h"
#import "FirstVcViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "AppDelegate.h"

@interface SecondVc ()<UITabBarDelegate,MWFeedParserDelegate>
{
    NSMutableArray *array;
   }

@end

@implementation SecondVc

@synthesize delegate,marray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Add feed";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                              UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(save)];
}

- (void)feedParserDidStart:(MWFeedParser *)parser
{
    
    NSLog(@"Started Parsing: %@", parser.url);
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info

{
   NSLog(@"Parsed Feed Info: “%@”", info.title);
    self.title = info.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)save
{
    if (self.urltextfeild.text.length!=0)
    
    {
        self.string=[NSString stringWithFormat:@"%@",_urltextfeild.text];
        NSURL *feedURL=[[NSURL alloc]initWithString:self.string];
        feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
        feedParser.delegate = self;
        feedParser.feedParseType = ParseTypeFull;
        feedParser.connectionType = ConnectionTypeSynchronously;
        [feedParser parse];
        NSMutableDictionary *rssDict = [[NSMutableDictionary alloc] init];
        [rssDict setObject:self.string forKey:@"feedURL"];
        NSMutableArray *rssFeeds = [[AppDelegate sharedAppDelegate] feedSource];
        [rssFeeds addObject:rssDict];
        
        NSLog(@"rssfeed %@",rssFeeds);
        
        [[AppDelegate sharedAppDelegate] saveFeedSource];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[self navigationController]popViewControllerAnimated:YES];
        [self.delegate addItemViewController:self didFinishEnteringItem:self.string];
    }
    else
        
    {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"No URL to search"
                      
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
}
}

- (IBAction)back:(id)sender
{
    FirstVcViewController *root = [[FirstVcViewController alloc]init];
    [self.navigationController pushViewController:root animated:YES];
}

@end
