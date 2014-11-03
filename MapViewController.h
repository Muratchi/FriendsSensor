//
//  ViewController.h
//  FriendsSensor
//
//  Created by Administrator on H26/10/19.
//  Copyright (c) 平成26年 So. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "AppDelegate.h"

@interface MapViewController : UIViewController
<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    PFQuery *updateObject;
    NSString *objectId;
    PFUser *name;
}


@end
