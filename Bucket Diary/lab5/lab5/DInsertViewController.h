//
//  DInsertViewController.h
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DInsertViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextView *textTitle;

@property (retain, nonatomic) IBOutlet UITextView *textView;
- (IBAction)buttonSave:(UIBarButtonItem *)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
