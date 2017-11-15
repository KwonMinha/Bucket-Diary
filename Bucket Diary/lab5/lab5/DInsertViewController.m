//
//  DInsertViewController.m
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "DInsertViewController.h"
#import <CoreData/CoreData.h>

@interface DInsertViewController ()

@end

@implementation DInsertViewController

@synthesize textView, textTitle;

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 뷰 배경 이미지
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bbg2.jpg"]];
    
    // 네비게이션바 배경 색
    [self.navigationController.navigationBar setBarTintColor:
     [UIColor colorWithRed:189/255.0 green:206/255.0 blue:250/255.0 alpha:1.0]];
    // 탭 바 배경 색
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:233/255.0 green:199/255.0 blue:232/255.0 alpha:1.0];
    
    // 텍스트 뷰 테두리
    self.textTitle.layer.borderWidth = 0.35f;
    self.textTitle.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.textView.layer.borderWidth = 0.35f;
    self.textView.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)buttonSave:(UIBarButtonItem *)sender {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    NSManagedObject *newList = [NSEntityDescription insertNewObjectForEntityForName:@"Diary"
                                                             inManagedObjectContext:context];
    
    [newList setValue:textTitle.text forKey:@"title"];
    [newList setValue:textView.text forKey:@"content"];
    [newList setValue:[NSDate date] forKey:@"date"];
    
    NSError *error = nil;
    
    if(![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
