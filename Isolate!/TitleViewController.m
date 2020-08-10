//
//  TitleViewController.m
//  Isolate!
//
//  Created by Aaron on 6/20/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import "TitleViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface TitleViewController ()

@end

@implementation TitleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    boxArray = [[NSMutableArray alloc] init];
    
    // create boxes
    if (IS_IPHONE_5) {
        int x = 0;
        
        // create background boxes
        for (int a = 0; a < 19; a++) {
            for (int b = 0; b < 11; b++) {
                UIImageView *box = [[UIImageView alloc] initWithFrame:CGRectMake(30*b, 30*a, 20, 20)];
                
                int rand = arc4random() % 14;
                switch (rand) {
                    case 0:
                        box.backgroundColor = [UIColor blackColor];
                        break;
                    case 1:
                        box.backgroundColor = [UIColor blueColor];
                        break;
                    case 2:
                        box.backgroundColor = [UIColor brownColor];
                        break;
                    case 3:
                        box.backgroundColor = [UIColor cyanColor];
                        break;
                    case 4:
                        box.backgroundColor = [UIColor darkGrayColor];
                        break;
                    case 5:
                        box.backgroundColor = [UIColor grayColor];
                        break;
                    case 6:
                        box.backgroundColor = [UIColor greenColor];
                        break;
                    case 7:
                        box.backgroundColor = [UIColor lightGrayColor];
                        break;
                    case 8:
                        box.backgroundColor = [UIColor magentaColor];
                        break;
                    case 9:
                        box.backgroundColor = [UIColor orangeColor];
                        break;
                    case 10:
                        box.backgroundColor = [UIColor purpleColor];
                        break;
                    case 11:
                        box.backgroundColor = [UIColor redColor];
                        break;
                    case 12:
                        box.backgroundColor = [UIColor whiteColor];
                        break;
                    case 13:
                        box.backgroundColor = [UIColor yellowColor];
                }
                
                box.tag = x;
                x++;
                
                [box setUserInteractionEnabled:YES];
                [self.view addSubview:box];
                [boxArray addObject:box];
                
            }
        }
        
        x = 0;
    }
    else{
        
        int x = 0;
        
        // create background boxes
        for (int a = 0; a < 16; a++) {
            for (int b = 0; b < 11; b++) {
                UIImageView *box = [[UIImageView alloc] initWithFrame:CGRectMake(30*b, 30*a, 20, 20)];
                
                int rand = arc4random() % 14;
                switch (rand) {
                    case 0:
                        box.backgroundColor = [UIColor blackColor];
                        break;
                    case 1:
                        box.backgroundColor = [UIColor blueColor];
                        break;
                    case 2:
                        box.backgroundColor = [UIColor brownColor];
                        break;
                    case 3:
                        box.backgroundColor = [UIColor cyanColor];
                        break;
                    case 4:
                        box.backgroundColor = [UIColor darkGrayColor];
                        break;
                    case 5:
                        box.backgroundColor = [UIColor grayColor];
                        break;
                    case 6:
                        box.backgroundColor = [UIColor greenColor];
                        break;
                    case 7:
                        box.backgroundColor = [UIColor lightGrayColor];
                        break;
                    case 8:
                        box.backgroundColor = [UIColor magentaColor];
                        break;
                    case 9:
                        box.backgroundColor = [UIColor orangeColor];
                        break;
                    case 10:
                        box.backgroundColor = [UIColor purpleColor];
                        break;
                    case 11:
                        box.backgroundColor = [UIColor redColor];
                        break;
                    case 12:
                        box.backgroundColor = [UIColor whiteColor];
                        break;
                    case 13:
                        box.backgroundColor = [UIColor yellowColor];
                }
                
                box.tag = x;
                x++;
                
                [box setUserInteractionEnabled:YES];
                [self.view addSubview:box];
                [boxArray addObject:box];
                
            }
        }
        
        x = 0;
    }
    
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:playButton];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(animateSquareToPlace) userInfo:nil repeats:YES];
     
    isZoomedIn = NO;
    
    squareNumber.hidden = YES;
    squareNumberTitle.hidden = YES;
    catagory.hidden = YES;
    catagoryTitle.hidden = YES;
    mainText.hidden = YES;
    
    canTouchASquare = YES;
}

// fix!
-(void)animateSquareToPlace{
    
    // need to change! doesn't work!
    
    int randBox = arc4random() % boxArray.count;
    UIImageView *box = [boxArray objectAtIndex:randBox];
    
    CGRect rect;
    
    // corners
    if (box.frame.origin.x == 0 && box.frame.origin.y == 0) {
        int direction = arc4random() % 2;
        
        // down
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y + 30, 20, 20);
        }
        // right
        else  {
            rect  = CGRectMake(box.frame.origin.x + 30, box.frame.origin.y, 20, 20);
        }
    }
    else if (box.frame.origin.x == 300 && box.frame.origin.y == 0){
        int direction = arc4random() % 2;
        
        // down
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y + 30, 20, 20);
        }
        // left
        else  {
            rect  = CGRectMake(box.frame.origin.x - 30, box.frame.origin.y, 20, 20);
        }
    }
    else if (box.frame.origin.x == 0 && box.frame.origin.y == 450){
        int direction = arc4random() % 2;
        
        // up
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y - 30, 20, 20);
        }
        // right
        else  {
            rect  = CGRectMake(box.frame.origin.x + 30, box.frame.origin.y, 20, 20);
        }
        
    }
    else if(box.frame.origin.x == 300 && box.frame.origin.y == 450){
        int direction = arc4random() % 2;
        
        // up
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y - 30, 20, 20);
        }
        // left
        else  {
            rect  = CGRectMake(box.frame.origin.x - 30, box.frame.origin.y, 20, 20);
        }
    }
    // right
    else if (box.frame.origin.x == 300) {
        int direction = arc4random() % 3;
        
        // up
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y - 30, 20, 20);
        }
        // down
        else if (direction == 1) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y + 30, 20, 20);
        }
        // left
        else{
            rect  = CGRectMake(box.frame.origin.x - 30, box.frame.origin.y, 20, 20);
        }
    }
    // left
    else if(box.frame.origin.x == 0){
        int direction = arc4random() % 3;
        
        // up
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y - 30, 20, 20);
        }
        // down
        else if (direction == 1) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y + 30, 20, 20);
        }
        // right
        else{
            rect  = CGRectMake(box.frame.origin.x + 30, box.frame.origin.y, 20, 20);
        }
    }
    // up
    else if(box.frame.origin.y == 0){
        int direction = arc4random() % 3;
        
        // down
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y + 30, 20, 20);
        }
        // left
        else if (direction == 1) {
            rect  = CGRectMake(box.frame.origin.x - 30, box.frame.origin.y, 20, 20);
        }
        // right
        else{
            rect  = CGRectMake(box.frame.origin.x + 30, box.frame.origin.y, 20, 20);
        }
    }
    // down
    else if(box.frame.origin.y == 450){
        int direction = arc4random() % 3;
        
        // up
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y - 30, 20, 20);
        }
        // left
        else if (direction == 1) {
            rect  = CGRectMake(box.frame.origin.x - 30, box.frame.origin.y, 20, 20);
        }
        // right
        else{
            rect  = CGRectMake(box.frame.origin.x + 30, box.frame.origin.y, 20, 20);
        }
    }
    // middle
    else{
        int direction = arc4random() % 4;
        
        // down
        if (direction == 0) {
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y + 30, 20, 20);
        }
        // left
        else if (direction == 1) {
            rect  = CGRectMake(box.frame.origin.x - 30, box.frame.origin.y, 20, 20);
        }
        // right
        else if (direction == 2){
            rect  = CGRectMake(box.frame.origin.x + 30, box.frame.origin.y, 20, 20);
        }
        // up
        else{
            rect  = CGRectMake(box.frame.origin.x, box.frame.origin.y - 30, 20, 20);
        }
    }
    
    
    // random color
    UIColor *color;
    
    int rand = arc4random() % 14;
    switch (rand) {
        case 0:
            color = [UIColor blackColor];
            break;
        case 1:
            color = [UIColor blueColor];
            break;
        case 2:
            color = [UIColor brownColor];
            break;
        case 3:
            color = [UIColor cyanColor];
            break;
        case 4:
            color = [UIColor darkGrayColor];
            break;
        case 5:
            color = [UIColor grayColor];
            break;
        case 6:
            color = [UIColor greenColor];
            break;
        case 7:
            color = [UIColor lightGrayColor];
            break;
        case 8:
            color = [UIColor magentaColor];
            break;
        case 9:
            color = [UIColor orangeColor];
            break;
        case 10:
            color = [UIColor purpleColor];
            break;
        case 11:
            color = [UIColor redColor];
            break;
        case 12:
            color = [UIColor whiteColor];
            break;
        case 13:
            color = [UIColor yellowColor];
    }
    
    // animate
    [UIView animateWithDuration:1.0f animations:^{
        box.frame = rect;
        box.backgroundColor = color;
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        
    if (isZoomedIn) {
            UIImageView *box = [boxArray objectAtIndex:boxNumber];
            
            [UIView animateWithDuration:1.0f animations:^{
                box.frame = lastPlace;
                
                squareNumber.alpha = 0;
                squareNumberTitle.alpha = 0;
                catagory.alpha = 0;
                catagoryTitle.alpha = 0;
                mainText.alpha = 0;
                
            } completion:^(BOOL complete){
                squareNumber.hidden = YES;
                squareNumberTitle.hidden = YES;
                catagory.hidden = YES;
                catagoryTitle.hidden = YES;
                mainText.hidden = YES;
                
                canTouchASquare = YES;
            }];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(animateSquareToPlace) userInfo:nil repeats:YES];
            
            isZoomedIn = NO;
        }
    else{
        if (canTouchASquare) {
            NSLog(@"touch");
        
            UITouch *aTouch = [touches anyObject];
            CGPoint location = [aTouch locationInView:self.view];
        
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i< boxArray.count; i++) {
                UIImageView *box = [boxArray objectAtIndex:i];
            
                if ([box pointInside: [self.view convertPoint:location toView:box] withEvent:event]) {
                    [array addObject:box];
                }
            }
            
            // this is the main part
            // only the top square will be zoomed in on
            if (array.count) {
                NSMutableArray *objectsToDelete = [[NSMutableArray alloc] init];
                if (array.count > 1) {
                    
                    for (int i = 0; i < array.count; i++) {
                        UIImageView *object = [array objectAtIndex:i];
                        
                        if (i != array.count - 1) {
                            [objectsToDelete addObject:object];
                        }
                    }
                    
                    [array removeObjectsInArray:objectsToDelete];
                    
                    UIImageView *box = [array objectAtIndex:0];
                    NSLog(@"Hit square %i", box.tag);
                    NSLog(@"Frame : %f,%f", box.frame.origin.x, box.frame.origin.y);
                    
                    // stops from tapping on other squares
                    canTouchASquare = NO;
                    
                    lastPlace = box.frame;
                    boxNumber = box.tag;
                    
                    squareNumber.alpha = 0;
                    squareNumberTitle.alpha = 0;
                    catagory.alpha = 0;
                    catagoryTitle.alpha = 0;
                    mainText.alpha = 0;
                    
                    // check if background is black
                    if (box.backgroundColor == [UIColor blackColor]) {
                        squareNumber.textColor = [UIColor whiteColor];
                        squareNumberTitle.textColor = [UIColor whiteColor];
                        catagory.textColor = [UIColor whiteColor];
                        catagoryTitle.textColor = [UIColor whiteColor];
                        mainText.textColor = [UIColor whiteColor];
                    }
                    else{
                        squareNumber.textColor = [UIColor blackColor];
                        squareNumberTitle.textColor = [UIColor blackColor];
                        catagory.textColor = [UIColor blackColor];
                        catagoryTitle.textColor = [UIColor blackColor];
                        mainText.textColor = [UIColor blackColor];
                    }
                    
                    [timer invalidate];
                    [self.view addSubview:box];
                    [UIView animateWithDuration:1.0f animations:^{
                        
                        if (IS_IPHONE_5) {
                            box.frame = CGRectMake(0, 0, 320, 568);
                        }
                        else{
                            box.frame = CGRectMake(0, 0, 320, 480);
                        }
                        
                    } completion:^(BOOL finished){
                        
                        [self.view addSubview:squareNumber];
                        [self.view addSubview:squareNumberTitle];
                        [self.view addSubview:catagory];
                        [self.view addSubview:catagoryTitle];
                        [self.view addSubview:mainText];
                        
                        // set labels here
                        squareNumber.text = [NSString stringWithFormat:@"#%i", box.tag];
                        mainText.text = [self stringForSquare:box.tag];
                        catagory.text = [self catagoryForSquare:box.tag];
                        
                        [UIView animateWithDuration:1.0f animations:^{
                            squareNumber.hidden = NO;
                            squareNumberTitle.hidden = NO;
                            catagory.hidden = NO;
                            catagoryTitle.hidden = NO;
                            mainText.hidden = NO;
                            
                            squareNumber.alpha = 1;
                            squareNumberTitle.alpha = 1;
                            catagory.alpha = 1;
                            catagoryTitle.alpha = 1;
                            mainText.alpha = 1;
                        } completion:^(BOOL isfinished){
                            isZoomedIn = YES;
                        }];
                    }];
                }
                else{
                    UIImageView *box = [array objectAtIndex:0];
                    NSLog(@"Hit square %i", box.tag);
                    NSLog(@"Frame : %f,%f", box.frame.origin.x, box.frame.origin.y);
                    
                    // stops from tapping on other squares
                    canTouchASquare = NO;
                    
                    lastPlace = box.frame;
                    boxNumber = box.tag;
                    
                    squareNumber.alpha = 0;
                    squareNumberTitle.alpha = 0;
                    catagory.alpha = 0;
                    catagoryTitle.alpha = 0;
                    mainText.alpha = 0;
                    
                    // check if background is black
                    if (box.backgroundColor == [UIColor blackColor]) {
                        squareNumber.textColor = [UIColor whiteColor];
                        squareNumberTitle.textColor = [UIColor whiteColor];
                        catagory.textColor = [UIColor whiteColor];
                        catagoryTitle.textColor = [UIColor whiteColor];
                        mainText.textColor = [UIColor whiteColor];
                    }
                    else{
                        squareNumber.textColor = [UIColor blackColor];
                        squareNumberTitle.textColor = [UIColor blackColor];
                        catagory.textColor = [UIColor blackColor];
                        catagoryTitle.textColor = [UIColor blackColor];
                        mainText.textColor = [UIColor blackColor];
                    }
                    
                    [timer invalidate];
                    [self.view addSubview:box];
                    [UIView animateWithDuration:1.0f animations:^{
                        
                        if (IS_IPHONE_5) {
                            box.frame = CGRectMake(0, 0, 320, 568);
                        }
                        else{
                            box.frame = CGRectMake(0, 0, 320, 480);
                        }
                        
                    } completion:^(BOOL finished){
                        
                        [self.view addSubview:squareNumber];
                        [self.view addSubview:squareNumberTitle];
                        [self.view addSubview:catagory];
                        [self.view addSubview:catagoryTitle];
                        [self.view addSubview:mainText];
                        
                        // set labels here
                        squareNumber.text = [NSString stringWithFormat:@"#%i", box.tag];
                        mainText.text = [self stringForSquare:box.tag];
                        catagory.text = [self catagoryForSquare:box.tag];
                        
                        [UIView animateWithDuration:1.0f animations:^{
                            squareNumber.hidden = NO;
                            squareNumberTitle.hidden = NO;
                            catagory.hidden = NO;
                            catagoryTitle.hidden = NO;
                            mainText.hidden = NO;
                            
                            squareNumber.alpha = 1;
                            squareNumberTitle.alpha = 1;
                            catagory.alpha = 1;
                            catagoryTitle.alpha = 1;
                            mainText.alpha = 1;
                        } completion:^(BOOL isfinished){
                            isZoomedIn = YES;
                        }];
                    }];
                }
            }
        }
    }
}

-(NSString*)stringForSquare:(int)squareTag{
    switch (squareTag) {
        case 0:
            return @"YAAAAAAYYYYY!!!!!! You're probably thinking 'this is stupid' why isn't this number 1? Good question! In the programming world everything starts with zero. It's just easier to keep track of things. For example the square you just tapped on is in an array(along with all the other squares) and it is at the zeroth index.";
        case 1:
            return @"The 1 and only! YOU! You are ONE of a kind! The ONLY ONE that has done and experienced what you have done! ONE can change the world!";
        case 2:
            return @"There are 2 things that you can do while playing this game. You can play it normally or while underwater weaving a basket! I wonder how that would work out... If you have an otterbox WELL, but otherwise you will be playing imaginary games on your broken phone. Ya water and technology are TWO things that DONT mix. What about submarines... hmmm... good point...";
        case 3:
            return @"HAHAHAHHAHAHAHAHAHAHAHHAHHAHAHHAHAHAHHAHAHAH. What's so funny????????????? You know. No I don't. Ya... you do. Dude, seriously, but ya, what's going on. Ya. Ya. No. Yep. Why. Bye. Pie. I'm hungry. No. Yep. I want food. That's what's funny. That's not funny dude. You're right I'm WAYYYYYY out of food line!!! Dude we should go somewhere else. We have been waiting in this line hours. We're at home Bob. I was in front of you to get milk from the fridge. That doesn't count as line.";
        case 4:
            return @"If you could one have 4 things in the world, and NOTHING else, what would you have? Stop and think. Thinking..... not reading this. Stop reading and think. OK, 4 trillon dollars is out of the question. Food generator is out. Spaceship, cool, but out. I would choose an iPhone 55(cause you know they won't run out of battery), a toothbrush 2000x, a flyBoard(google it), and a magic top hat! Comment what you want at http://sequesterapp.blogspot.com under the 4 Items selection";
        case 5:
            return @"So-called white chocolate isn't chocolate in the technical sense — it is comprised of cocoa butter, sugar, and milk, but no actual chocolate.";
        case 6:
            return @"Only one U.S. coin — the zinc-coated steel penny produced during World War II — can be picked up by a magnet. I'm going to find IT!!!!!";
        case 7:
            return @"Billiards was once a lawn game played outdoors, which is why today’s pool tables have a green felt cover.";
        case 8:
            return @"Yay!!!! You clicked on ME! You know I'm the best square. If you didn't, now you know! You know why I'm the best well............................................................................................................................................ I'm not sure myself.";
        case 9:
            return @"Help me! I'm trapped in this square! Get me out by out by shaking you phone! Harder, HARDERRRRRR, ITS NOT WORKING!!!!! You probably didn't try...... Thanks though if you did. There is actually is a key in square 2000. Tap on that one and then back here and you can set me FREEEEEEE!!!!!";
        case 10:
            return @"Why did you tap on me.... YAAAWWWWNNNN. I was in a middle of a nap, thank you very much! I'm ready to face you in sequester! This time I'll beat you. I know I will! I have to! You know I'm a computer right! I'm an evolving computer! I'm better than my programmer! MMMMMAAAAHHHHAHAHAHAHAHHAHAHHA!";
        case 11:
            return @"Paint, Sky, Love, Hate, Joy, PIZZA, pillows and marshmellows, pie, cars, jumping, going, going, going, up, to the pie, under, chair, bowl, sandels, beach, water, coral, shark, lobster, jelly, jelly, fish, bird, feet, legs, book, 4:55pm, sunday, in kitchen, statue, cool, right, wrong, left, right, listen, point, stop, THE END";
        case 12:
            return @"10100101000100001001010010001011110101010101010100101001010101001011111111111111111010111010101111110100000101010110000010101010111100011011101010001110101100100001011101010100100100010101010101111010101011010101000000111010100100101001011010";
        case 13:
            return @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id ";
        case 14:
            return @"I Wen to sckool for 120.246 yearsss! I alquays got z's en nevr did anythin B-A-D. I con speller E-D-U-C-M-A-T-E-D with ez. Arn't i be so kool, ad skmart! I be in bed all day livin. I talc wit strut y mojo. D-0-G. Go to sckoll kidz it make to skmart en kool! Im heppy! :-D ohh yar, i ye draw to!";
        case 15:
            return @"Do to others what you want upon you.";
        case 16:
            return @"The wise watch their step and avoid evil; Fools are head strong and reckless.";
        case 17:
            return @"Hard work always pays off; mere talk puts no bread on the table.";
        case 18:
            return @"Kind words heal and help; cutting words wound and maim.";
        case 19:
            return @"Hot tempers start fights; a calm, cool spirit keeps the peace.";
        case 20:
            return @"Far better to be right and poor than to be wrong and rich!";
        case 21:
            return @"Friends come and go, but a true friend sticks by you like family.";
        case 22:
            return @"A group of jellyfish is called a 'Bloom' of jellyfish";
        case 23:
            return @"Refrigerator make themselves cold by sucking out the heat from inside. The absence of heat is cold.";
        case 24:
            return @"On average each house has two bathrooms";
        case 25:
            return @"A cool alternative to photoshop is GIMP. And it's FREE!";
        case 26:
            return @"I programmed this app using XCode. On my macbook pro. The text you are reading is in a method that returns a string, depending on what number square you have tapped on! Now you know :)";
        case 27:
            return @"What is the square-root of -1? Think about it. Thinking. Wondering. Braining. Stumbed.... unless you know it... There is no answer. It's impossible. Mathamaticians use the letter 'i' to represent this wierd phenomenon.";
        case 28:
            return @"Try to put the days of the week together in alphapetical order! Then say a random color. Then a random tool. Did you say 'red hammer'? Try it on your friends!";
        case 29:
            return @"More monopoly money has been printed than all the money in the United States!";
        case 30:
            return @"Made you read this!";
        case 31:
            return @"The name for the tip of the very end of a shoelace is called an 'aglet'";
        case 32:
            return @"Fortune cookies were made america!";
        case 33:
            return @"This square is special! Do you know why? You do? ok. I won't tell you.";
        case 34:
            return @"All the other squares say I'm the fattest one... But we're all the same, I say. If you tap on me though, I get even bigger! Please don't make me fatter!";
        case 35:
            return @"All the squares are in order, until they start moving. The top left most square is 0, then left to right it goes, 1,2,3,4,5,6, until it reaches the end of the screen, then it goes down a line, 7,8,9,10,11!";
        case 36:
            return @"Picasso named his dog 'lump'";
        case 37:
            return @"The human bone most often broken is the collar bone (clavicle).";
        case 38:
            return @"The “french” in french fries actually describes the way the spuds are sliced, not their country of origin.";
        case 39:
            return @"In a 60 Minutes/Vanity Fair poll conducted in February 2012, 2% of Americans thought Mitt Romney's first name was Mittens. Only 6% knew that it's Willard.";
        case 40:
            return @"Just as some people talk in their sleep, sign language speakers have been known to sign in their sleep.";
        case 41:
            return @"Goosebumps are actually caused by a muscle. It is called the arrector pili muscle.";
        case 42:
            return @"Your foot is the same size as the distance between your wrist and elbow.";
        case 43:
            return @"Restaurant chains like Applebee’s and T.G.I. Friday’s have their staff sing a specialized song to wish customers a happy birthday in order to avoid paying royalties, since ”Happy Birthday to You” is a copyrighted tune.";
        case 44:
            return @"The average CD can hold 74 minutes’ worth of music. That unusual length was determined by Sony’s president, who decided that a single CD should be able to contain the longest recorded version of Beethoven’s Ninth Symphony.";
        case 45:
            return @"The sum of all the numbers on a roulette wheel is 666.";
        case 46:
            return @"William Faulkner once refused a dinner invitation from President Kennedy's White House. ”Why that’s a hundred miles away,” Faulkner explained. ”That’s a long way to go just to eat.”";
        case 47:
            return @"Each year, about 450 men die of breast cancer in America.";
        case 48:
            return @"Braces go all the way back to ancient Egypt. In fact, archeologists have found several mummies with crude metal bands wrapped around their teeth.";
        case 49:
            return @"Only one building has hosted the Major League Baseball World Series, the NFL Super Bowl, and the NCAA Division I Men's Basketball Final Four Tournament: the Hubert H. Humphrey Metrodome in Minneapolis. Between October 19th, 1991, and April 6th, 1992, all three events were held there.";
        case 50:
            return @"Pretzels were invented by an Italian monk who used the treats as a bribe to get kids to memorize scripture. In fact, the criss-crossed bits are supposed to represent the folded arms of pious children in prayer.";
        case 51:
            return @"During WWII, La-Z-Boy manufactured seats for tanks, torpedo boats, gun turrets, and armored cars.";
        case 52:
            return @"Adolf Hitler was Time Magazine's Man of the Year for 1938.";
        case 53:
            return @"World War I ended at precisely eleven o'clock on the eleventh day of the eleventh month of the year 1918.";
        case 54:
            return @"An infant human has about 300 bones, some of which fuse together as the youngster grows up. An adult human's body typically contains 206 bones.";
        case 55:
            return @"Green colored light is the least used color of light in the process of photosynthesis. Thusly, it is reflected back into our eyes. That is why plants are, for the most part, green.";
        case 56:
            return @"About half the geysers on Earth are located in Yellowstone National Park.";
        case 57:
            return @"Editor Bennett Cerf challenged Dr. Seuss to write a book containing exactly 50 words. The result? Green Eggs and Ham.";
        case 58:
            return @"Gremlins was one of two movies to influence the start of the PG-13 rating. The other was Indiana Jones and the Temple of Doom.";
        case 59:
            return @"In 2005, Egypt formally requested that the British Museum return the Rosetta Stone to its native land, but British law prevents the museum from giving up anything in its collection.";
        case 60:
            return @"Beach Boys front man and co-producer Brian Wilson is almost completely deaf in his right ear. Therefore, every album he appears on is mixed in one-channel, or mono.";
        case 61:
            return @"As a rule, European carousels rotate clockwise, while American merry-go-rounds spin counterclockwise.";
        case 62:
            return @"Bill Clinton reportedly only ever sent two emails as president, one of which was a test message to see if he was doing it correctly.";
        case 63:
            return @"William McKinley was on the $500 bill, Grover Cleveland was on the $1,000, and James Madison was on the $5,000.";
        case 64:
            return @"Ronald Reagan's first Inauguration Day (Jan. 20th, 1981) was the warmest January inauguration on record, at 55°F. When reelected, his second Inauguration Day (Jan. 21st, 1985) was the coldest on record, at only 7°F.";
        case 65:
            return @"The antennae sticking out the head of a snail aren't feelers; a snail's eyes are located at the tips of those long stalks.";
        case 66:
            return @"In 1992, Nickelodeon buried a time capsule that included a Game Boy, Reebok Pump sneakers, and Gak. Joey Lawrence added a hat that said 'Whoa!' on it.";
        case 67:
            return @"You can visit half of the world's 10 largest lakes by visiting a single country: Canada. The five lakes are Great Bear, Great Slave, Erie, Huron, and Superior.";
        case 68:
            return @"An earthquake on December 16th, 1811, caused parts of the Mississippi River to flow backwards.";
        case 69:
            return @"Although the word 'earthling' today conjures visions of science-fiction stories, it is actually the Old English word for a farmer.";
        case 70:
            return @"While Cape Horn certainly resembles a horn, that's not where its name originated. It was named after Hoorn, the hometown of Dutch navigator Willem Schouten.";
        case 71:
            return @"Deipnophobia is the fear of dinner party conversations.";
        case 72:
            return @"In order to better survive the cold, polar bears have evolved to have black skin, thick blubber, and hollow, translucent hairs that trap heat. Polar bears are so well-insulated that they are almost invisible under infra-red light.";
        case 73:
            return @"Twitters bird is called Lary.";
        case 74:
            return @"The world's largest desert is not the Sahara; it is the continent of Antarctica. (Antarctica is classified as a 'cold desert.')";
        case 75:
            return @"Crossword puzzles became such a hit in the mid-1920s that women’s fashion adopted the motif, printing grids on clothes, shoes, and jewelry.";

            
        default:
            return @"I didn't write anything for this one!";
    }
}
-(NSString*)catagoryForSquare:(int)squareTag{
    switch (squareTag) {
        case 0:
            return @"Interesting";
        case 1:
            return @"Inspirational";
        case 2:
            return @"Fact";
        case 3:
            return @"LOL";
        case 4:
            return @"Question";
        case 5:
            return @"Fact";
        case 6:
            return @"Wow";
        case 7:
            return @"Wow";
        case 8:
            return @"HI!!!";
        case 9:
            return @"Lies";
        case 10:
            return @"...";
        case 11:
            return @"Story";
        case 12:
            return @"ERROR";
        case 13:
            return @"Latin";
        case 14:
            return @"ME be";
        case 15:
            return @"The Golden Rule";
        case 16:
            return @"Tip";
        case 17:
            return @"True";
        case 18:
            return @"Kindness";
        case 19:
            return @"Fact";
        case 20:
            return @"Whow";
        case 21:
            return @"Getting Real";
        case 22:
            return @"Fact";
        case 23:
            return @"Brrrr";
        case 24:
            return @"Statistic";
        case 25:
            return @"Photos";
        case 26:
            return @"Useless";
        case 27:
            return @"Math";
        case 28:
            return @"Puzzle";
        case 29:
            return @"Fact";
        case 30:
            return @"LOL";
        case 31:
            return @"Fact";
        case 32:
            return @"NO Way!";
        case 33:
            return @"Special";
        case 34:
            return @"Tap ^_^";
        case 35:
            return @"Helpful";
        case 36:
            return @"Random";
        case 37:
            return @"Interesting";
        case 38:
            return @"Food";
        case 39:
            return @"Names";
        case 40:
            return @"Zzzzz";
        case 41:
            return @"The Body";
        case 42:
            return @"The Body";
        case 43:
            return @"Copyrights";
        case 44:
            return @"Those Odds";
        case 45:
            return @"Wierd";
        case 46:
            return @"Point Missed";
        case 47:
            return @"Unfortunate";
        case 48:
            return @"Wow";
        case 49:
            return @"Sports";
        case 50:
            return @"Pretzels";
        case 51:
            return @"Multipurpose";
        case 52:
            return @"LOL";
        case 53:
            return @"History";
        case 54:
            return @"The Body";
        case 55:
            return @"Science";
        case 56:
            return @"Geography";
        case 57:
            return @"Cool";
        case 58:
            return @"Movies";
        case 59:
            return @"Cool History";
        case 60:
            return @"Music";
        case 61:
            return @"Useless Fact";
        case 62:
            return @"Presidents";
        case 63:
            return @"Money";
        case 64:
            return @"Those Odds";
        case 65:
            return @"Bug Anatomy";
        case 66:
            return @"Cool";
        case 67:
            return @"Geography";
        case 68:
            return @"The Power of Nature";
        case 69:
            return @"Old English";
        case 70:
            return @"Cool Coincidence";
        case 71:
            return @"Science";
        case 72:
            return @"Nature is Awesome";
        case 73:
            return @"Logos";
        case 74:
            return @"Technicalities";
        case 75:
            return @"Fashion";
            
        default:
            return @"NULL";
            
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    // remove from screen
    for (int i = 0; i<boxArray.count; i++) {
        UIImageView *box =[boxArray objectAtIndex:i];
        
        [box removeFromSuperview];
    }
    
    // clear array
    [boxArray removeAllObjects];
    
    // stop timer
    [timer invalidate];
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
