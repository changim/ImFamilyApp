//
//  CJIMLoginViewController.m
//  ImFamilyApp
//
//  Created by James Im on 12/16/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMLoginViewController.h"

@interface CJIMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property NSInteger loginAttemptNum;
@end

@implementation CJIMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.password.secureTextEntry = YES;
    self.loginAttemptNum = 0;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    self.loginAttemptNum++;
    [self dismissModalViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.name])
        [self.password becomeFirstResponder];
    else [self login];
    
    return YES;
}

@end
