//
//  CJIMLoginViewController.m
//  ImFamilyApp
//
//  Created by James Im on 12/16/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMLoginViewController.h"
#import "User.h"
#import "Location.h"

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

// Login only if the name and password are valid according to stored data.
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
            
            CJIMAppDelegate *appDelegate = ((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]);
            appDelegate.currentUser = user;
            
            // create or update user's location
            if (appDelegate.lastLocation) {
                if (!user.location) {
                    NSEntityDescription *locationEntity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
                    user.location = [NSEntityDescription insertNewObjectForEntityForName:[locationEntity name] inManagedObjectContext:self.managedObjectContext];
                }
                user.location.latitude = [[NSNumber alloc] initWithDouble:appDelegate.lastLocation.coordinate.latitude];
                user.location.longitude = [[NSNumber alloc] initWithDouble:appDelegate.lastLocation.coordinate.longitude];
            }
            
            // Save the context.
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            [self dismissModalViewControllerAnimated:YES];
            return;
        } else {
            NSLog(@"password is wrong");
        }
    }
}

// Handle keyboards.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.nameTextField])
        [self.passwordTextField becomeFirstResponder];
    else [self login];
    
    return YES;
}

@end
