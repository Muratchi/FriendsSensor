//
//  BeginViewController.m
//  FriendsSensor
//
//  Created by Administrator on H26/11/02.
//  Copyright (c) 平成26年 So. All rights reserved.
//

#import "BeginViewController.h"

@interface BeginViewController ()

@end

@implementation BeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)username:(NSString *)username password:(NSString *)password email:(NSString *)email
{
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
        if (!error) {
            NSLog(@"succeeded");
//            [self performSegueWithIdentifier:@"MapView" sender:self];
        }else{
            NSString *errorString =  [error userInfo][@"error"];
            NSLog(@"%@",errorString);
            NSString *judg = [errorString substringWithRange:NSMakeRange(8, 8)];
            NSString *t = @"t";
            NSString *u = @"u";
            NSString *errorContent;
            if((judg = t)){
                errorContent = @"名前を変更してください";
            }else if((judg = u)) {
                errorContent = @"メールアドレスを変更してください";
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"エラー" message:errorContent preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                
            }]];
        }
    }];
}

- (IBAction)signUp
{
    NSString *username = name.text;
    NSString *password = pass.text;
    NSString *email = address.text;
    
    [self username:username password:password email:email];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
