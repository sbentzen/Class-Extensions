#import <MapKit/MapKit.h>

/** An extension on MKMapView to add a quick method to set the center and zoom level on the map view*/
@interface MKMapView (ZoomLevels)

/** Sets the Center of the map along with the zoom level and whether it should be animated
 * @param centerCoordinate the coordinate you want to set the center to
 * @param zoomLevel the level of zoom you want.
 * @param animated whether setting the center and zoom level should be animated.
 
 */
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;


@end
