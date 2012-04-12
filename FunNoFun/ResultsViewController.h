//
//  ResultsViewController.h
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UIViewController  {
    NSArray * result;
}
@property IBOutlet UILabel* firstPart;
@property IBOutlet UILabel* secondPart;
- (id)initWithResults:(NSDictionary*)results;
@end
