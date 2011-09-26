#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevels)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;


@end
