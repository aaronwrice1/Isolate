//
//  ModeViewController.m
//  Isolate!
//
//  Created by Aaron on 6/27/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import "ModeViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ModeViewController ()

@end

@implementation ModeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)goToMultiplayer:(id)sender{
    
    if (IS_IPHONE_5) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MultiplayerViewController"];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    }
    else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MultiplayerViewController"];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
