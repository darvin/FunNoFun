//
//  ViewController.h
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunNoFunModel.h"
@interface ViewController : UIViewController <FunNoFunModelDelegate>
@property (weak, nonatomic) FunNoFunModel* model;
@property IBOutlet UIImageView* firstFriendImage;
@property IBOutlet UIImageView* secondFriendImage;
@property IBOutlet UILabel * firstFriendLabel;
@property IBOutlet UILabel *secondFriendLabel;
@property IBOutlet UIProgressView* progress;
@property IBOutlet UILabel* progressLabel;


-(IBAction)firstFriendTouched:(id)sender;
-(IBAction)secondFriendTouched:(id)sender;

@end
