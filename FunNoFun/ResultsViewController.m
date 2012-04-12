//
//  ResultsViewController.m
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController
@synthesize firstPart, secondPart;

- (id)initWithResults:(NSArray*)results
{
    self = [super initWithNibName:@"ResultsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        NSMutableArray* strings = [NSMutableArray array];
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* friend = obj;
            NSNumber * friendResult = [friend objectForKey:@"friendResult"];
            if (!friendResult) {
                friendResult = [NSNumber numberWithInt:0];
            }
            NSString* frString = [NSString stringWithFormat:@"%d. %@ - %@pts", idx+1, [[friend objectForKey:@"friendData"] objectForKey:@"name"], friendResult];
            [strings addObject:frString];
            *stop = (idx>10); //Should be smarter
        }];
        result = [NSArray arrayWithArray:strings];
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    uint firstPartUntilIndex = [result count]/2;

    self.firstPart.text = [[result subarrayWithRange:NSMakeRange(0, firstPartUntilIndex)] componentsJoinedByString:@"\n"];
    self.secondPart.text = [[result subarrayWithRange:NSMakeRange(firstPartUntilIndex, [result count]-firstPartUntilIndex)] componentsJoinedByString:@"\n"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
