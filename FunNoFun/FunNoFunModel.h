//
//  FunNoFunModel.h
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
@class FunNoFunModel;
@protocol FunNoFunModelDelegate <NSObject>

-(void) funNoFunModel:(FunNoFunModel*)model newFriendsPairAvailable:(NSArray*) friendsPair;
-(void) funNoFunModel:(FunNoFunModel *)model finishedWithResults:(NSDictionary*) results;
@end
@interface FunNoFunModel : NSObject <FBRequestDelegate> {
    NSArray * currentPair;
    NSMutableDictionary* results;
    NSDictionary *requestResult;
}
@property NSUInteger friendsNumber;
@property Facebook * facebook;
@property NSUInteger step;
@property (weak) id<FunNoFunModelDelegate> delegate;
- (id) initWithFacebook:(Facebook*) facebook andFriendsNumber:(NSUInteger) friendsNumber;
- (void) chooseFriendWithIndexInPair:(NSUInteger)index;
-(void) skipStep;
-(void)loadFriends;
@end
