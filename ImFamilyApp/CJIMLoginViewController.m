//
//  CJIMLoginViewController.m
//  ImFamilyApp
//
//  Created by James Im on 12/16/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMLoginViewController.h"
#import "User.h"

#import "CJIMAppDelegate.h"

@interface CJIMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
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
    self.passwordTextField.secureTextEntry = YES;
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", self.nameTextField.text];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *queryResult = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (queryResult.count!=1) {
        NSLog(@"did not find one user with such name");
        return;
    } else {
        User *user = (User*) [queryResult objectAtIndex:0];
        if ([user.password isEqualToString:self.passwordTextField.text]) {
            NSLog(@"login successful");
            ((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]).currentUser = user;
            [self dismissModalViewControllerAnimated:YES];
            return;
        } else {
            NSLog(@"password is wrong");
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.nameTextField])
        [self.passwordTextField becomeFirstResponder];
    else [self login];
    
    return YES;
}

@end
