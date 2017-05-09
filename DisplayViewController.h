//
//  DisplayViewController.h
//  MWFeedParser
//
//  Created by Ajith on 4/5/17.
//  Copyright © 2017 Michael Waterfall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"
@interface DisplayViewController : UIViewController
{
    MWFeedItem *item;
    NSString *dateString, *summaryString;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *text1;
@property (nonatomic, strong) MWFeedItem *item;
@property (nonatomic, strong) NSString *dateString, *summaryString,*titlestring;
@property (nonatomic, strong)NSString * stringlink;

@end
