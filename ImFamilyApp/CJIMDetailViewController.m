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
@property (weak, nonatomic) IBOutlet UITextField *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *authorLabel;
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
        NSString *titleIs = @"Subject: ";
        self.titleLabel.text = [titleIs stringByAppendingString:[[self.detailItem valueForKey:@"title"] description]];
        self.titleLabel.enabled =NO;
        
        NSString *authorIs = @"From: ";
        self.authorLabel.text = [authorIs stringByAppendingString:[[[self.detailItem valueForKey:@"user"] valueForKey:@"name"] description]];
        
        NSString *dateIs = @"Posted at: ";
        NSDate *date = [self.detailItem valueForKey:@"createdAt"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        self.dateLabel.text = [dateIs stringByAppendingString:[dateFormatter stringFromDate:date]];
        self.dateLabel.enabled =NO;
        
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
