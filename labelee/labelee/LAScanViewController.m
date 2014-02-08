//
//  LAScanViewController.m
//  labelee
//
//  Created by mservet on 2/8/14.
//  Copyright (c) 2014 Labelee. All rights reserved.
//

#import "LAScanViewController.h"
#import "LABrowserViewController.h"

@interface LAScanViewController ()

@end

@implementation LAScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // the delegate receives decode results
    self.zbarReaderView.readerDelegate = self;
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [self.zbarReaderView start];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [self.zbarReaderView stop];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [self.zbarReaderView willRotateToInterfaceOrientation: orient
                                             duration: duration];
}

- (void) willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation) orient
                                          duration: (NSTimeInterval) duration
{
    // perform rotation in animation loop so camera preview does not move
    // wrt device orientation
    [self.zbarReaderView setNeedsLayout];
}


#pragma mark - ZBarReaderView Delegates

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
 
        
        NSLog(@"El codigo de barra leido es el %@ :",sym.data);
        
       NSString *urlString = [NSString stringWithFormat:@"%@",sym.data];
        
       NSURL *url = [NSURL URLWithString:urlString];
        
       // NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
        
        LABrowserViewController *browserVC = [[LABrowserViewController alloc]initWithURL:url];
        
        [self.navigationController pushViewController:browserVC animated:YES];
        
        
        break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
