//
//  RootViewController.h
//  MWFeedParser
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface RootViewController : UITableViewController <MWFeedParserDelegate>

{
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    NSArray *itemsToDisplay;
    NSDateFormatter *formatter;
    
}

@property (nonatomic, strong) NSArray *itemsToDisplay;
@property (nonatomic,assign) NSMutableDictionary *feedInfo;

@end
