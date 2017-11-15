//
//  CInsertViewController.m
//  lab5
//
//  Created by SWUComputer on 2016. 12. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "CInsertViewController.h"
#import <CoreData/CoreData.h>

@interface CInsertViewController ()

@end

@implementation CInsertViewController

@synthesize textTitle, textDescription, imageView;

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if([textField isEqual:self.textTitle])
    {
        [textField resignFirstResponder];
        [self.textDescription becomeFirstResponder];
    }
    return YES;
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

    
    if (![UIImagePickerController
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController * alert= [UIAlertController
                                    alertControllerWithTitle:@"Error!!"
                                    message:@"Device has no camera"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok =
        [UIAlertAction
         actionWithTitle:@"OK"
         style:UIAlertActionStyleDefault
         handler:^(UIAlertAction * action)
         {
             [alert dismissViewControllerAnimated:YES completion:nil];
         }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }

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

- (IBAction)selectPicutre:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takePicture:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)buttonSave:(UIBarButtonItem *)sender {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    NSManagedObject *newCate = [NSEntityDescription insertNewObjectForEntityForName:@"Ok"
                                                             inManagedObjectContext:context];
    
    UIImage *testImage = self.imageView.image;
    NSData *imageData = UIImagePNGRepresentation(testImage);
    
    [newCate setValue:imageData forKey:@"photo"];
    [newCate setValue:textTitle.text forKey:@"title"];
    [newCate setValue:textDescription.text forKey:@"subTitle"];
    [newCate setValue:[NSDate date] forKey:@"date"];
    [newCate setValue:[NSNumber numberWithBool:NO] forKey:@"check"];
    
    NSError *error = nil;
    
    if(![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
