//
//  DiaryTableViewController.m
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "DiaryTableViewController.h"
#import <CoreData/CoreData.h>
#import "DetailViewController.h"

@interface DiaryTableViewController ()

@end

@implementation DiaryTableViewController

@synthesize diarys;


- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Diary"];
    
    //sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    //end sort
    
    diarys = [[moc executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

/*
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"2017년";
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 네비게이션바 배경 색
    [self.navigationController.navigationBar setBarTintColor:
     [UIColor colorWithRed:210/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
    
    // 네비게이션바 글자 색
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // 테이블 뷰 배경 이미지
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1.jpg"]];
    
    // 탭 바 배경 색
    //진분홍
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:220/255.0 green:200/255.0 blue:211/255.0 alpha:1.0];
    //베이지
    //self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:241/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //연분홍
    //self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:244/255.0 green:213/255.0 blue:229/255.0 alpha:1.0];
}

// 셀 색
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //[cell setBackgroundColor:[UIColor colorWithRed:244/255.0 green:213/255.0 blue:229/255.0 alpha:1.0]];
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return diarys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Diary Cell" forIndexPath:indexPath];
    
    NSManagedObject *list = [diarys objectAtIndex:indexPath.row];
    
    // 셀 폰트 색
    //회색
    //cell.textLabel.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    //흰색
    //cell.textLabel.textColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
    // 셀 선택시 이미지
    UIView *selectedBackgroundView = [[UIView alloc] init];
    //색으로 변경
    //selectedBackgroundView.backgroundColor = [UIColor colorWithRed:244/255.0 green:213/255.0 blue:229/255.0 alpha:1.0];
    // 이미지로 변경
    selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]];
    cell.selectedBackgroundView = selectedBackgroundView;
    

    cell.textLabel.text = [list valueForKey:@"title"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    cell.detailTextLabel.text = [formatter stringFromDate:[list valueForKey:@"date"]];
    
    /* 세분화 하기 위한 코드들
    NSDateFormatter *formetter_time = [[NSDateFormatter alloc] init];
    [formetter_time setDateFormat:@"h:mm"];
    labelTime.text = [formetter_time stringFromDate:[list valueForKey:@"date"]];
    
    NSDateFormatter *formetter_day = [[NSDateFormatter alloc] init];
    [formetter_day setDateFormat:@"dd"];
    labelDay.text = [formetter_day stringFromDate:[list valueForKey:@"date"]];
    
    NSDateFormatter *formetter_week = [[NSDateFormatter alloc] init];
    [formetter_week setDateFormat:@"EEEE"];
    labelDay.text = [formetter_week stringFromDate:[list valueForKey:@"date"]];
     */
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        //code start
        NSManagedObjectContext *context = [self managedObjectContext];
        [context deleteObject:[diarys objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if(![context save:&error]) {
            NSLog(@"Save Faild! %@ %@", error, [error localizedDescription]);
        }
        [diarys removeObjectAtIndex:indexPath.row];
        //code end
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"toDetailView"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *selectedDiary = [diarys objectAtIndex:indexPath.row];
        
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.detailDiary = selectedDiary;
    }
}


@end
