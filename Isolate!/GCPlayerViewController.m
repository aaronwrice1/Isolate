//
//  GCPlayerViewController.m
//  Isolate!
//
//  Created by Aaron on 6/25/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import "GCPlayerViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface GCPlayerViewController ()

@end

int boxNumber = 0;

@implementation GCPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    backgroundObjects = [[NSMutableArray alloc] init];
    
    if (IS_IPHONE_5) {
        // create map
        for (int a = 0; a < 7; a++) {
            for (int b = 0; b < 7; b++) {
                UIImageView *box = [[UIImageView alloc] initWithFrame:CGRectMake(15 + 42*b, 135 + 42*a, 40, 40)];
                box.backgroundColor = [UIColor blueColor];
                
                box.tag = boxNumber;
                boxNumber++;
                
                [self.view addSubview:box];
                
                [backgroundObjects addObject:box];
            }
        }
    }
    else{
        // create map
        for (int a = 0; a < 7; a++) {
            for (int b = 0; b < 7; b++) {
                UIImageView *box = [[UIImageView alloc] initWithFrame:CGRectMake(15 + 42*b, 100 + 42*a, 40, 40)];
                box.backgroundColor = [UIColor blueColor];
                
                box.tag = boxNumber;
                boxNumber++;
                
                [self.view addSubview:box];
                
                [backgroundObjects addObject:box];
            }
        }
    }
    
    // to fix a bug
    boxNumber = 0;
    
    // create players
    player = [[UIImageView alloc] initWithFrame:[[backgroundObjects objectAtIndex:45] frame]];
    player.tag = 45;
    player.backgroundColor = [UIColor greenColor];
    [self.view addSubview:player];
    
    player2 = [[UIImageView alloc] initWithFrame:[[backgroundObjects objectAtIndex:3] frame]];
    player2.tag = 3;
    player2.backgroundColor = [UIColor redColor];
    [self.view addSubview:player2];
    
    //update game state
    playerState = 1;
    
    ourRandom = arc4random();
    [self setGameState:kGameStateWaitingForMatch];
}

// after viewDidLoad
-(void)viewDidAppear:(BOOL)animated{
   [[GCHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self delegate:self];
    
    if (![[GCHelper sharedInstance] gameCenterAvailable]) {
        if (IS_IPHONE_5) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
        }
        else{
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [self reset];
}

-(void)movePlayer:(CGRect)rect{
    switch (playerState) {
        case 1:
            [player setFrame:rect];
            playerState = 2;
            // clears
            [self updateChoises];
            break;
        case 2:
            // PlayersState = Player2Move;
            break;
        case 3:
            [player2 setFrame:rect];
            playerState = 4;
            // clears
            [self updateChoises];
            break;
        case 4:
            // PlayersState = PlayerMove;
            break;
            
        default:
            break;
    }
}

/*
-(void)updateChoises{
    
    // old place
    // [self checkIfPlayerWon];
    
    // highlights / reverts squares for player to move
    switch (playerState) {
        case 1:
            // highlight all squares around player
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                // stops glitches
                // put code that stops players from moving right next to each other
                
                // left bound
                if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 ||
                    player.tag == 35 || player.tag == 42) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player.tag + 1 ||
                        box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                        box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                // right bound
                else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 ||
                         player.tag == 41 || player.tag == 48) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                        box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                        box.tag == player.tag - 7) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                else{
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                        box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                        box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                        
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                // remove the squares that are next to other player
                if (box.tag == player2.tag - 8 || box.tag == player2.tag - 7 || box.tag == player2.tag - 6 ||
                    box.tag == player2.tag - 1 || box.tag == player2.tag + 1 || box.tag == player2.tag + 6 ||
                    box.tag == player2.tag + 7 || box.tag == player2.tag + 8) {
                    if (box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor blueColor];
                    }
                }
            }
            
            break;
        case 2:
            // reset the colors
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                if (box.backgroundColor != [UIColor whiteColor]) {
                    box.backgroundColor = [UIColor blueColor];
                }
            }
            
            break;
        case 3:
            // highlight all squares around player
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                // stops glitch
                
                // left bound
                if (player2.tag == 0 || player2.tag == 7 || player2.tag == 14 || player2.tag == 21 || player2.tag == 28 ||
                    player2.tag == 35 || player2.tag == 42) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player2.tag + 1 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag + 8 ||
                        box.tag == player2.tag - 7 || box.tag == player2.tag - 6) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                // right bound
                else if (player2.tag == 6 || player2.tag == 13 || player2.tag == 20 || player2.tag == 27 ||
                         player2.tag == 34 || player2.tag == 41 || player2.tag == 48) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player2.tag - 1 || box.tag == player2.tag + 6 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag - 8 ||
                        box.tag == player2.tag - 7) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                else{
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player2.tag - 1 || box.tag == player2.tag + 1 || box.tag == player2.tag + 6 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag + 8 || box.tag == player2.tag - 8 ||
                        box.tag == player2.tag - 7 || box.tag == player2.tag - 6) {
                        
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                
                // remove the squares that are next to other player
                if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 6 ||
                    box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                    box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                    if (box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor blueColor];
                    }
                }
            }
            
            break;
        case 4:
            // reset the colors
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                if (box.backgroundColor != [UIColor whiteColor]) {
                    box.backgroundColor = [UIColor blueColor];
                }
            }
    }
}
 */

-(void)updateChoises{
    
    // highlights / reverts squares for player to move
    
    // uncomment this
    switch (playerState) {
        case 1:
                // player1 - highlight around him - which he is
                for (int i = 0 ; i<backgroundObjects.count; i++) {
                    UIImageView *box = [backgroundObjects objectAtIndex:i];
                    
                    // stops glitches
                    // put code that stops players from moving right next to each other
                    
                    // left bound
                    if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 ||
                        player.tag == 35 || player.tag == 42) {
                        // for all boxes that are around squares - highlight them
                        if (box.tag == player.tag + 1 ||
                            box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                            box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                            if (box.backgroundColor != [UIColor whiteColor]) {
                                box.backgroundColor = [UIColor yellowColor];
                            }
                        }
                    }
                    // right bound
                    else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 ||
                             player.tag == 41 || player.tag == 48) {
                        // for all boxes that are around squares - highlight them
                        if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                            box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                            box.tag == player.tag - 7) {
                            if (box.backgroundColor != [UIColor whiteColor]) {
                                box.backgroundColor = [UIColor yellowColor];
                            }
                        }
                    }
                    else{
                        // for all boxes that are around squares - highlight them
                        if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                            box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                            box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                            
                            if (box.backgroundColor != [UIColor whiteColor]) {
                                box.backgroundColor = [UIColor yellowColor];
                            }
                        }
                    }
                    // remove the squares that are next to other player
                    if (box.tag == player2.tag - 8 || box.tag == player2.tag - 7 || box.tag == player2.tag - 6 ||
                        box.tag == player2.tag - 1 || box.tag == player2.tag + 1 || box.tag == player2.tag + 6 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag + 8) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                        }
                    }
                }
            
            break;
        case 2:
            // reset the colors
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                if (box.backgroundColor != [UIColor whiteColor]) {
                    box.backgroundColor = [UIColor blueColor];
                }
            }
            break;
        case 3:
            // player1 - highlight around him - which he is
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                // stops glitches
                // put code that stops players from moving right next to each other
                
                // left bound
                if (player2.tag == 0 || player2.tag == 7 || player2.tag == 14 || player2.tag == 21 || player2.tag == 28 ||
                    player2.tag == 35 || player2.tag == 42) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player2.tag + 1 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag + 8 ||
                        box.tag == player2.tag - 7 || box.tag == player2.tag - 6) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                // right bound
                else if (player2.tag == 6 || player2.tag == 13 || player2.tag == 20 || player2.tag == 27 ||
                         player2.tag == 34 ||
                         player2.tag == 41 || player2.tag == 48) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player2.tag - 1 || box.tag == player2.tag + 6 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag - 8 ||
                        box.tag == player2.tag - 7) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                else{
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player2.tag - 1 || box.tag == player2.tag + 1 || box.tag == player2.tag + 6 ||
                        box.tag == player2.tag + 7 || box.tag == player2.tag + 8 || box.tag == player2.tag - 8 ||
                        box.tag == player2.tag - 7 || box.tag == player2.tag - 6) {
                        
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                        }
                    }
                }
                // remove the squares that are next to other player
                if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 6 ||
                    box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                    box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                    if (box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor blueColor];
                    }
                }
            }
            
            break;
        case 4:
            // reset the colors
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                if (box.backgroundColor != [UIColor whiteColor]) {
                    box.backgroundColor = [UIColor blueColor];
                }
            }
            break;
        
    }
}

// new way
// returns the number of movable places each player has
-(int)checkIfPlayer1Won{
    
    int numOfMovableSquares = 0;
    
    NSMutableArray *objectsNextToPlayer2 = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i<backgroundObjects.count; i++) {
        UIImageView *box = [backgroundObjects objectAtIndex:i];
        
        // left bound
        if (player2.tag == 0 || player2.tag == 7 || player2.tag == 14 || player2.tag == 21 || player2.tag == 28 ||
            player2.tag == 35 || player2.tag == 42) {
            // for all boxes that are around squares - highlight them
            if (box.tag == player2.tag + 1 ||
                box.tag == player2.tag + 7 || box.tag == player2.tag + 8 ||
                box.tag == player2.tag - 7 || box.tag == player2.tag - 6) {
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares++;
                    [objectsNextToPlayer2 addObject:box];
                }
            }
        }
        // right bound
        else if (player2.tag == 6 || player2.tag == 13 || player2.tag == 20 || player2.tag == 27 ||
                 player2.tag == 34 || player2.tag == 41 || player2.tag == 48) {
            // for all boxes that are around squares - highlight them
            if (box.tag == player2.tag - 1 || box.tag == player2.tag + 6 ||
                box.tag == player2.tag + 7 || box.tag == player2.tag - 8 ||
                box.tag == player2.tag - 7) {
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares++;
                    [objectsNextToPlayer2 addObject:box];
                }
            }
        }
        else{
            // for all boxes that are around squares - highlight them
            if (box.tag == player2.tag - 1 || box.tag == player2.tag + 1 || box.tag == player2.tag + 6 ||
                box.tag == player2.tag + 7 || box.tag == player2.tag + 8 || box.tag == player2.tag - 8 ||
                box.tag == player2.tag - 7 || box.tag == player2.tag - 6) {
                
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares++;
                    [objectsNextToPlayer2 addObject:box];
                }
            }
        }
    }
    
    if (objectsNextToPlayer2.count) {
        for (int i = 0; i < objectsNextToPlayer2.count; i++) {
            UIImageView *box = [objectsNextToPlayer2 objectAtIndex:i];
            
            // remove the squares that are next to other player
            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 6 ||
                box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares--;
                }
            }
        }
    }
    
    // maybe?
    // [objectsNextToPlayer2 removeAllObjects];
    
    return numOfMovableSquares;
    
}
-(int)checkIfPlayer2Won{
    
    int numOfMovableSquares = 0;
    
    NSMutableArray *objectsNextToPlayer1 = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i<backgroundObjects.count; i++) {
        UIImageView *box = [backgroundObjects objectAtIndex:i];
        
        // left bound
        if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 ||
            player.tag == 35 || player.tag == 42) {
            // for all boxes that are around squares - highlight them
            if (box.tag == player.tag + 1 ||
                box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares++;
                    [objectsNextToPlayer1 addObject:box];
                }
            }
        }
        // right bound
        else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 ||
                 player.tag == 41 || player.tag == 48) {
            // for all boxes that are around squares - highlight them
            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                box.tag == player.tag - 7) {
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares++;
                    [objectsNextToPlayer1 addObject:box];
                }
            }
        }
        else{
            // for all boxes that are around squares - highlight them
            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares++;
                    [objectsNextToPlayer1 addObject:box];
                }
            }
        }
    }
    
    if (objectsNextToPlayer1.count) {
        for (int i = 0; i < objectsNextToPlayer1.count; i++) {
            UIImageView *box = [objectsNextToPlayer1 objectAtIndex:i];
            
            // remove the squares that are next to other player
            if (box.tag == player2.tag - 8 || box.tag == player2.tag - 7 || box.tag == player2.tag - 6 ||
                box.tag == player2.tag - 1 || box.tag == player2.tag + 1 || box.tag == player2.tag + 6 ||
                box.tag == player2.tag + 7 || box.tag == player2.tag + 8) {
                if (box.backgroundColor != [UIColor whiteColor]) {
                    numOfMovableSquares--;
                }
            }
        }
    }
    
    // maybe?
    // [objectsNextToPlayer1 removeAllObjects];
    
    return numOfMovableSquares;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (gamestate != kGameStateActive) return;
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.view];
    
    for (int i = 0; i<backgroundObjects.count; i++) {
        UIImageView *box = [backgroundObjects objectAtIndex:i];
        
        if ([box pointInside: [self.view convertPoint:location toView:box] withEvent:event]) {
            NSLog(@"Hit square %li", (long)box.tag);
            
            switch (playerState) {
                case 1:
                    // update position
                    if (box.backgroundColor == [UIColor yellowColor] && box.tag != player2.tag) {
                        
                        player.tag = box.tag;
                        [self movePlayer:box.frame];
                        
                        playerLabel.text = [NSString stringWithFormat:@"%@: Remove A Square",
                                            [GKLocalPlayer localPlayer].alias];
                        
                        [self sendMove:(int)box.tag];
                        
                    }
                    break;
                case 2:
                    if (box.tag != player.tag && box.tag != player2.tag && box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor whiteColor];
                        
                        [self sendSquare:(int)box.tag];
                        [self setGameState:kGameStateInActive];
                        
                        if ([self checkIfPlayer1Won] == 0) {
                            playerLabel.text = @"You won!";
                            // player2Label.text = @"You Lost!";
                            playerState = 0;
                            
                            if (isPlayer1) {
                                // YES player1 won
                                [self sendGameOver:YES];
                                
                                // animation here
                                
                                if (!modeViewController.isViewLoaded && !modeViewController.view.window) {
                                    // modeViewController is NOT visible
                                    
                                    // again or disconnect
                                    UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Play Again?"
                                                                                       message:@"Would you like to play aginast this player again?"
                                                                                      delegate:self
                                                                             cancelButtonTitle:@"No"
                                                                             otherButtonTitles:@"Yes",nil];
                                    
                                    [endAlert show];
                                }
                                
                            }
                            else{
                                // YES player1 won
                                [self sendGameOver:NO];
                                
                                // animation here
                                
                                if (!modeViewController.isViewLoaded && !modeViewController.view.window) {
                                    // modeViewController is NOT visible
                                    
                                    // again or disconnect
                                    UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Play Again?"
                                                                                       message:@"Would you like to play aginast this player again?"
                                                                                      delegate:self
                                                                             cancelButtonTitle:@"No"
                                                                             otherButtonTitles:@"Yes",nil];
                                    
                                    [endAlert show];
                                }
                            }
                        }
                        else if ([self checkIfPlayer2Won] == 0) {
                            playerLabel.text = @"You Lost!";
                            // player2Label.text = @"You Won!";
                            playerState = 0;
                            
                            if (isPlayer1) {
                                // YES player1 won
                                [self sendGameOver:NO];
                                
                                // animation here
                                
                                if (!modeViewController.isViewLoaded && !modeViewController.view.window) {
                                    // modeViewController is NOT visible
                                    
                                    // again or disconnect
                                    UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Play Again?"
                                                                                       message:@"Would you like to play aginast this player again?"
                                                                                      delegate:self
                                                                             cancelButtonTitle:@"No"
                                                                             otherButtonTitles:@"Yes",nil];
                                    
                                    [endAlert show];
                                }
                            }
                            else{
                                // YES player1 won
                                [self sendGameOver:YES];
                                
                                // animation here
                                
                                if (!modeViewController.isViewLoaded && !modeViewController.view.window) {
                                    // modeViewController is NOT visible
                                    
                                    // again or disconnect
                                    UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Play Again?"
                                                                                       message:@"Would you like to play aginast this player again?"
                                                                                      delegate:self
                                                                             cancelButtonTitle:@"No"
                                                                             otherButtonTitles:@"Yes",nil];
                                    
                                    [endAlert show];
                                }
                            }
                        }
                        else{
                            playerState = 3;
                            // update choises for other player
                            [self updateChoises];
                            
                            playerLabel.text = [NSString stringWithFormat:@"%@",[GKLocalPlayer localPlayer].alias];
                        }
                        
                    }
                    break;
                    
                default:
                    break;
            }
        }
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)reset{
    // turn all background boxes blue again
    for (int i = 0; i<backgroundObjects.count; i++) {
        UIImageView *box = [backgroundObjects objectAtIndex:i];
        box.backgroundColor = [UIColor blueColor];
    }
    
    // reset players
    player.frame = [[backgroundObjects objectAtIndex:45] frame];
    player.tag = 45;
    player2.frame = [[backgroundObjects objectAtIndex:3] frame];
    player2.tag = 3;
    
    // reset labels / buttons
    playerLabel.text = [NSString stringWithFormat:@"%@",[GKLocalPlayer localPlayer].alias];
    GKPlayer *otherPlayer = [[GCHelper sharedInstance].playersDict objectForKey:otherPlayerID];
    player2Label.text = [NSString stringWithFormat:@"%@",otherPlayer.alias];
    
    // reset game state
    playerState = 1;
    
}

#pragma mark GCHelperDelegate

- (void)matchStarted {
    NSLog(@"Match started");
    if (receivedRandom) {
        [self setGameState:kGameStateWaitingForStart];
    } else {
        [self setGameState:kGameStateWaitingForRandomNumber];
    }
    [self sendRandomNumber];
    [self tryStartGame];
}

- (void)matchEnded {
    NSLog(@"Match ended");
    
    if (IS_IPHONE_5) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    }
    else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    }
    
    UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                       message:@"The other player was disconeected"
                                                      delegate:self
                                             cancelButtonTitle:@"No"
                                             otherButtonTitles:nil, nil];
    
    
    [endAlert show];
    
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    
    // Store away other player ID for later
    if (otherPlayerID == nil) {
        otherPlayerID = playerID;
    }
    
    Message *message = (Message *) [data bytes];
    if (message->messageType == kMessageTypeRandomNumber) {
        
        MessageRandomNumber * messageInit = (MessageRandomNumber *) [data bytes];
        NSLog(@"Received random number: %ud, ours %ud", messageInit->randomNumber, ourRandom);
        bool tie = false;
        
        if (messageInit->randomNumber == ourRandom) {
            NSLog(@"TIE!");
            tie = true;
            ourRandom = arc4random();
            [self sendRandomNumber];
        } else if (ourRandom > messageInit->randomNumber) {
            NSLog(@"We are player 1");
            isPlayer1 = YES;
        } else {
            NSLog(@"We are player 2");
            isPlayer1 = NO;
        }
        
        if (!tie) {
            receivedRandom = YES;
            if (gamestate == kGameStateWaitingForRandomNumber) {
                [self setGameState:kGameStateWaitingForStart];
            }
            [self tryStartGame];
        }
        
    }
    else if (message->messageType == kMessageTypeGameBegin) {
        
        [self setGameState:kGameStateInActive];
        
        [self setupStringsWithOtherPlayerId:otherPlayerID];
        
    }
    else if (message->messageType == kMessageTypeMove) {
        
        NSLog(@"Received move");
        
        MessageMove * messageMove = (MessageMove *) [data bytes];
        
        int boxToMoveTo = messageMove->boxTag;
        boxToMoveTo = 48 - boxToMoveTo;
        
        player2.tag = boxToMoveTo;
        player2.frame = [[backgroundObjects objectAtIndex:boxToMoveTo] frame];
        
        playerState = 2;
        [self updateChoises];
        
        // GKPlayer *otherPlayer = [[GCHelper sharedInstance].playersDict objectForKey:playerID];
        // player2Label.text = [NSString stringWithFormat:@"%@: Remove A Square",otherPlayer.alias];
        
    }
    else if (message->messageType == kMessageTypeDelete) {
        
        NSLog(@"Received deleted square");
        
        MessageDelete * messageDelete = (MessageDelete *) [data bytes];
        
        int boxRemove = messageDelete->boxTag;
        boxRemove = 48 - boxRemove;
        
        UIImageView *box = [backgroundObjects objectAtIndex:boxRemove];
        box.backgroundColor = [UIColor whiteColor];
        
        [self setGameState:kGameStateActive];
        playerState = 1;
        [self updateChoises];
        
        playerLabel.text = [NSString stringWithFormat:@"%@: Move",[GKLocalPlayer localPlayer].alias];
        
        GKPlayer *otherPlayer = [[GCHelper sharedInstance].playersDict objectForKey:playerID];
        player2Label.text = [NSString stringWithFormat:@"%@",otherPlayer.alias];
        
    }
    else if (message->messageType == kMessageTypePlayAgain) {
        
        receivedRandom = NO;
        ourRandom = arc4random();
        [self setGameState:kGameStateWaitingForRandomNumber];
        [self reset];
        [self matchStarted];
        
    }
    else if (message->messageType == kMessageTypeGameOver) {
        
        [self setGameState:kGameStateInActive];
        
        MessageGameOver * messageGameOver = (MessageGameOver *) [data bytes];
        NSLog(@"Received game over with player 1 won: %d", messageGameOver->player1Won);
        
        if (messageGameOver->player1Won) {
            
            if (isPlayer1) {
                playerLabel.text = @"You won!";
                // player2Label.text = @"You Lost!";
            }
            else{
                playerLabel.text = @"You Lost!";
                // player2Label.text = @"You Lost!";
            }
            playerState = 0;
            
        } else {
            if (isPlayer1) {
                playerLabel.text = @"You Lost!";
                // player2Label.text = @"You Lost!";
            }
            else{
                playerLabel.text = @"You Won!";
                // player2Label.text = @"You Lost!";
            }
            playerState = 0;
        }
        
        // animation here
        
        // again or disconnect
        UIAlertView *endAlert = [[UIAlertView alloc] initWithTitle:@"Play Again?"
                                                            message:@"Would you like to play aginast this player again?"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes",nil];
        
        [endAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex: buttonIndex];
    if ([buttonTitle isEqualToString:@"Yes"]) {
        
        ourRandom = arc4random();
        [self setGameState:kGameStateWaitingForRandomNumber];
        receivedRandom = NO;
        [self reset];
        
        // game invite
        [self sendPlayAgain];
        
        [self matchStarted];
        
    }
    if ([buttonTitle isEqualToString:@"No"]) {
        // to disconnect
        [[GCHelper sharedInstance].match disconnect];
        [GCHelper sharedInstance].match = nil;
        
        if (IS_IPHONE_5) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
        }
        else{
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
        }
    }
}

#pragma mark GCHelperMethods

- (void)sendRandomNumber {
    MessageRandomNumber message;
    message.message.messageType = kMessageTypeRandomNumber;
    message.randomNumber = ourRandom;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageRandomNumber)];
    [self sendData:data];
}

- (void)sendGameBegin {
    MessageGameBegin message;
    message.message.messageType = kMessageTypeGameBegin;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameBegin)];
    [self sendData:data];
}

/*
- (void)sendMove {
    MessageMove message;
    message.message.messageType = kMessageTypeMove;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageMove)];
    [self sendData:data];
}

- (void)sendSquare {
    MessageMove message;
    message.message.messageType = kMessageTypeDelete;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageDelete)];
    [self sendData:data];
}
 */

- (void)sendMove:(int)boxTag {
    MessageMove message;
    message.message.messageType = kMessageTypeMove;
    message.boxTag = boxTag;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageMove)];
    [self sendData:data];
}

- (void)sendSquare:(int)boxTag {
    MessageDelete message;
    message.message.messageType = kMessageTypeDelete;
    message.boxTag = boxTag;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageDelete)];
    [self sendData:data];
}

- (void)sendGameOver:(BOOL)player1Won {
    MessageGameOver message;
    message.message.messageType = kMessageTypeGameOver;
    message.player1Won = player1Won;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameOver)];
    [self sendData:data];
}

- (void)sendPlayAgain{
    MessagePlayAgain message;
    message.message.messageType = kMessageTypePlayAgain;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessagePlayAgain)];
    [self sendData:data];
}

- (void)sendData:(NSData *)data {
    NSError *error;
    BOOL success = [[GCHelper sharedInstance].match sendDataToAllPlayers:data
                                                            withDataMode:GKMatchSendDataReliable
                                                                   error:&error];
    if (!success) {
        NSLog(@"Error sending init packet");
        [self matchEnded];
    }
}

- (void)tryStartGame {
    NSLog(@"trying to start game");
    if (isPlayer1 && gamestate == kGameStateWaitingForStart) {
        [self setGameState:kGameStateActive];
        [self sendGameBegin];
        
        [self setupStringsWithOtherPlayerId:otherPlayerID];
        
        if (isPlayer1) {
            [self updateChoises];
            playerLabel.text = [NSString stringWithFormat:@"%@: Move",[GKLocalPlayer localPlayer].alias];
        }
        
        NSLog(@"game started");
    }
}

- (void)setupStringsWithOtherPlayerId:(NSString *)playerID {
    playerLabel.text = [NSString stringWithFormat:@"%@",[GKLocalPlayer localPlayer].alias];
        
    GKPlayer *otherPlayer = [[GCHelper sharedInstance].playersDict objectForKey:playerID];
    player2Label.text = [NSString stringWithFormat:@"%@",otherPlayer.alias];
}

- (void)setGameState:(GameState)state {
    
    gamestate = state;
    
    if (gamestate == kGameStateWaitingForMatch) {
        // [debugLabel setString:@"Waiting for match"];
    } else if (gamestate == kGameStateWaitingForRandomNumber) {
        // [debugLabel setString:@"Waiting for rand #"];
    } else if (gamestate == kGameStateWaitingForStart) {
        // [debugLabel setString:@"Waiting for start"];
    } else if (gamestate == kGameStateActive) {
        // [debugLabel setString:@"Active"];
    } else if (gamestate == kGameStateDone) {
        // [debugLabel setString:@"Done"];
    }
    
}

- (void)endScene:(EndReason)endReason {
    
    if (gamestate == kGameStateDone) return;
    [self setGameState:kGameStateDone];
    
    NSString *message;
    if (endReason == kEndReasonWin) {
        message = @"You win!";
    } else if (endReason == kEndReasonLose) {
        message = @"You lose!";
    }
    
    if (isPlayer1) {
        if (endReason == kEndReasonWin) {
            [self sendGameOver:true];
        } else if (endReason == kEndReasonLose) {
            [self sendGameOver:false];
        }
    }
    
}

- (void)inviteReceived {
    NSLog(@"revieved in Gcplayerclass");
    
    if (IS_IPHONE_5) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    }
    else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ModeController"];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    }
    
    [self reset];
}

@end
