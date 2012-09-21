//
//  webView.m
//
//  Created by Shaun on Thursday, April 22 2010.
//  Copyright 2010 SambaWorks. All rights reserved.
//

#import "webView.h"
#import "Definitions.h"


@implementation webView
@synthesize aWebView;
@synthesize activityIndicator;
@synthesize back;
@synthesize forward;
@synthesize toolbar;
@synthesize websiteToUse;
@synthesize htmlToLoad;

- (void)hudWasHidden{
    [activityIndicator removeFromSuperview];
}

#pragma mark -
#pragma mark view lifecycle
- (void)loadView {
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - (20 + 50)))];
    [self setView:mainView];
    self.view.autoresizesSubviews = YES;
    self.aWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - (20 + 50 + 44)))];
    [self.aWebView setDataDetectorTypes:UIDataDetectorTypeAll];
    [self.aWebView setScalesPageToFit:YES];
    [self.aWebView setAutoresizesSubviews:YES];
    [self.aWebView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.aWebView setContentMode:UIViewContentModeScaleToFill];
    
    [[self view] addSubview:self.aWebView];
    
    self.back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] landscapeImagePhone:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self.aWebView action:@selector(goBack)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [space setWidth:20];
    self.forward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward.png"] landscapeImagePhone:[UIImage imageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:self.aWebView action:@selector(goForward)];
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self.aWebView action:@selector(stopLoading)];
    UIBarButtonItem *spaceOne = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    [spaceOne setWidth:(kScreenCenterX - 90)];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self.aWebView action:@selector(reload)];
    UIBarButtonItem *spaceTwo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spaceTwo setWidth:(kScreenCenterX - 90)];
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 38, self.view.bounds.size.width, 44)];
    [self.toolbar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [[self view] addSubview:toolbar];
    [self.toolbar setItems:[NSArray arrayWithObjects:self.back, space, self.forward, spaceOne, stopButton, spaceTwo, refreshButton, nil]];
    [self.toolbar setBarStyle:UIBarStyleBlack];
    
    //NSLog(@"Loading the view");
    [[self aWebView] setDelegate:self];
//    [[self navigationItem]setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Hide"style:UIBarButtonItemStyleBordered target:self action:@selector(toggleToolbar)]];
    [self.back setEnabled:NO];
    [self.forward setEnabled:NO];
    [self viewDidLoad];

}
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    [toolbar setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height - toolbar.bounds.size.height/2)];
//    NSLog(@"%f %f",toolbar.center.x, toolbar.center.y);
}
- (void) viewWillDisappear:(BOOL)animated{
    //when the view is disappearing set the hide button to nil, remove the delegate and stop the loading
    //NSLog(@"Removing some things, stopping the loading and setting the delegate to nil");
    [[self navigationItem] setRightBarButtonItem:nil];
    [[self aWebView] setDelegate:nil];
    [self.aWebView stopLoading];
}
- (void) viewDidLoad{
    [self setHidesBottomBarWhenPushed:YES];
    [[self toolbar] setTintColor:defaultColor];
    self.activityIndicator = [[MBProgressHUD alloc] initWithView:[self view]];
    [self.activityIndicator setMode:MBProgressHUDModeIndeterminate];
    [self.activityIndicator setTag:1];
    [self.aWebView setDataDetectorTypes:UIDataDetectorTypeAll];
    if (htmlToLoad != NULL) {
        //NSLog(@"loading the HTML document");
        [self.aWebView loadHTMLString:htmlToLoad baseURL:nil];
    }
    else {
        //NSLog(@"starting a web request");
        dispatch_queue_t webWorker;
        webWorker = dispatch_queue_create("com.icambrian.webWorker", NULL);
        dispatch_async(webWorker, ^{
            //NSLog(@"Working Asynchronously");
            [self.aWebView loadRequest:[NSURLRequest requestWithURL:websiteToUse cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
        });
        //the queue is being released because the it has been loaded.
        dispatch_release(webWorker);
        
    }

}
#pragma mark -
#pragma mark Custom Functions
- (void) toggleToolbar{
    //NSLog(@"toggling the back/forward toolbar");
    if ([self.toolbar isHidden]) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.9];
        [self.toolbar setCenter:CGPointMake(self.toolbar.center.x, self.toolbar.center.y - 44)];
        [UIView commitAnimations];
        [self.toolbar setHidden:NO];
        [[self navigationItem].rightBarButtonItem setTitle:@"Hide"];
    }
    else {
        [self.toolbar setCenter:CGPointMake(self.toolbar.center.x, self.toolbar.center.y + 44)];
        [[self navigationItem].rightBarButtonItem setTitle:@"Show"];
        [self.toolbar setHidden:YES];
    }

}

#pragma mark -
#pragma mark Initialization Functions
- (webView*) initWithWebsite:(NSURL *)theWebsite andTitle:(NSString *)titleToUse {
    //this is an initialization method that loads the nib (depending on if it's an iPad or not)
    self = [super init];
    //NSLog(@"an initializer for a custom webView that takes a URL and a title for the page.");
    if (self) {
        [self setTitle:titleToUse];
        self.websiteToUse = [theWebsite copy];
    }
    [[self aWebView] setScalesPageToFit:YES];
    [self loadView];
    return self;
}

- (webView*) initWithHTMLString:(NSString *)htmlFile{
    //initializes with HTML data
    self = [super init];
    //NSLog(@"custom initializer for an HTML file.");
    [self.aWebView setScalesPageToFit:NO];
    self.htmlToLoad = [htmlFile copy];
    [self loadView];
    return self;
}

#pragma mark -
#pragma mark webView methods
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator setCenter:[self view].center];
    [[self view] addSubview:self.activityIndicator];
    [self.activityIndicator show:YES];
    //NSLog(@"showing the spinning thing");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //does start load requests
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //hiding the spinny thing for the webview loading
    //NSLog(@"Finished Loading");
    [webView canGoBack]?[self.back setEnabled:YES]:[self.back setEnabled:NO];
    [webView canGoForward]?[self.forward setEnabled:YES]:[self.forward setEnabled:NO];
    [self.activityIndicator hide:YES];
    [self.activityIndicator removeFromSuperview];
    //NSLog(@"hiding the spinning thing");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (error.code != NSURLErrorCancelled){
        [self.aWebView stopLoading];
        [self.activityIndicator hide:YES];
        NSLog(@"%@",[error localizedDescription]);
    }
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    //deleting cached response
    NSCachedURLResponse *newCache = cachedResponse;
    newCache = nil;
    return newCache;
}

#pragma mark -
#pragma mark AutoRotate Code

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    }
    else {
         return NO;
    }
}
#pragma mark -
#pragma mark Memory Management
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}
- (void)dealloc {
    //NSLog(@"DEALLOC CALLED");
    [self.aWebView loadHTMLString:@"" baseURL:nil];
}



@end
