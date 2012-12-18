//
//  CJIMPhotoViewController.m
//  ImFamilyApp
//
//  Created by James Im on 12/18/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMPhotoViewController.h"

@interface CJIMPhotoViewController ()

@end

@implementation CJIMPhotoViewController

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
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhoto)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void) addPhoto {
    /*UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destroy" otherButtonTitles: nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
