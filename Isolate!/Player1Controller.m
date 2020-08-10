//
//  Player1Controller.m
//  Isolate!
//
//  Created by Aaron on 6/3/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import "Player1Controller.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface Player1Controller ()

@end

int boxNum2 = 0;

@implementation Player1Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    backgroundObjects = [[NSMutableArray alloc] init];
    objectsNext2Computer = [[NSMutableArray alloc] init];
    objectsComputerCanDelete = [[NSMutableArray alloc] init];
    
    if (IS_IPHONE_5) {
        // create map
        for (int a = 0; a < 7; a++) {
            for (int b = 0; b < 7; b++) {
                UIImageView *box = [[UIImageView alloc] initWithFrame:CGRectMake(15 + 42*b, 135 + 42*a, 40, 40)];
                box.backgroundColor = [UIColor blueColor];
                
                box.tag = boxNum2;
                boxNum2++;
                
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
                
                box.tag = boxNum2;
                boxNum2++;
                
                [self.view addSubview:box];
                
                [backgroundObjects addObject:box];
            }
        }
    }
    
    // to fix a bug
    boxNum2 = 0;
    
    // create players
    player = [[UIImageView alloc] initWithFrame:[[backgroundObjects objectAtIndex:45] frame]];
    player.tag = 45;
    player.backgroundColor = [UIColor greenColor];
    [self.view addSubview:player];
    
    computer = [[UIImageView alloc] initWithFrame:[[backgroundObjects objectAtIndex:3] frame]];
    computer.tag = 3;
    computer.backgroundColor = [UIColor redColor];
    [self.view addSubview:computer];
    
    //update game state
    playerState = 1;
    
    // highlights choises
    [self updateChoises];
    
    // user interface
    // option for no labels?
    // flip label for player 2
    computerLabel.transform = CGAffineTransformMakeRotation( M_PI );
    
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
            // clears
            [self updateChoises];
            break;
        case 2:
            // PlayersState = Player2Move;
            break;
        case 3:
            [computer setFrame:rect];
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
                
                
                // still in for loop
                // to get rid of squares around comupter
                
                // left bound
                if (computer.tag == 0 || computer.tag == 7 || computer.tag == 14 || computer.tag == 21 ||
                    computer.tag == 28 || computer.tag == 35 || computer.tag == 42) {
                    
                    // remove the squares that are next to other player
                    if (box.tag == computer.tag - 7 || box.tag == computer.tag - 6 ||
                        box.tag == computer.tag + 1 || box.tag == computer.tag + 7 ||
                        box.tag == computer.tag + 8) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                        }
                    }
                    
                }
                // right bound
                else if (computer.tag == 6 || computer.tag == 13 || computer.tag == 20 || computer.tag == 27 ||
                         computer.tag == 34 || computer.tag == 41 || computer.tag == 48) {
                    
                    // for all boxes that are around squares - highlight them
                    if (box.tag == computer.tag - 8 || box.tag == computer.tag - 7 ||
                        box.tag == computer.tag - 1 || box.tag == computer.tag + 6 ||
                        box.tag == computer.tag + 7) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                        }
                    }
                }
                else{
                    // for all boxes that are around squares - highlight them
                    if (box.tag == computer.tag - 1 || box.tag == computer.tag + 1 || box.tag == computer.tag + 6 ||
                        box.tag == computer.tag + 7 || box.tag == computer.tag + 8 || box.tag == computer.tag - 8 ||
                        box.tag == computer.tag - 7 || box.tag == computer.tag - 6) {
                        
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                        }
                    }
                }
            }
            
            [self checkIfPlayer2Won];
            
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
            // highlight all squares around computer
            for (int i = 0 ; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                // stops glitch
                
                // left bound
                if (computer.tag == 0 || computer.tag == 7 || computer.tag == 14 || computer.tag == 21 || computer.tag == 28||
                    computer.tag == 35 || computer.tag == 42) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == computer.tag - 7 ||
                        box.tag == computer.tag - 6 || box.tag == computer.tag + 1 ||
                        box.tag == computer.tag + 7 || box.tag == computer.tag + 8) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                            
                            [objectsNext2Computer addObject:box];
                        }
                    }
                }
                // right bound
                else if (computer.tag == 6 || computer.tag == 13 || computer.tag == 20 || computer.tag == 27 ||
                         computer.tag == 34 || computer.tag == 41 || computer.tag == 48) {
                    // for all boxes that are around squares - highlight them
                    if (box.tag == computer.tag - 8 || box.tag == computer.tag - 7 ||
                        box.tag == computer.tag - 1 || box.tag == computer.tag + 6 ||
                        box.tag == computer.tag + 7) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                            
                            [objectsNext2Computer addObject:box];
                        }
                    }
                }
                else{
                    // for all boxes that are around squares - highlight them
                    if (box.tag == computer.tag - 8 || box.tag == computer.tag - 7 || box.tag == computer.tag - 6 ||
                        box.tag == computer.tag - 1 || box.tag == computer.tag + 1 || box.tag == computer.tag + 6 ||
                        box.tag == computer.tag + 7 || box.tag == computer.tag + 8) {
                        
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor yellowColor];
                            
                            [objectsNext2Computer addObject:box];
                        }
                    }
                }
                
                // still in for loop
                // to get rid of squares around player
                
                // left bound
                if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 ||
                    player.tag == 28 || player.tag == 35 || player.tag == 42) {
                    
                    // remove the squares that are next to other player
                    if (box.tag == player.tag - 7 || box.tag == player.tag - 6 ||
                        box.tag == player.tag + 1 || box.tag == player.tag + 7 ||
                        box.tag == player.tag + 8) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                            [objectsNext2Computer removeObject:box];
                        }
                    }
                    
                }
                // right bound
                else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 ||
                         player.tag == 34 || player.tag == 41 ||  player.tag == 48) {
                    
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player.tag - 8 || box.tag == player.tag - 7 ||
                        box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                        box.tag == player.tag + 7) {
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                            [objectsNext2Computer removeObject:box];
                        }
                    }
                }
                else{
                    // for all boxes that are around squares - highlight them
                    if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                        box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                        box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                        
                        if (box.backgroundColor != [UIColor whiteColor]) {
                            box.backgroundColor = [UIColor blueColor];
                            [objectsNext2Computer removeObject:box];
                        }
                    }
                }
            }
            playerLabel.text = @"Player 1";
            computerLabel.text = @"Computer: Move";
            
            [self checkIfPlayer1Won];
            
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

 -(void)checkIfPlayer1Won{
 
 // player two lost
 
 // corners first (top left)
     if (computer.tag == 0) {
            if ([[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
                [[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
                [[backgroundObjects objectAtIndex:(computer.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
                playerLabel.text = @"You Won!";
                computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
                
                
 }
 }
 // top right
 else if (computer.tag == 6) {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
     
 }
 }
 // bottom left
 else if (computer.tag == 42) {
 if ([[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
     
 }
 }
 // bottom right
 else if (computer.tag == 48) {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
     
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 
 // left bound
 else if (computer.tag == 7 || computer.tag == 14 || computer.tag == 21 || computer.tag == 28 || computer.tag == 35) {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
     
 }
 }
 
 // right bound
 else if (computer.tag == 13 || computer.tag == 20 || computer.tag == 27 || computer.tag == 34 || computer.tag == 41) {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
     
 }
 }
 
 // top
 else if (computer.tag == 1 || computer.tag == 2 || computer.tag == 3 || computer.tag == 4 || computer.tag == 5) {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
     
 }
 }
 
 // bottom
 else if (computer.tag == 43 || computer.tag == 44 || computer.tag == 45 || computer.tag == 46 || computer.tag == 47) {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
 computerLabel.text = @"You Lost!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
     
 }
 }
 
 // middle
 else {
 if ([[backgroundObjects objectAtIndex:(computer.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(computer.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Won!";
computerLabel.text = @"You Lost!";
 
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
 if ([[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You lost!";
 computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 // top right
 else if (player.tag == 6) {
 if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You lost!";
 computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 // bottom left
 else if (player.tag == 42) {
 if ([[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You lost!";
 computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 // bottom right
 else if (player.tag == 48) {
 if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You lost!";
 computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 
 // left bound
 else if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
 if ([[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Lost!";
computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 
 // right bound
 else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
 if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Lost!";
computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 
 // top
 else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5) {
 if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Lost!";
computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 
 // bottom
 else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47) {
 if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Lost!";
 computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 
 
 }
 }
 
 // middle
 else {
 if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
 [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
 playerLabel.text = @"You Lost!";
computerLabel.text = @"You Won!";
 
 // stop game loop
 playerState = 0;
 
 //show reset button
 resetButton.hidden = NO;
 }
 }
 }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"touch");
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.view];
    
    for (int i = 0; i<backgroundObjects.count; i++) {
        UIImageView *box = [backgroundObjects objectAtIndex:i];
        
        
        if ([box pointInside: [self.view convertPoint:location toView:box] withEvent:event]) {
            NSLog(@"Hit square %i", box.tag);
            
            switch (playerState) {
                case 1:
                    // update position
                    if (box.backgroundColor == [UIColor yellowColor] && box.tag != computer.tag) {
                        player.tag = box.tag;
                        [self movePlayer:box.frame];
                        
                        playerLabel.text = @"Player: Remove a Square";
                    }
                    break;
                case 2:
                    if (box.tag != player.tag && box.tag != computer.tag && box.backgroundColor != [UIColor whiteColor]) {
                        box.backgroundColor = [UIColor whiteColor];
                       
                            // update choises for other player
                            playerState = 3;
                            [self updateChoises];
                            [self computerStartToThink];
                        
                    }
                    break;
                case 3:
                    // if user taps multable times.... bad
                    // might work
                    // [self.view setUserInteractionEnabled:NO];
                    // [self computerStartToThink];
                    break;
                case 4:
                    // nothing?
                    break;
                    
                default:
                    break;
            }
        }
    }
}

-(void)computerStartToThink{
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(computerMove) userInfo:nil repeats:NO];
}
// waits a second then calls this
-(void)computerMove{
    // moves randomly
    
    /*
    // moves computer randomly
    // stop from error
    if (objectsNext2Computer.count) {
     
        // removes moves that will get computer killed instantly
        [self removeStupidMoves];
     
        int randBox2Move2 = arc4random() % objectsNext2Computer.count;
     
        UIImageView *box =[objectsNext2Computer objectAtIndex:randBox2Move2];
     
        computer.tag = box.tag;
        [self movePlayer:box.frame];
     
        computerLabel.text = @"Computer: Remove a Square";
     
        // clear for next turn
        [objectsNext2Computer removeAllObjects];
        
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(computerDeleteASquare) userInfo:nil repeats:NO];
    }
     */
    
    // moves towards player
    // stop from error
    if (objectsNext2Computer.count) {
        
        BOOL right = false;
        BOOL left = false;
        BOOL up = false;
        BOOL down = false;
        
        // make bool values correct
        if (computer.frame.origin.y > player.frame.origin.y) {
            NSLog(@"computer should move up 2");
            up = true;
        }
        else{
            NSLog(@"computer should move down 2");
            down = true;
        }
        
        if (computer.frame.origin.x > player.frame.origin.x) {
            NSLog(@"computer should move left 2");
            left = true;
        }
        else{
            NSLog(@"computer should move right 2");
            right = true;
        }
        
        if (computer.frame.origin.y == player.frame.origin.y) {
            if (computer.frame.origin.x > player.frame.origin.x) {
                NSLog(@"computer should move left");
                left = true;
                up = false;
                down = false;
            }
            else {
                NSLog(@"computer should move right");
                right = true;
                up = false;
                down = false;
            }
        }
        
        if (computer.frame.origin.x == player.frame.origin.x) {
            if (computer.frame.origin.y > player.frame.origin.y) {
                NSLog(@"computer should move up");
                up = true;
                left = false;
                right = false;
            }
            else{
                NSLog(@"computer should move down");
                down = true;
                left = false;
                right = false;
            }
        }
        
        NSLog(@"up - %i", up);
        NSLog(@"down - %i", down);
        NSLog(@"right - %i", right);
        NSLog(@"left - %i", left);
        
        // using the bools remove squares that are not twords player
        if (up) {
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 1 == box.tag || computer.tag + 1 == box.tag || computer.tag + 6 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 1 == box.tag || computer.tag + 1 == box.tag || computer.tag + 6 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                     [objectsNext2Computer removeObject:box];
                }
                
            }
        }
        if (down) {
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 6 == box.tag ||
                    computer.tag - 1 == box.tag || computer.tag + 1 == box.tag) {
                    
                    [arrayToDelete addObject:box];
                    
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 6 == box.tag ||
                    computer.tag - 1 == box.tag || computer.tag + 1 == box.tag) {
                    
                    [objectsNext2Computer removeObject:box];
                    
                }
            }
        }
        if (right) {
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 1 == box.tag ||
                    computer.tag + 6 == box.tag || computer.tag + 7 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 1 == box.tag ||
                    computer.tag + 6 == box.tag || computer.tag + 7 == box.tag) {
                    [objectsNext2Computer removeObject:box];
                }
            }
        }
        if (left) {
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 7 == box.tag || computer.tag - 6 == box.tag || computer.tag + 1 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 7 == box.tag || computer.tag - 6 == box.tag || computer.tag + 1 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [objectsNext2Computer removeObject:box];
                }
            }
        }
        
        if (up && left) {
            // put choises back into objectsNext2Computer
            [self updateChoises];
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 6 == box.tag || computer.tag + 1 == box.tag || computer.tag + 6 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 6 == box.tag || computer.tag + 1 == box.tag || computer.tag + 6 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [objectsNext2Computer removeObject:box];
                }
            }
            
        }
        if (up && right) {
            // put choises back into objectsNext2Computer
            [self updateChoises];
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 1 == box.tag || computer.tag + 6 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 1 == box.tag || computer.tag + 6 == box.tag ||
                    computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                    [objectsNext2Computer removeObject:box];
                }
            }
        }
        if (down && left) {
            // put choises back into objectsNext2Computer
            [self updateChoises];
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 6 == box.tag ||
                    computer.tag + 1 == box.tag || computer.tag + 8 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 6 == box.tag ||
                    computer.tag + 1 == box.tag || computer.tag + 8 == box.tag) {
                    [objectsNext2Computer removeObject:box];
                }
            }
            
        }
        if (down && right) {
            // put choises back into objectsNext2Computer
            [self updateChoises];
            
            NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<objectsNext2Computer.count; i++) {
                UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 6 == box.tag ||
                    computer.tag - 1 == box.tag || computer.tag + 6 == box.tag) {
                    [arrayToDelete addObject:box];
                }
            }
            
            for (int i = 0; i < arrayToDelete.count; i++) {
                UIImageView *box = [arrayToDelete objectAtIndex:i];
                
                if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 6 == box.tag ||
                    computer.tag - 1 == box.tag || computer.tag + 6 == box.tag) {
                    [objectsNext2Computer removeObject:box];
                }
            }
        }
        
        // check
        if (objectsNext2Computer.count == 0) {
            // put choises back into objectsNext2Computer
            [self updateChoises];
            
            // if direct approuch doesn't work
            // make computer go to the sides
            
            // using the bools remove squares that are not twords player
            if (up) {
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag + 6 == box.tag || computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag + 6 == box.tag || computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                    
                }
            }
            if (down) {
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag - 6 == box.tag || computer.tag - 7 == box.tag || computer.tag - 8 == box.tag) {
                        [arrayToDelete addObject:box];
                        
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag - 6 == box.tag || computer.tag - 7 == box.tag || computer.tag - 8 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                        
                    }
                }
            }
            if (right) {
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag - 8 == box.tag || computer.tag - 1 == box.tag || computer.tag + 6 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag - 8 == box.tag || computer.tag - 1 == box.tag || computer.tag + 6 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                }
            }
            if (left) {
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag - 6 == box.tag || computer.tag + 1 == box.tag || computer.tag + 8 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag - 6 == box.tag || computer.tag + 1 == box.tag || computer.tag + 8 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                }
            }
            
            if (up && left) {
                // put choises back into objectsNext2Computer
                [self updateChoises];
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag + 1 == box.tag || computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag + 1 == box.tag || computer.tag + 7 == box.tag || computer.tag + 8 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                }
                
            }
            if (up && right) {
                // put choises back into objectsNext2Computer
                [self updateChoises];
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag - 1 == box.tag || computer.tag + 6 == box.tag || computer.tag + 7 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag - 1 == box.tag || computer.tag + 6 == box.tag || computer.tag + 7 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                }
            }
            if (down && left) {
                // put choises back into objectsNext2Computer
                [self updateChoises];
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag - 7 == box.tag || computer.tag - 6 == box.tag || computer.tag + 1 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag - 7 == box.tag || computer.tag - 6 == box.tag || computer.tag + 1 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                }
                
            }
            if (down && right) {
                // put choises back into objectsNext2Computer
                [self updateChoises];
                
                NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
                
                for (int i = 0; i<objectsNext2Computer.count; i++) {
                    UIImageView *box = [objectsNext2Computer objectAtIndex:i];
                    
                    if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 1 == box.tag) {
                        [arrayToDelete addObject:box];
                    }
                }
                
                for (int i = 0; i < arrayToDelete.count; i++) {
                    UIImageView *box = [arrayToDelete objectAtIndex:i];
                    
                    if (computer.tag - 8 == box.tag || computer.tag - 7 == box.tag || computer.tag - 1 == box.tag) {
                        [objectsNext2Computer removeObject:box];
                    }
                }
            }
        }
        
        // check
        if (objectsNext2Computer.count == 0) {
            // put choises back into objectsNext2Computer
            [self updateChoises];
            
            // if indirect approuch doesn't work
            // update choises all thats left is going back
        }
        
        // removes moves that will get computer killed instantly
        [self removeStupidMoves];
        
        int randBox2Move2 = arc4random() % objectsNext2Computer.count;
        
        UIImageView *box =[objectsNext2Computer objectAtIndex:randBox2Move2];
        
        computer.tag = box.tag;
        [self movePlayer:box.frame];
        
        computerLabel.text = @"Computer: Remove a Square";
        
        // clear for next turn
        [objectsNext2Computer removeAllObjects];
        
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(computerDeleteASquare) userInfo:nil repeats:NO];
    }
}

-(void)computerDeleteASquare{
    
    // corners first
    if (player.tag == 0) {
        if ([[backgroundObjects objectAtIndex:8] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:8]];
        }
        else if ([[backgroundObjects objectAtIndex:7] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])){
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:7]];
        }
        else{
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:1]];
        }
    }
    else if (player.tag == 6){
        if ([[backgroundObjects objectAtIndex:12] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:12]];
        }
        else if ([[backgroundObjects objectAtIndex:13] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])){
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:13]];
        }
        else{
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:5]];
        }
    }
    else if (player.tag == 42){
        if ([[backgroundObjects objectAtIndex:36] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:36]];
        }
        else if ([[backgroundObjects objectAtIndex:35] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])){
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:35]];
        }
        else{
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:43]];
        }
    }
    else if (player.tag == 48){
        if ([[backgroundObjects objectAtIndex:40] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:40]];
        }
        else if ([[backgroundObjects objectAtIndex:41] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor whiteColor])){
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:41]];
        }
        else{
            [objectsComputerCanDelete addObject:[backgroundObjects objectAtIndex:47]];
        }
    }
    // EVERYTHING ELSE!!!!
    else{
        // deletes a box around a player that focuses on a direction
        for (int i = 0; i<backgroundObjects.count; i++) {
            
            // when player is in corners it crashes
            
            UIImageView *box = [backgroundObjects objectAtIndex:i];
            
            //left
            if (computer.tag == 0 || computer.tag == 7 || computer.tag == 14 || computer.tag == 21 || computer.tag == 28 || computer.tag == 35 || computer.tag == 42) {
                // random square around player that is not a square next to the computer because its already blocked by it
                if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag &&
                    box.tag != computer.tag - 7 && box.tag != computer.tag - 6 &&
                    box.tag != computer.tag + 1 && box.tag != computer.tag + 7 &&
                    box.tag != computer.tag + 8) {
                    
                    // left bound
                    if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
                        // for all boxes that are around the player add them to boxes to delete
                        if (box.tag == player.tag + 1 || box.tag == player.tag + 8 || box.tag == player.tag - 6) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // right bound
                    else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
                        // for all boxes that are around the player add them to boxes to delete
                        if (box.tag == player.tag - 1 || box.tag == player.tag + 6 || box.tag == player.tag - 8) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // top
                    else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5){
                        if (box.tag == player.tag + 6 || box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // bottom
                    else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47){
                        if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // middle
                    else{
                        if (box.tag == player.tag - 8) {
                            if (([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag - 7) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag - 6) {
                            if (([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag - 1) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 1) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 6) {
                            if (([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag + 7) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 8) {
                            if (([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                    }
                }
            }
            // right
            else if (computer.tag == 6 || computer.tag == 13 || computer.tag == 20 || computer.tag == 27 || computer.tag == 34 || computer.tag == 41 || computer.tag == 48) {
                // random square around player that is not a square next to the computer because its already blocked by it
                if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag && box.tag != computer.tag - 8 &&
                    box.tag != computer.tag - 7 && box.tag != computer.tag - 1 && box.tag != computer.tag + 6 &&
                    box.tag != computer.tag + 7) {
                    
                    // left bound
                    if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
                        // for all boxes that are around the player add them to boxes to delete
                        if (box.tag == player.tag + 1 || box.tag == player.tag + 8 || box.tag == player.tag - 6) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // right bound
                    else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
                        // for all boxes that are around the player add them to boxes to delete
                        if (box.tag == player.tag - 1 || box.tag == player.tag + 6 || box.tag == player.tag - 8) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // top
                    else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5){
                        if (box.tag == player.tag + 6 || box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // bottom
                    else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47){
                        if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // middle
                    else{
                        if (box.tag == player.tag - 8) {
                            if (([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag - 7) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag - 6) {
                            if (([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag - 1) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 1) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 6) {
                            if (([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag + 7) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 8) {
                            if (([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                    }
                }
            }
            // middle
            else{
                // random square around player that is not a square next to the computer because its already blocked by it
                if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag && box.tag != computer.tag - 8 &&
                    box.tag != computer.tag - 7 && box.tag != computer.tag - 6 && box.tag != computer.tag - 1 &&
                    box.tag != computer.tag + 1 && box.tag != computer.tag + 6 && box.tag != computer.tag + 7 &&
                    box.tag != computer.tag + 8) {
                    
                    // left bound
                    if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
                        // for all boxes that are around the player add them to boxes to delete
                        if (box.tag == player.tag + 1 || box.tag == player.tag + 8 || box.tag == player.tag - 6) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // right bound
                    else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
                        // for all boxes that are around the player add them to boxes to delete
                        if (box.tag == player.tag - 1 || box.tag == player.tag + 6 || box.tag == player.tag - 8) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // top
                    else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5){
                        if (box.tag == player.tag + 6 || box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // bottom
                    else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47){
                        if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                            [objectsComputerCanDelete addObject:box];
                        }
                    }
                    // middle
                    else{
                        if (box.tag == player.tag - 8) {
                            if (([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag - 7) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag - 6) {
                            if (([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag - 1) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 1) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 6) {
                            if (([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag + 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                        if (box.tag == player.tag + 7) {
                            if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        if (box.tag == player.tag + 8) {
                            if (([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 2] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor])) ||
                                ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]) &&
                                 [[backgroundObjects objectAtIndex:box.tag - 14] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor whiteColor]))) {
                                    [objectsComputerCanDelete addObject:box];
                                }
                        }
                    }
                }
            }
        }
        
        // deletes a box around a player that builds onto one
        if (objectsComputerCanDelete.count == 0) {
            
            for (int i = 0; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                //left
                if (computer.tag == 0 || computer.tag == 7 || computer.tag == 14 || computer.tag == 21 || computer.tag == 28 || computer.tag == 35 || computer.tag == 42) {
                    // random square around player that is not a square next to the computer because its already blocked by it
                    if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag &&
                        box.tag != computer.tag - 7 && box.tag != computer.tag - 6 &&
                        box.tag != computer.tag + 1 && box.tag != computer.tag + 7 &&
                        box.tag != computer.tag + 8) {
                        
                        //top left
                        if (player.tag == 0) {
                            if (box.tag == player.tag + 1 || box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //top right
                        else if (player.tag == 6) {
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 || box.tag == player.tag + 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //bottom left
                        else if (player.tag == 42) {
                            if (box.tag == player.tag - 7 || box.tag == player.tag - 6 || box.tag == player.tag + 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //botom right
                        else if (player.tag == 48) {
                            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        
                        // left bound
                        else if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag + 1 || box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // right bound
                        else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // top
                        else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5){
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 ||
                                box.tag == player.tag + 6 || box.tag == player.tag + 7 ||
                                box.tag == player.tag + 8) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            
                        }
                        // bottom
                        else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47){
                            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 ||
                                box.tag == player.tag - 6 || box.tag == player.tag - 1 ||
                                box.tag == player.tag + 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // middle
                        else{
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                                if (box.tag == player.tag - 8) {
                                    if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 7) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 6) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 1) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 1) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 6) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 7) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 8) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                            }
                        }
                    }
                }
                // right
                else if (computer.tag == 6 || computer.tag == 13 || computer.tag == 20 || computer.tag == 27 || computer.tag == 34 ||
                         computer.tag == 41 || computer.tag == 48) {
                    // random square around player that is not a square next to the computer because its already blocked by it
                    if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag && box.tag != computer.tag - 8 &&
                        box.tag != computer.tag - 7 && box.tag != computer.tag + 1 && box.tag != computer.tag + 6 &&
                        box.tag != computer.tag + 7) {
                        
                        //top left
                        if (player.tag == 0) {
                            if (box.tag == player.tag + 1 || box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //top right
                        else if (player.tag == 6) {
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 || box.tag == player.tag + 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //bottom left
                        else if (player.tag == 42) {
                            if (box.tag == player.tag - 7 || box.tag == player.tag - 6 || box.tag == player.tag + 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //botom right
                        else if (player.tag == 48) {
                            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        
                        // left bound
                        else if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag + 1 || box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // right bound
                        else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // top
                        else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5){
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 ||
                                box.tag == player.tag + 6 || box.tag == player.tag + 7 ||
                                box.tag == player.tag + 8) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            
                        }
                        // bottom
                        else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47){
                            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 ||
                                box.tag == player.tag - 6 || box.tag == player.tag - 1 ||
                                box.tag == player.tag + 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // middle
                        else{
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                                if (box.tag == player.tag - 8) {
                                    if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 7) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 6) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 1) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 1) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 6) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 7) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 8) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                            }
                        }
                    }
                }
                // middle
                else{
                    // random square around player that is not a square next to the computer because its already blocked by it
                    if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag && box.tag != computer.tag - 8 &&
                        box.tag != computer.tag - 7 && box.tag != computer.tag - 6 && box.tag != computer.tag - 1 &&
                        box.tag != computer.tag + 1 && box.tag != computer.tag + 6 && box.tag != computer.tag + 7 &&
                        box.tag != computer.tag + 8) {
                        
                        //top left
                        if (player.tag == 0) {
                            if (box.tag == player.tag + 1 || box.tag == player.tag + 7 || box.tag == player.tag + 8) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //top right
                        else if (player.tag == 6) {
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 || box.tag == player.tag + 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //bottom left
                        else if (player.tag == 42) {
                            if (box.tag == player.tag - 7 || box.tag == player.tag - 6 || box.tag == player.tag + 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        //botom right
                        else if (player.tag == 48) {
                            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 || box.tag == player.tag - 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        
                        // left bound
                        else if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag + 1 || box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // right bound
                        else if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // top
                        else if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5){
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 ||
                                box.tag == player.tag + 6 || box.tag == player.tag + 7 ||
                                box.tag == player.tag + 8) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            
                        }
                        // bottom
                        else if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47){
                            if (box.tag == player.tag - 8 || box.tag == player.tag - 7 ||
                                box.tag == player.tag - 6 || box.tag == player.tag - 1 ||
                                box.tag == player.tag + 1) {
                                [objectsComputerCanDelete addObject:box];
                            }
                            if (box.tag == player.tag - 8) {
                                if ([[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 7) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 6) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                    [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag - 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                            if (box.tag == player.tag + 1) {
                                if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                    [objectsComputerCanDelete removeObject:box];
                                }
                            }
                        }
                        // middle
                        else{
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                                if (box.tag == player.tag - 8) {
                                    if ([[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 7) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 6) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag - 1) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 1) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 6) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 7) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                                if (box.tag == player.tag + 8) {
                                    if ([[backgroundObjects objectAtIndex:box.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor]) &&
                                        [[backgroundObjects objectAtIndex:box.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                                        [objectsComputerCanDelete removeObject:box];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // if there are no white spaces around player - pick a random one around player
        if (objectsComputerCanDelete.count == 0) {
            
            // deletes random box around player
            for (int i = 0; i<backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                //left
                if (computer.tag == 0 || computer.tag == 7 || computer.tag == 14 || computer.tag == 21 || computer.tag == 28 || computer.tag == 35 || computer.tag == 42) {
                    // random square around player that is not a square next to the computer because its already blocked by it
                    if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag &&
                        box.tag != computer.tag - 7 && box.tag != computer.tag - 6 &&
                        box.tag != computer.tag + 1 && box.tag != computer.tag + 7 &&
                        box.tag != computer.tag + 8) {
                        
                        // left bound
                        if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 ||
                            player.tag == 35 || player.tag == 42) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag + 1 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        
                        // right bound
                        else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 ||
                                 player.tag == 41 || player.tag == 48) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        else{
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                    }
                }
                // right
                else if (computer.tag == 6 || computer.tag == 13 || computer.tag == 20 || computer.tag == 27 ||
                         computer.tag == 34 || computer.tag == 41 || computer.tag == 48) {
                    // random square around player that is not a square next to the computer because its already blocked by it
                    if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag && box.tag != computer.tag - 8 &&
                        box.tag != computer.tag - 7 && box.tag != computer.tag - 1 && box.tag != computer.tag + 6 &&
                        box.tag != computer.tag + 7) {
                        
                        // left bound
                        if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 ||
                            player.tag == 35 || player.tag == 42) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag + 1 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        
                        // right bound
                        else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 ||
                                 player.tag == 41 || player.tag == 48) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        else{
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                    }
                }
                // middle
                else{
                    // random square around player that is not a square next to the computer because its already blocked by it
                    if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag && box.tag != computer.tag - 8 &&
                        box.tag != computer.tag - 7 && box.tag != computer.tag - 6 && box.tag != computer.tag - 1 &&
                        box.tag != computer.tag + 1 && box.tag != computer.tag + 6 && box.tag != computer.tag + 7 &&
                        box.tag != computer.tag + 8) {
                        
                        // left bound
                        if (player.tag == 0 || player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 ||
                            player.tag == 35 || player.tag == 42) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag + 1 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        
                        // right bound
                        else if (player.tag == 6 || player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 ||
                                 player.tag == 41 || player.tag == 48) {
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                        else{
                            // for all boxes that are around the player add them to boxes to delete
                            if (box.tag == player.tag - 1 || box.tag == player.tag + 1 || box.tag == player.tag + 6 ||
                                box.tag == player.tag + 7 || box.tag == player.tag + 8 || box.tag == player.tag - 8 ||
                                box.tag == player.tag - 7 || box.tag == player.tag - 6) {
                                [objectsComputerCanDelete addObject:box];
                            }
                        }
                    }
                }
            }
        }
        
        // if no objects were added - completely random one
        if (objectsComputerCanDelete.count == 0) {
            
            for (int i = 0; i <backgroundObjects.count; i++) {
                UIImageView *box = [backgroundObjects objectAtIndex:i];
                
                // pick a random one that is blue and not the player's
                if (box.backgroundColor != [UIColor whiteColor] && box.tag != player.tag) {
                    [objectsComputerCanDelete addObject:box];
                }
            }
        }
    }
    
    // randomly select a box around player and remove the box
    int randBox2Destroy = arc4random() % objectsComputerCanDelete.count;
    
    UIImageView *box = [objectsComputerCanDelete objectAtIndex:randBox2Destroy];
    box.backgroundColor = [UIColor whiteColor];
    
    // clear for next turn
    [objectsComputerCanDelete removeAllObjects];
    
        // update choises for other player
        computerLabel.text = @"Computer";
        playerLabel.text = @"Player: Move";
        playerState = 1;
        [self updateChoises];
    
}

// AI Helper Methods

// deletes all the stupid places
-(void)removeStupidMoves{
    
    // use this
    NSMutableArray *boxesToRemoveFromObjectsNext2Computer = [[NSMutableArray alloc] init];
    // dont remove from the array in the for loop!
    // create another array and remove similar objects
    
    for (int i = 0; i<objectsNext2Computer.count; i++) {
        UIImageView *boxNextToComputer = [objectsNext2Computer objectAtIndex:i];
        
        // corner
        // top left
        if (boxNextToComputer.tag == 0) {
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // top right
        else if (boxNextToComputer.tag == 6) {
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // bottom left
        else if (boxNextToComputer.tag == 42) {
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // bottom right
        else if (boxNextToComputer.tag == 48) {
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // top
        else if (boxNextToComputer.tag == 1 || boxNextToComputer.tag == 2 || boxNextToComputer.tag == 3 ||
                 boxNextToComputer.tag == 4 || boxNextToComputer.tag == 5){
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // bottom
        else if (boxNextToComputer.tag == 43 || boxNextToComputer.tag == 44 || boxNextToComputer.tag == 45 ||
                 boxNextToComputer.tag == 46 || boxNextToComputer.tag == 47){
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // left
        else if (boxNextToComputer.tag == 7 || boxNextToComputer.tag == 14 || boxNextToComputer.tag == 21 ||
                 boxNextToComputer.tag == 28 || boxNextToComputer.tag == 35){
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // right
        else if (boxNextToComputer.tag == 13 || boxNextToComputer.tag == 20 || boxNextToComputer.tag == 27 ||
                 boxNextToComputer.tag == 34 || boxNextToComputer.tag == 41){
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
        // middle
        else {
            int a = 0;
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                a++;
            }
            // if only one square is next to a possible move DON'T go there
            if (a == 1) {
                // [objectsNext2Computer removeObjectAtIndex:i];
                [boxesToRemoveFromObjectsNext2Computer addObject:boxNextToComputer];
            }
        }
    }
    
    NSLog(@"objects: %i", objectsNext2Computer.count);
    NSLog(@"toRemove: %i", boxesToRemoveFromObjectsNext2Computer.count);
    
    // remove objects
    [objectsNext2Computer removeObjectsInArray:boxesToRemoveFromObjectsNext2Computer];
    
    // check if you removed all of the objects
    if (objectsNext2Computer.count == 0) {
        // re-add them
        [self updateChoises];
        
        // check again
        for (int i = 0; i<objectsNext2Computer.count; i++) {
            UIImageView *boxNextToComputer = [objectsNext2Computer objectAtIndex:i];
            
            // corner
            // top left
            if (boxNextToComputer.tag == 0) {
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // top right
            else if (boxNextToComputer.tag == 6) {
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // bottom left
            else if (boxNextToComputer.tag == 42) {
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // bottom right
            else if (boxNextToComputer.tag == 48) {
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // top
            else if (boxNextToComputer.tag == 1 || boxNextToComputer.tag == 2 || boxNextToComputer.tag == 3 ||
                     boxNextToComputer.tag == 4 || boxNextToComputer.tag == 5){
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // bottom
            else if (boxNextToComputer.tag == 43 || boxNextToComputer.tag == 44 || boxNextToComputer.tag == 45 ||
                     boxNextToComputer.tag == 46 || boxNextToComputer.tag == 47){
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // left
            else if (boxNextToComputer.tag == 7 || boxNextToComputer.tag == 14 || boxNextToComputer.tag == 21 ||
                     boxNextToComputer.tag == 28 || boxNextToComputer.tag == 35){
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // right
            else if (boxNextToComputer.tag == 13 || boxNextToComputer.tag == 20 || boxNextToComputer.tag == 27 ||
                     boxNextToComputer.tag == 34 || boxNextToComputer.tag == 41){
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            // middle
            else {
                int a = 0;
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag - 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 1] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 6] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 7] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                if ([[backgroundObjects objectAtIndex:boxNextToComputer.tag + 8] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor blueColor])) {
                    a++;
                }
                // if only one square is next to a possible move DON'T go there
                if (a == 1) {
                    [objectsNext2Computer removeObjectAtIndex:i];
                }
            }
            
        }
    }
    
    // check if you removed all of the objects
    if (objectsNext2Computer.count == 0) {
        [self updateChoises];
    }
    
}

// usable?
-(int)numOfMovableBoxesSurroundingComputer{
    // player one lost
    // corners first (top left)
    
    NSMutableArray *movablePlaces = [[NSMutableArray alloc] init];
    
    if (computer.tag == 0) {
        if ([[backgroundObjects objectAtIndex:(computer.tag + 1)] backgroundColor] == (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            [movablePlaces addObject:[backgroundObjects objectAtIndex:(computer.tag + 1)]];
        }
        if ([[backgroundObjects objectAtIndex:(computer.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            [movablePlaces addObject:[backgroundObjects objectAtIndex:(computer.tag + 7)]];
        }
        if ([[backgroundObjects objectAtIndex:(computer.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            [movablePlaces addObject:[backgroundObjects objectAtIndex:(computer.tag + 8)]];
        }
    }
    /*
    // top right
    if (player.tag == 6) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // bottom left
    if (player.tag == 42) {
        if ([[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    // bottom right
    if (player.tag == 48) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // left bound
    if (player.tag == 7 || player.tag == 14 || player.tag == 21 || player.tag == 28 || player.tag == 35) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You Lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // right bound
    if (player.tag == 13 || player.tag == 20 || player.tag == 27 || player.tag == 34 || player.tag == 41) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You Lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // top
    if (player.tag == 1 || player.tag == 2 || player.tag == 3 || player.tag == 4 || player.tag == 5) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You Lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
    
    // bottom
    if (player.tag == 43 || player.tag == 44 || player.tag == 45 || player.tag == 46 || player.tag == 47) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You Lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
            
            // here
            NSLog(@"yes 2");
        }
    }
    
    // middle
    if(player.tag == 8 || player.tag == 9 || player.tag == 10 || player.tag == 11 || player.tag == 12 ||
       player.tag == 15 || player.tag == 16 || player.tag == 17 || player.tag == 18 || player.tag == 19 ||
       player.tag == 22 || player.tag == 23 || player.tag == 24 || player.tag == 25 || player.tag == 26 ||
       player.tag == 29 || player.tag == 30 || player.tag == 31 || player.tag == 32 || player.tag == 33 ||
       player.tag == 36 || player.tag == 37 || player.tag == 38 || player.tag == 39 || player.tag == 40) {
        if ([[backgroundObjects objectAtIndex:(player.tag - 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag - 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 1)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 6)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 7)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor]) &&
            [[backgroundObjects objectAtIndex:(player.tag + 8)] backgroundColor] != (__bridge CGColorRef _Nullable)([UIColor yellowColor])) {
            playerLabel.text = @"You Lost!";
            computerLabel.text = @"You Won!";
            
            // stop game loop
            playerState = 0;
            
            //show reset button
            resetButton.hidden = NO;
        }
    }
     */
    
    return movablePlaces.count;
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
    computer.frame = [[backgroundObjects objectAtIndex:3] frame];
    computer.tag = 3;
    
    // reset labels / buttons
    playerLabel.text = @"Player: Move";
    computerLabel.text = @"Computer";
    resetButton.hidden = YES;
    
    // reset game state
    playerState = 1;
    
    // start game
    [self updateChoises];
}

@end
