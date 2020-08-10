//
//  TitleViewController.h
//  Isolate!
//
//  Created by Aaron on 6/20/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleViewController : UIViewController{
    NSMutableArray *boxArray;
    NSTimer *timer;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *playButton;
    
    // touch square stuff
    BOOL canTouchASquare;
    
    // UI
    IBOutlet UILabel *squareNumber;
    IBOutlet UILabel *squareNumberTitle;
    IBOutlet UILabel *catagory;
    IBOutlet UILabel *catagoryTitle;
    IBOutlet UITextView *mainText;
    
    // Code
    CGRect lastPlace;
    BOOL isZoomedIn;
    int boxNumber;
}

@end
