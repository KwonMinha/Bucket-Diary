//
//  CInsertViewController.h
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CInsertViewController : UIViewController<UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textTitle;
@property (strong, nonatomic) IBOutlet UITextView *textDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)selectPicutre:(UIButton *)sender;
- (IBAction)takePicture:(UIButton *)sender;
- (IBAction)buttonSave:(UIBarButtonItem *)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
