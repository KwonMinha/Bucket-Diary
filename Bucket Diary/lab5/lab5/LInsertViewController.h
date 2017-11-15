//
//  LInsertViewController.h
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LInsertViewController : UIViewController <UITextFieldDelegate>

- (IBAction)buttonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *textAddList;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
