//
//  FunNoFunModel.m
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "FunNoFunModel.h"

@implementation FunNoFunModel
@synthesize facebook=_facebook, friendsNumber=_friendsNumber, delegate=_delegate, step=_step;

-(id) initWithFacebook:(Facebook *)facebook andFriendsNumber:(NSUInteger)friendsNumber {
    if (self=[super init]) {
        _friendsNumber = friendsNumber;
        _facebook = facebook;
        results = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    requestResult = result;
    [self nextPair];
}

- (void) nextPair {
    NSArray * friends = [requestResult objectForKey:@"data"];
    uint firstIndex = 0;
    uint secondIndex = 0;
    while (firstIndex==secondIndex) { //here need to implement testing for already matched pairs
        firstIndex = arc4random()%[friends count];
        secondIndex = arc4random()%[friends count];

    }
    currentPair = [NSArray arrayWithObjects:[friends objectAtIndex:firstIndex],[friends objectAtIndex:secondIndex], nil];
    [self.delegate funNoFunModel:self newFriendsPairAvailable:currentPair];
}
- (void) loadFriends {
    [self.facebook requestWithGraphPath:@"me/friends" 
                         andParams:[ NSMutableDictionary dictionaryWithObject:@"picture,id,name,link,gender,last_name,first_name" forKey:@"fields"]
                       andDelegate:self];

}
- (void) chooseFriendWithIndexInPair:(NSUInteger)index {
    NSDictionary* choosedFriend = [currentPair objectAtIndex:index];
    
    NSNumber * friendKey = [choosedFriend objectForKey:@"id"];
    NSNumber * friendResult = [results objectForKey:friendKey];
    if (!friendResult) {
        friendResult = [NSNumber numberWithInt:1];
    } else {
        friendResult = [NSNumber numberWithInt:[friendResult intValue]+1];
    }
    [results setObject:friendResult forKey:friendKey];
    
    self.step +=1;
    if (self.step> self.friendsNumber) {
        NSArray * friends = [requestResult objectForKey:@"data"];
        NSArray * sortedFriends = [friends sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber* res1 = [results objectForKey:[obj1 objectForKey:@"id"]];
            NSNumber* res2 = [results objectForKey:[obj2 objectForKey:@"id"]];
            if (!res1) {
                res1 = [NSNumber numberWithInt:0];
            }
            if (!res2) {
                res2 = [NSNumber numberWithInt:0];
            }
            return [res2 compare:res1];
        }];
        
        NSMutableArray *readableResults = [NSMutableArray array];
        for (NSDictionary* friend in sortedFriends) {
            NSDictionary* friendDict = [NSDictionary dictionaryWithObjectsAndKeys:friend, @"friendData",
                [results objectForKey:[friend objectForKey:@"id"]], @"friendResult",
                                    nil];
            
            [readableResults addObject:friendDict];
        }
        
        [self.delegate funNoFunModel:self finishedWithResults:[NSArray arrayWithArray:readableResults]];
    }
    [self nextPair];
    
}

-(void) skipStep {
    [self nextPair];
}

@end
