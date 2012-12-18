//
//  CJIMMapViewController.m
//  Notes
//
//  Created by James Im on 10/7/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMMapViewController.h"

#import "CJIMAppDelegate.h"
#import "Location.h"
#import "User.h"

@interface CJIMMapViewController ()

@end

@implementation CJIMMapViewController

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
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 39.951777;
    coordinate.longitude = -75.190966;
    MKCoordinateRegion region;
    region.center.latitude = 39.951777;
    region.center.longitude = -75.190966;
    region.span.latitudeDelta = 1;
    region.span.longitudeDelta = 1;
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:TRUE];
    
    [self prepareMapPresentation];
	// Do any additional setup after loading the view.
}
/*
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self prepareMapPresentation];
}*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareMapPresentation];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void) prepareMapPresentation {
    self.mapView.mapType = MKMapTypeHybrid;
    CJIMAppDelegate *appDelegate = ((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    Location *currentUserLocation = appDelegate.currentUser.location;
    if (currentUserLocation)
        [self.mapView setCenterCoordinate: CLLocationCoordinate2DMake([currentUserLocation.latitude doubleValue],[currentUserLocation.longitude doubleValue]) animated:YES];
    /*if (masterViewController.collectingLocation) {
        CJIMNoteDataController *dataController = masterViewController.dataController;
        for (int i = 0; i < [dataController countOfList]; i++) {
            CJIMNote *note = [dataController objectInListAtIndex:i];
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = note.location.coordinate;
            NSString *noteTitle = note.title;
            if ([noteTitle isEqualToString:@""]) noteTitle = @"New Note";
            annotation.title = noteTitle;
            annotation.subtitle = note.body;//note.date.description;
            
            [self.mapView addAnnotation:annotation];
        }
    } */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
