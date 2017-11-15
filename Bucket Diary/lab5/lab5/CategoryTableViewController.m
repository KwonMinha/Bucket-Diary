//
//  CategoryTableViewController.m
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "CategoryTableViewController.h"
#import <CoreData/CoreData.h>

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

@synthesize cates;

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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Ok"];
    
    //sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    //end sort
    
    cates = [[moc executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}


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
}

// 셀 배경 색
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor colorWithRed:253/255.0 green:245/255.0 blue:254/255.0 alpha:1.0]];
    //[cell setBackgroundColor:[UIColor clearColor]];
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
    return cates.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cate Cell" forIndexPath:indexPath];
    
    NSManagedObject *cate = [cates objectAtIndex:indexPath.row];
    
    // 셀 폰트 색
    cell.textLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    
    if ([[cate valueForKey:@"check"] boolValue]) {
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageWithData:[cate valueForKey:@"photo"]] stretchableImageWithLeftCapWidth:150.0 topCapHeight:10.0] ];
        //cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageWithData:[cate valueForKey:@"photo"]] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    } else {
        cell.textLabel.text = [cate valueForKey:@"title"];
        cell.detailTextLabel.text = [cate valueForKey:@"subTitle"];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageWithData:[cate valueForKey:@"photo"]] stretchableImageWithLeftCapWidth:150.0 topCapHeight:10.0] ];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *cate = [cates objectAtIndex:indexPath.row];
    
    if ([[cate valueForKey:@"check"] boolValue]) {
        // 부드러운 전환을 위한 애니메이션 추가
        [UIView transitionWithView: self.tableView
                          duration: 0.35f
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations: ^(void)
         {
             [self.tableView reloadData];
         }
                        completion: nil];
        [cate setValue:[NSNumber numberWithBool:NO] forKey:@"check"];
    } else {
        // 부드러운 전환을 위한 애니메이션 추가
        [UIView transitionWithView: self.tableView
                          duration: 0.35f
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations: ^(void)
         {
             [self.tableView reloadData];
         }
                        completion: nil];

        [cate setValue:[NSNumber numberWithBool:YES] forKey:@"check"];
    }
    [self.tableView reloadData];
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
        [context deleteObject:[cates objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if(![context save:&error]) {
            NSLog(@"Save Faild! %@ %@", error, [error localizedDescription]);
        }
        [cates removeObjectAtIndex:indexPath.row];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
