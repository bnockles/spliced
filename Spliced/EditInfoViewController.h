//
//  EditInfoViewController.h
//  Spliced
//
//  Created by Benjamin Nockles on 1/17/17.
//  Copyright © 2017 Benjamin Nockles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;

@property (weak, nonatomic) IBOutlet UITextField *txtLastname;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;


- (IBAction)saveInfo:(id)sender;

@end
