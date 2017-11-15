//
//  DetailViewController.m
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize detailDiary;
@synthesize textTitle,textContent,textDate;

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
    
    textTitle.text = [detailDiary valueForKey:@"title"];
    textContent.text = [detailDiary valueForKey:@"content"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd h:mm:ss a"];
    textDate.text = [formatter stringFromDate:[detailDiary valueForKey:@"date"]];
    
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

@end
