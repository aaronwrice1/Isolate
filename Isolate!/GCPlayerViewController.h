//
//  GCPlayerViewController.h
//  Isolate!
//
//  Created by Aaron on 6/25/14.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCHelper.h"
#import "ModeViewController.h"

typedef enum {
    kGameStateWaitingForMatch = 0,
    kGameStateWaitingForRandomNumber,
    kGameStateWaitingForStart,
    kGameStateActive,
    kGameStateInActive,
    kGameStateDone
} GameState;

typedef enum {
    kEndReasonWin,
    kEndReasonLose,
    kEndReasonDisconnect
} EndReason;

typedef enum {
    kMessageTypeRandomNumber = 0,
    kMessageTypeGameBegin,
    kMessageTypeMove,
    kMessageTypeDelete,
    kMessageTypePlayAgain,
    kMessageTypeGameOver
} MessageType;

typedef struct {
    MessageType messageType;
} Message;

typedef struct {
    Message message;
    uint32_t randomNumber;
} MessageRandomNumber;

typedef struct {
    Message message;
} MessageGameBegin;

typedef struct {
    Message message;
    int boxTag;
} MessageMove;

typedef struct {
    Message message;
    int boxTag;
} MessageDelete;

typedef struct {
    Message message;
    BOOL player1Won;
} MessageGameOver;

typedef struct {
    Message message;
} MessagePlayAgain;


@interface GCPlayerViewController : UIViewController <GCHelperDelegate> {
    NSMutableArray *backgroundObjects;
    
    UIImageView *player;
    UIImageView *player2;
    
    int playerState;
    
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *player2Label;
    
    // networking
    uint32_t ourRandom;
    BOOL receivedRandom;
    NSString *otherPlayerID;
    
    GameState gamestate;
    BOOL isPlayer1;
    
    ModeViewController *modeViewController;
}

@end
