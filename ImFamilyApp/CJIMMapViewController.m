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
    @property CLLocationManager *locationManager;
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
    //self.locationManager.delegate = self;
    
    
    [self prepareMapPresentation];
	// Do any additional setup after loading the view.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareMapPresentation];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.mapView removeAnnotations:self.mapView.annotations];
}

- (IBAction)centerMapToCurrentUserLocation:(id)sender {
    CJIMAppDelegate *appDelegate = ((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    Location *currentUserLocation = appDelegate.currentUser.location;
    if (currentUserLocation){
        
        [self.mapView setCenterCoordinate: CLLocationCoordinate2DMake([currentUserLocation.latitude doubleValue],[currentUserLocation.longitude doubleValue]) animated:YES];
        
        MKCoordinateRegion region;
        region.center.latitude = [currentUserLocation.latitude doubleValue];
        region.center.longitude = [currentUserLocation.longitude doubleValue];
        region.span.latitudeDelta = .02;
        region.span.longitudeDelta = .02;
        region = [self.mapView regionThatFits:region];
        [self.mapView setRegion:region animated:TRUE];
    }
}

- (IBAction)centerMapToUserLocation:(UIButton *)sender {
    CJIMAppDelegate *appDelegate = ((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:appDelegate.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", sender.titleLabel.text];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *queryResult = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (queryResult.count!=1) {
        NSLog(@"did not find one user with such name");
        return;
    } else {
        User *user = (User*) [queryResult objectAtIndex:0];
        
        [self.mapView setCenterCoordinate: CLLocationCoordinate2DMake([user.location.latitude doubleValue],[user.location.longitude doubleValue]) animated:YES];
        
        MKCoordinateRegion region;
        region.center.latitude = [user.location.latitude doubleValue];
        region.center.longitude = [user.location.longitude doubleValue];
        region.span.latitudeDelta = .02;
        region.span.longitudeDelta = .02;
        region = [self.mapView regionThatFits:region];
        [self.mapView setRegion:region animated:TRUE];
    }
}



- (void) prepareMapPresentation {
    self.mapView.mapType = MKMapTypeHybrid;
    CJIMAppDelegate *appDelegate = ((CJIMAppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    Location *currentUserLocation = appDelegate.currentUser.location;
    if (currentUserLocation){

        [self.mapView setCenterCoordinate: CLLocationCoordinate2DMake([currentUserLocation.latitude doubleValue],[currentUserLocation.longitude doubleValue]) animated:YES];
        
        MKCoordinateRegion region;
        region.center.latitude = [currentUserLocation.latitude doubleValue];
        region.center.longitude = [currentUserLocation.longitude doubleValue];
        region.span.latitudeDelta = .2;
        region.span.longitudeDelta = .2;
        region = [self.mapView regionThatFits:region];
        [self.mapView setRegion:region animated:TRUE];
    }
    
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
