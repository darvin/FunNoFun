//
//  AppDelegate.h
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "FunNoFunModel.h"
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate> {
}
@property (strong, nonatomic) Facebook * facebook;
@property (strong, nonatomic) UIWindow *window;
@property (strong) FunNoFunModel* model;

@property (strong, nonatomic) ViewController *viewController;

@end
