//
//  LABrowserViewController.h
//  labelee
//
//  Created by mservet on 2/8/14.
//  Copyright (c) 2014 Labelee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface LABrowserViewController : GAITrackedViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *browserView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (strong,nonatomic)NSURL *url;

- (id)initWithURL:(NSURL*)anURL;

@end
