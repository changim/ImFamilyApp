//
//  CJIMMapViewController.h
//  Notes
//
//  Created by James Im on 10/7/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CJIMMapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
