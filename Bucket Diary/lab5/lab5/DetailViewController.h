//
//  DetailViewController.h
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSManagedObject *detailDiary;


@property (retain, nonatomic) IBOutlet UILabel *textDate;
@property (retain, nonatomic) IBOutlet UITextView *textContent;
@property (retain, nonatomic) IBOutlet UITextView *textTitle;


@end
