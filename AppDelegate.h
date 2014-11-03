//
//  AppDelegate.h
//  FriendsSensor
//
//  Created by Administrator on H26/10/19.
//  Copyright (c) 平成26年 So. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    PFObject *location;
    NSString *objectId;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)NSString *pfId;


@end

