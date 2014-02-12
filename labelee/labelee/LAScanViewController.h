//
//  LAScanViewController.h
//  labelee
//
//  Created by mservet on 2/8/14.
//  Copyright (c) 2014 Labelee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface LAScanViewController : UIViewController <ZBarReaderViewDelegate>
@property (weak, nonatomic) IBOutlet ZBarReaderView *zbarReaderView;

@property (strong, nonatomic)  UIView *frameView;

@property (strong, nonatomic)  UILabel *instructionLabel;

@end
