//
//  ZoomLevels.h
//  iCambrian
//
//  Created by Shaun Bentzen on Wednesday, September 21 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevels)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;


@end
