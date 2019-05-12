//
//  HistoryTableViewController.m
//  YaHoodey
//
//  Created by igor on 08/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "WeightServiceProtocol.h"

@interface HistoryTableViewController ()
@property (strong, nonatomic) id<WeightServiceProtocol> service;
@end

@implementation HistoryTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *orig_img = [UIImage imageNamed:@"historyBarItem"];
        UIImage *img = [orig_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"История" image:img tag:1];
    }
    return self;
}
- (instancetype)initWithService:(id<WeightServiceProtocol>)service
{
    self = [self init];
    if (self) {
        _service = service;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self animateTable];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.service.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (indexPath.row > 0 && [self isGreaterValueForRow: indexPath]){
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    cell.textLabel.text = [self.service stringDateForRow: indexPath.row];
    CGFloat value = [self.service valueForRow: indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%2.1f", value];
    return cell;
}

-(BOOL) isGreaterValueForRow: (NSIndexPath*) indexPath {
    return [self.service valueForRow: indexPath.row] > [self.service valueForRow: indexPath.row-1];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) animateTable {
    [self.tableView reloadData];
    NSArray *cells = self.tableView.visibleCells;
    CGFloat tableWidth = self.tableView.bounds.size.width;
    for (UITableViewCell *cell in cells){
        cell.transform = CGAffineTransformMakeTranslation(-tableWidth, 0);
    }
    double index = 1.0;
    for (UITableViewCell *cell in cells){
        [UIView animateWithDuration:0.3f
                              delay:0.1 * index++
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             cell.transform = CGAffineTransformIdentity;
                         }
                         completion:nil];
    }
}

@end
