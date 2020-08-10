//
//  Player1Controller.h
//  Isolate!
//
//  Created by Aaron on 6/3/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Player1Controller : UIViewController{
    NSMutableArray *backgroundObjects;
    NSMutableArray *objectsNext2Computer;
    NSMutableArray *objectsComputerCanDelete;
    
    UIImageView *player;
    UIImageView *computer;
    
    int playerState;
    
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *computerLabel;
    
    IBOutlet UIButton *resetButton;
}

-(IBAction)reset;

@end
