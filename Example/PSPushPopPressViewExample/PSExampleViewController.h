//
//  PSViewController.h
//  PSPushPopPressViewExample
//
//  Created by Peter Steinberger on 11/16/11.
//  Copyright (c) 2011 Peter Steinberger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPushPopPressView.h"

#import "HSPlayerView.h"

@interface PSExampleViewController : UIViewController <PSPushPopPressViewDelegate> {
    NSUInteger *activeCount_;
    UIView *containerView_;
    PSPushPopPressView *pushPopPressView_;
    PSPushPopPressView *pushPopPressVideoView_;
}

@property(nonatomic,strong) HSPlayerView *playerView1;
@property(nonatomic,strong) HSPlayerView *playerView2;

@end
