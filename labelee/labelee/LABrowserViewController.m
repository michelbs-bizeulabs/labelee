//
//  LABrowserViewController.m
//  labelee
//
//  Created by mservet on 2/8/14.
//  Copyright (c) 2014 Labelee. All rights reserved.
//

#import "LABrowserViewController.h"

@interface LABrowserViewController ()

@end

@implementation LABrowserViewController

- (id)initWithURL:(NSURL*)anURL {
    
    if (self = [super init]) {
        
        _url = anURL;
    }
   
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set screen name.
    self.screenName = @"Browser Screen";
    
    // asignar el delegado , en este caso el mismo controlador
    self.browserView.delegate = self;
    
    // Cargamos la pagina
    [self.browserView loadRequest:[NSURLRequest requestWithURL:self.url]];
  
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //para que solo deje navegar dentro de la webpage principal,no dejar ir a otros enlaces
    if (navigationType== UIWebViewNavigationTypeLinkClicked||
        navigationType== UIWebViewNavigationTypeFormSubmitted) {
        return NO;
    }
    else
        
        return YES;
}

// Buscamos el prototoco del delegado correspondiente y lo pegamos
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Se ha terminado de cargar la pagina");
    //parar la animacion de loading
    [self.loading stopAnimating];
    [self.loading setHidesWhenStopped:YES];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //animacion loading para siguientes paginas
    [self.loading startAnimating];
}

@end
