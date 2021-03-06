//
//  PSViewController.m
//  PSPushPopPressViewExample
//
//  Created by Peter Steinberger on 11/16/11.
//  Copyright (c) 2011 Peter Steinberger. All rights reserved.
//

#import "PSExampleViewController.h"
#import "PSPushPopPressView.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerDemoPlaybackViewController.h"

@implementation PSExampleViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

- (void)dealloc {
    pushPopPressView_.pushPopPressViewDelegate = nil;
    pushPopPressVideoView_.pushPopPressViewDelegate = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ExampleView" owner:self options:nil];
    containerView_ = [nibArray objectAtIndex:0];
    containerView_.frame = self.view.bounds;
    containerView_.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:containerView_];

    // create the push pop press container
    CGRect firstRect = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? CGRectMake(140, 40, 500, 400) : CGRectMake(10, 10, 300, 300);
    pushPopPressView_ = [[PSPushPopPressView alloc] initWithFrame:firstRect];
    pushPopPressView_.pushPopPressViewDelegate = self;
    [containerView_ addSubview:pushPopPressView_];

    // add a cat image to the container
//    UIImageView *catImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat.jpg"]];
//    catImageView.frame = pushPopPressView_.bounds;
//    catImageView.contentMode = UIViewContentModeScaleAspectFill;
//    catImageView.backgroundColor = [UIColor blackColor];
//    catImageView.layer.borderColor = [UIColor blackColor].CGColor;
//    catImageView.layer.borderWidth = 1.0f;
//    catImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    catImageView.clipsToBounds = YES;
//    [pushPopPressView_ addSubview:catImageView];
    
    [self setPlayerView2:[[HSPlayerView alloc] initWithFrame:pushPopPressView_.bounds]];
    [self.playerView2 setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.playerView2 setBackgroundColor:[UIColor blackColor]];
    [pushPopPressView_ addSubview:self.playerView2];
    
    [self.playerView2 setURL:[NSURL URLWithString:@"http://rss.feedsportal.com/c/808/f/534769/e/1/s/34f7822a/l/0Lvideo720A0Bjeuxvideo0N0C20A13120Cthe0Enovelist0Epc0E0A0A1177430E138720A46480E720Ap0Bmp4/the-novelist-pc-00117743-1387204648-720p.mp4"]];

    // create a second push pop press container, with a video
    pushPopPressVideoView_ = [[PSPushPopPressView alloc] initWithFrame:CGRectMake(140, 500, 500, 400)];
    pushPopPressVideoView_.pushPopPressViewDelegate = self;
    [containerView_ addSubview:pushPopPressVideoView_];

    // create the movie player controller
//    AVPlayerDemoPlaybackViewController *moviePlayer = [[AVPlayerDemoPlaybackViewController alloc] init];
//    moviePlayer.URL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
////    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"]];
//    [self addChildViewController:moviePlayer];
//    moviePlayer.view.frame = pushPopPressVideoView_.bounds;
//    moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [pushPopPressVideoView_ addSubview:moviePlayer.view];
//    [moviePlayer play:self];
    
    [self setPlayerView1:[[HSPlayerView alloc] initWithFrame:pushPopPressVideoView_.bounds]];
    [self.playerView1 setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.playerView1 setBackgroundColor:[UIColor blackColor]];
    [pushPopPressVideoView_ addSubview:self.playerView1];
    
    [self.playerView1 setURL:[NSURL URLWithString:@"http://rss.feedsportal.com/c/808/f/534769/e/1/s/34f7822a/l/0Lvideo720A0Bjeuxvideo0N0C20A13120Cthe0Enovelist0Epc0E0A0A1177430E138720A46480E720Ap0Bmp4/the-novelist-pc-00117743-1387204648-720p.mp4"]];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    // be sure to nil out delegates
    pushPopPressView_.pushPopPressViewDelegate = nil;
    pushPopPressView_ = nil;

    pushPopPressVideoView_.pushPopPressViewDelegate = nil;
    pushPopPressVideoView_ = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PSPushPopPressViewDelegate

- (void)pushPopPressViewDidStartManipulation:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewDidStartManipulation: %@", pushPopPressView);

    activeCount_++;
    [UIView animateWithDuration:0.45f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        // note that we can't just apply this transform to self.view, we would loose the
        // already applied transforms (like rotation)
        containerView_.transform = CGAffineTransformMakeScale(0.97, 0.97);
    } completion:nil];
}

- (void)pushPopPressViewDidFinishManipulation:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewDidFinishManipulation: %@", pushPopPressView);

    if (activeCount_ > 0) {
        activeCount_--;
        if (activeCount_ == 0) {
            [UIView animateWithDuration:0.45f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                containerView_.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    }
}

- (void)pushPopPressViewWillAnimateToOriginalFrame:(PSPushPopPressView *)pushPopPressView duration:(NSTimeInterval)duration {
    NSLog(@"pushPopPressViewWillAnimateToOriginalFrame: %@duration: %f", pushPopPressView, duration);
}

- (void)pushPopPressViewDidAnimateToOriginalFrame:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewDidAnimateToOriginalFrame: %@", pushPopPressView);

    // update autoresizing mask to adapt to width only
    pushPopPressView.autoresizingMask = UIViewAutoresizingNone;

    // ensure the view doesn't overlap with another (possible fullscreen) view
    [containerView_ sendSubviewToBack:pushPopPressView];
}

- (void)pushPopPressViewWillAnimateToFullscreenWindowFrame:(PSPushPopPressView *)pushPopPressView duration:(NSTimeInterval)duration {
    NSLog(@"pushPopPressViewWillAnimateToFullscreenWindowFrame:%@ duration: %f", pushPopPressView, duration);
}

- (void)pushPopPressViewDidAnimateToFullscreenWindowFrame:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewDidAnimateToFullscreenWindowFrame: %@", pushPopPressView);

    // update autoresizing mask to adapt to borders
    pushPopPressView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (BOOL)pushPopPressViewShouldAllowTapToAnimateToOriginalFrame:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewShouldAllowTapToAnimateToOriginalFrame: %@", pushPopPressView);
    return YES;
}

- (BOOL)pushPopPressViewShouldAllowTapToAnimateToFullscreenWindowFrame:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewShouldAllowTapToAnimateToFullscreenWindowFrame: %@", pushPopPressView);
    return YES;
}

- (void)pushPopPressViewDidReceiveTap:(PSPushPopPressView *)pushPopPressView {
    NSLog(@"pushPopPressViewDidReceiveTap: %@", pushPopPressView);
}

@end
