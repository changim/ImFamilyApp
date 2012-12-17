//
//  CJIMNewMessageController.m
//  ImFamilyApp
//
//  Created by James Im on 12/17/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMNewMessageController.h"

#import "CJIMAppDelegate.h"
#import "CJIMMasterViewController.h"

@interface CJIMNewMessageController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation CJIMNewMessageController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = submitButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submit
{
    UINavigationController *navigationController = (UINavigationController *)self.parentViewController;
    NSArray *viewControllers = navigationController.viewControllers;
    CJIMMasterViewController *masterViewController = (CJIMMasterViewController *)[viewControllers objectAtIndex:viewControllers.count - 2];
    NSManagedObjectContext *context = [masterViewController.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[masterViewController.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:self.titleTextField.text forKey:@"title"];
    [newManagedObject setValue:self.bodyTextView.text forKey:@"body"];
    [newManagedObject setValue:((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]).currentUser forKey:@"user"];
    [newManagedObject setValue:[NSDate date] forKey:@"createdAt"];
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.bodyTextView becomeFirstResponder];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.textColor isEqual:[UIColor lightGrayColor]]) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
}

@end
