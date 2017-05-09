//
//  RootViewController.m
//  MWFeedParser
//
//  

#import "RootViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DisplayViewController.h"
#import "AppDelegate.h"


@implementation RootViewController

@synthesize itemsToDisplay;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
		[super viewDidLoad];
         parsedItems = [[NSMutableArray alloc] init];
         self.itemsToDisplay = [NSArray array];
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																							target:self 
																							action:@selector(refresh)];
    
         NSURL *feedURL=[[NSURL alloc]initWithString:[self.feedInfo objectForKey:@"feedURL"]];
    
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
 
}

#pragma mark -
#pragma mark Parsing

// Reset and reparse
  - (void)refresh
{
    self.title = @"Refreshing...";
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
    [feedParser parse];
    self.tableView.userInteractionEnabled = NO;
    self.tableView.alpha = 0.3;
}
#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser
{
	NSLog(@"Started Parsing: %@", parser.url);
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
    NSLog(@"Parsed Feed Info: “%@”", info.title);
    [self.feedInfo setObject:info.title forKey:@"feedTitle"];
    [[AppDelegate sharedAppDelegate] saveFeedSource];
     self.title = info.title;
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}
- (void)feedParserDidFinish:(MWFeedParser *)parser
{
	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
	NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0)
        {
        self.title = @"Failed";
        }
    else
    {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                         message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                        delegate:nil
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil];
        //[alert show];
    }
    
    [self updateTableWithParsedItems];
}
- (void)updateTableWithParsedItems

{
   self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                           [NSArray arrayWithObject:[[NSSortDescriptor alloc]initWithKey:@"date"
                                                                                ascending:NO]]];
    
     self.tableView.userInteractionEnabled = YES;
     self.tableView.alpha = 1;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return itemsToDisplay.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item !=0) {
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.text = itemTitle;
        cell.textLabel.numberOfLines=0;
        NSMutableString *subtitle = [NSMutableString string];
        cell.detailTextLabel.text = subtitle;
		}
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     DisplayViewController *detail =[[DisplayViewController alloc]init];
     detail.item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
     [self.navigationController pushViewController:detail animated:YES];
	 [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Memory management


@end
