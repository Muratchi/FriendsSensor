//
//  ViewController.m
//  FriendsSensor
//
//  Created by Administrator on H26/10/19.
//  Copyright (c) 平成26年 So. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BOOL locationServicesEnabled = NO;
    locationManager = [[CLLocationManager alloc] init];
    if([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]){
        locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    }
    if(locationServicesEnabled){
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        NSLog(@"OK");
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    objectId = appDelegate.pfId;
    PFObject *userId = [PFObject objectWithoutDataWithClassName:@"Locations" objectId:objectId];
    userId[@"userId"] = [PFUser currentUser].username;
    [PFUser logInWithUsernameInBackground:@"muratasou1" password:@"muratasou" block:^(PFUser *user,NSError *error){
        if (user) {
            NSLog(@"succeeded");
        }else{
            NSLog(@"faild");
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations.lastObject;
    NSLog(@"更新されてるよ!!");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [updateObject getObjectInBackgroundWithId:objectId block:^(PFObject *object,NSError *error){
            object[@"location"] = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            NSLog(@"%f",newLocation.coordinate.latitude);
            [object saveInBackground];
            
        }];
        
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"User"];
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        [query whereKey:@"location" nearGeoPoint:userGeoPoint withinKilometers:0.1];
        NSArray *nearPoints = [query findObjects];
        PFQuery *friendsQuery = [PFQuery queryWithClassName:@"User"];
        [friendsQuery whereKey:@"friends" containedIn:nearPoints];
        [friendsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if(!error){
                for(PFObject *geoPoint in objects){
                    NSLog(@"%@",geoPoint[@"location"]);
                }
            }
        }];
    });
    
}

@end
