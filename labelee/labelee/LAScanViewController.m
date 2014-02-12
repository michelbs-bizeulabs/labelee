//
//  LAScanViewController.m
//  labelee
//
//  Created by mservet on 2/8/14.
//  Copyright (c) 2014 Labelee. All rights reserved.
//

#import "LAScanViewController.h"
#import "LABrowserViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"


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
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.navigationController.view.bounds.size.width/2 - 50 + 10, self.navigationController.view.bounds.origin.y + 26, 100, 20)];
    
    titleLabel.text = @"labelee";
    titleLabel.font = FONT_LABELEE(20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view addSubview:titleLabel];
    
    
    UILabel *subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.navigationController.view.bounds.size.width/2 - 50 + 10, self.navigationController.view.bounds.origin.y + 46, 100, 10)];
    
    subtitleLabel.text = @"indoor location";
    subtitleLabel.font = FONT_LABELEE(10);
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view addSubview:subtitleLabel];
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(88 + 10, 27, 30, 30)];
    
    //logoView.backgroundColor = [UIColor greenColor];
    logoView.image = [UIImage imageNamed:@"labeleelogo.png"];
    
    [self.navigationController.view addSubview:logoView];
    
    
    
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"map.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showMap)];
    
    self.navigationItem.rightBarButtonItem = mapButton;
    
    
    
    // the delegate receives decode results
    self.zbarReaderView.readerDelegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"";
    
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    UIToolbar *instructionBar = [[UIToolbar alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height -30, self.view.frame.size.width,30)];
    //instructionBar.autoresizingMask = self.view.autoresizingMask;
    //instructionBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:instructionBar];
    
    
    self.instructionLabel = [[UILabel alloc]initWithFrame:CGRectMake(instructionBar.bounds.origin.x + 5, instructionBar.bounds.origin.y + 4, 310, 22)];
    self.instructionLabel.text = @"Enfoca nuestro código QR para posicionarte";
    self.instructionLabel.textAlignment = NSTextAlignmentCenter;
    
    self.instructionLabel.font = FONT_LABELEE(14);
    
    [instructionBar addSubview:self.instructionLabel];
    
    
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear:animated];
    self.screenName = @"Scan Screen";
    
    // run the reader when the view is visible
    [self.zbarReaderView start];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [super viewWillDisappear:animated];
    
    self.title = @"Scan";
    [self.zbarReaderView stop];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) showMap {
    
    NSLog(@"MOSTRAMOS EL MAPA SIN POSICIONAR");
    
    NSURL *url = [NSURL URLWithString:@"http://labelee.com/appmobile"];
    
    // May return nil if a tracker has not already been initialized with a property
    // ID.
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Map_action" action:@"show_unlocated_map" label:@"http://labelee.com/appmobile" value:nil]build]];
    
    
    LABrowserViewController *browserVC = [[LABrowserViewController alloc]initWithURL:url];
    
    [self.navigationController pushViewController:browserVC animated:YES];
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
        
        // May return nil if a tracker has not already been initialized with a property
        // ID.
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Zbar_scan" action:@"scanned_code" label:urlString value:nil]build]];
        
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
