//
//  CJIMDetailViewController.m
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMDetailViewController.h"

@interface CJIMDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
- (void)configureView;
@end

@implementation CJIMDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.titleLabel.text = [[self.detailItem valueForKey:@"title"] description];
        self.titleLabel.enabled =NO;
        self.bodyTextView.text = [[self.detailItem valueForKey:@"body"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
