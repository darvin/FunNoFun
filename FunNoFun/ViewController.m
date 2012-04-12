//
//  ViewController.m
//  FunNoFun
//
//  Created by Sergey Klimov on 4/12/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "ResultsViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize  model=_model;
@synthesize firstFriendImage=_firstFriendImage, secondFriendImage=_secondFriendImage, firstFriendLabel=_firstFriendLabel, secondFriendLabel=_secondFriendLabel, progress=_progress, progressLabel=_progressLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UISwipeGestureRecognizer *swipeRecognizer = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(swipeToSkip:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown&&interfaceOrientation!=UIInterfaceOrientationPortrait);
}


-(void) setModel:(FunNoFunModel *)model {
    model.delegate = self;
    _model = model;
    self.progress.progress = 0;
}

-(void) funNoFunModel:(FunNoFunModel*)model newFriendsPairAvailable:(NSArray*) friendsPair {
    //better solution is to have FriendView who is responsible for all one-friend related actions, but I dont have a time
    [self.firstFriendImage setImageWithURL:[NSURL URLWithString:[[friendsPair objectAtIndex:0] objectForKey:@"picture"]]];
    [self.secondFriendImage setImageWithURL:[NSURL URLWithString:[[friendsPair objectAtIndex:1] objectForKey:@"picture"]]];
    self.firstFriendLabel.text = [[friendsPair objectAtIndex:0] objectForKey:@"name"];
    self.secondFriendLabel.text = [[friendsPair objectAtIndex:1] objectForKey:@"name"];
    self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", self.model.step, self.model.friendsNumber];
    self.progress.progress = (float)model.step/ model.friendsNumber;
}
-(void) funNoFunModel:(FunNoFunModel *)model finishedWithResults:(NSDictionary*) results {
    ResultsViewController * vc = [[ResultsViewController alloc] initWithResults:results];
    [self presentModalViewController:vc animated:YES];
}

- (void) chooseFriendWithIndex:(NSUInteger) index {
    [self.model chooseFriendWithIndexInPair:index];
}

-(IBAction)firstFriendTouched:(id)sender {
    [self chooseFriendWithIndex:0];
}
-(IBAction)secondFriendTouched:(id)sender {
    [self chooseFriendWithIndex:1];
}

-(IBAction)swipeToSkip:(id)sender {
    [self.model skipStep];
}

@end
