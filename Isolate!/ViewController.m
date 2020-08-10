//
//  ViewController.m
//  Isolate!
//
//  Created by Aaron on 5/31/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

// do player collision
// who wins

#import "ViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ViewController ()

@end

int boxNum = 0;

@implementation ViewController

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
                
                box.tag = boxNum;
                boxNum++;
                
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
                
                box.tag = boxNum;
                boxNum++;
                
                [self.view addSubview:box];
                
                [backgroundObjects addObject:box];
            }
        }
    }
    
    // to fix a bug
    boxNum = 0;
    
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
    
    // highlights choises
    [self updateChoises];

    // user interface
    // option for no labels?
    // flip label for player 2
    player2Label.transform = CGAffineTransformMakeRotation( M_PI );
    
    playerLabel.text = @"Player: Move";
    resetButton.hidden = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [self reset];
}

-(void)movePlayer:(CGRect)rect{
    switch (playerState) {
        case 1:
            [player setFrame:rect];
            playerState = 2;
            // clears choises
            [self updateChoises];
            break;
        case 2:
            // PlayersState = Player2Move;
            break;
        case 3:
            [player2 setFrame:rect];
            playerState = 4;
            // clears choises
            [self updateChoises];
            break;
        case 4:
            // PlayersState = PlayerMove;
            break;
            
        default:
            break;
    }
}

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
            playerLabel.text = @"Player 1";
            player2Label.text = @"Player 2: Move";
            
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

// old way
/*
-(void)checkIfPlayer1Won{
 
    // player two lost
 
    // corners first (top left)
    if (player2.tag == 0) {
        if ([[backgroundObjects objectAtIndex:(player2.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // top right
    else if (player2.tag == 6) {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 6)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // bottom left
    else if (player2.tag == 42) {
        if ([[backgroundObjects objectAtIndex:(player2.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 6)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // bottom right
    else if (player2.tag == 48) {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // left bound
    else if (player2.tag == 7 || player2.tag == 14 || player2.tag == 21 || player2.tag == 28 || player2.tag == 35) {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // right bound
    else if (player2.tag == 13 || player2.tag == 20 || player2.tag == 27 || player2.tag == 34 || player2.tag == 41) {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 8)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 7)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // top
    else if (player2.tag == 1 || player2.tag == 2 || player2.tag == 3 || player2.tag == 4 || player2.tag == 5) {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // bottom
    else if (player2.tag == 43 || player2.tag == 44 || player2.tag == 45 || player2.tag == 46 || player2.tag == 47) {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 8)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 1)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // middle
    else {
        if ([[backgroundObjects objectAtIndex:(player2.tag - 8)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player2.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Won!";
            player2Label.text = @"You Lost!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
}
-(void)checkIfPlayer2Won{
    
    // player one lost
    
    // corners first (top left)
    if (player.tag == 0) {
        if ([[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // top right
    else if (player.tag == 6) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // bottom left
    else if (player.tag == 42) {
        if ([[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // bottom right
    else if (player.tag == 48) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // left bound
    else if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // right bound
    else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // top
    else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // bottom
    else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
            
            // here
            NSLog(@"yes 2");
        }
    }
    
    // middle
    else {
        if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != [UIColor yellowColor] &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != [UIColor yellowColor]) {
            playerLabel.text = @"You Lost!";
            player2Label.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
}
 */

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.view];
    
    for (int i = 0; i<backgroundObjects.count; i++) {
        UIImageView *box = [backgroundObjects objectAtIndex:i];
        
        
        if ([box pointInside: [self.view convertPoint:location toView:box] withEvent:event]) {
            NSLog(@"Hit square %i", box.tag);
            
            switch (playerState) {
                case 1:
                    // update position
                    if (box.backgroundColor == [UIColor yellowColor] && box.tag != player2.tag) {
                        player.tag = box.tag;
                        [self movePlayer:box.frame];
                        
                        playerLabel.text = @"Player: Remove a Square";
                    }
                    break;
                case 2:
                    if (box.tag != player.tag && box.tag != player2.tag && box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor whiteColor];
                        
                        if ([self checkIfPlayer1Won] == 0) {
                            playerLabel.text = @"You won!";
                            player2Label.text = @"You Lost!";
                            playerState = 0;
                            resetButton.hidden = NO;
                        }
                        else if ([self checkIfPlayer2Won] == 0) {
                            playerLabel.text = @"You Lost!";
                            player2Label.text = @"You Won!";
                            playerState = 0;
                            resetButton.hidden = NO;
                        }
                        else{
                            // update choises for other player
                            playerState = 3;
                            [self updateChoises];
                        }
                    }
                    break;
                case 3:
                    // update position
                    if (box.backgroundColor == [UIColor yellowColor] && box.tag != player.tag) {
                        player2.tag = box.tag;
                        [self movePlayer:box.frame];
                        
                        player2Label.text = @"Player 2: Remove a Square";
                    }
                    break;
                case 4:
                    if (box.tag != player.tag && box.tag != player2.tag && box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor whiteColor];
                        
                        // check if any of them are trapped
                        if ([self checkIfPlayer1Won] == 0) {
                            playerLabel.text = @"You won!";
                            player2Label.text = @"You Lost!";
                            playerState = 0;
                            resetButton.hidden = NO;
                        }
                        else if ([self checkIfPlayer2Won] == 0) {
                            playerLabel.text = @"You Lost!";
                            player2Label.text = @"You Won!";
                            playerState = 0;
                            resetButton.hidden = NO;
                        }
                        else{
                            // update choises for other player
                            playerState = 1;
                            
                            player2Label.text = @"Player 2";
                            playerLabel.text = @"Player 1: Move";
                            
                            [self updateChoises];
                        }
    
                    }
                    break;
                    
                default:
                    break;
            }
        }
    }
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
    playerLabel.text = @"Player 1: Move";
    player2Label.text = @"Player 2";
    resetButton.hidden = YES;
    
    // reset game state
    playerState = 1;
    
    // start game
    [self updateChoises];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
