//
//  SecondVc.h
//  NewProject
//
//  Created by Ajith on 3/30/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@class SecondVc;

@protocol ViewControllerBDelegate <NSObject>
-(void)addItemViewController:(SecondVc *)controller didFinishEnteringItem:(NSString *)title;

@end

@interface SecondVc : UIViewController<MWFeedParserDelegate>

{
    MWFeedParser *feedParser;
}

@property (nonatomic, weak) id <ViewControllerBDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *urltextfeild;
@property (strong,nonatomic)NSString *string;
@property (strong,nonatomic)NSMutableArray *marray;
-(void)save;


@end
