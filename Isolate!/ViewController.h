//
//  ViewController.h
//  Isolate!
//
//  Created by Aaron on 5/31/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *backgroundObjects;
    
    UIImageView *player;
    UIImageView *player2;
    
    int playerState;
    
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *player2Label;
    
    IBOutlet UIButton *resetButton;
}

-(IBAction)reset;

@end
