//
//  LocationManager.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (LocationManager *)sharedInstance {
    
    static LocationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark -
#pragma mark Core Location Delegate Methods

- (CLLocationManager *)locationManager {
    
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _locationManager.delegate = self;
    
    return _locationManager;
}

- (CLLocation *) currentLocation {
    
    if (!_currentLocation) {
        _currentLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    }
    
    return _currentLocation;
}

- (BOOL)locationIsAccurate {
    
    if (_currentLocation.coordinate.latitude == 0 && _currentLocation.coordinate.longitude == 0) {
        return NO;
    }
    return YES;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self locationManager];
        [self currentLocation];
                
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (void) startUpdatingLocation
{
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations firstObject];
    _currentLocation = newLocation;
 
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0)
        {
            CLPlacemark *placemark = placemarks[0];
            NSDictionary *addressDictionary = placemark.addressDictionary;
                        
            _userCity = [addressDictionary objectForKey:@"City"];
            _userCountry = placemark.country;
        }
    }];
    
    [_locationManager stopUpdatingLocation];
    

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    //TODO: deal with this
    
    if ([error domain] == kCLErrorDomain) {
        
        switch ([error code]) {
                
            case kCLErrorDenied: {
                
                break;}
                
            case kCLErrorLocationUnknown: {
                
                break;}
                
            default:
                break;
        }
        
    } else {
        
    }
}


@end
