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
    aWebView = [[UIWebView alloc] initWithFrame:mainView.bounds];
    [aWebView setDataDetectorTypes:UIDataDetectorTypeAll];
    [aWebView setScalesPageToFit:YES];
    [aWebView setAutoresizesSubviews:YES];
    [aWebView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [aWebView setContentMode:UIViewContentModeScaleToFill];
    
    [[self view] addSubview:aWebView];
    
    back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] landscapeImagePhone:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:aWebView action:@selector(goBack)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [space setWidth:20];
    forward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward.png"] landscapeImagePhone:[UIImage imageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:aWebView action:@selector(goForward)];
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:aWebView action:@selector(stopLoading)];
    UIBarButtonItem *spaceOne = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    NSLog(@"%f",kScreenCenterX);
    [spaceOne setWidth:(kScreenCenterX - 90)];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:aWebView action:@selector(reload)];
    UIBarButtonItem *spaceTwo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spaceTwo setWidth:(kScreenCenterX - 90)];
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 38, self.view.bounds.size.width, 44)];
    [toolbar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
    [[self view] addSubview:toolbar];
    [toolbar setItems:[NSArray arrayWithObjects:back, space, forward, spaceOne, stopButton, spaceTwo, refreshButton, nil]];
    [toolbar setBarStyle:UIBarStyleBlack];
    
    //NSLog(@"Loading the view");
    [[self aWebView] setDelegate:self];
    [[self navigationItem]setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Hide"style:UIBarButtonItemStyleBordered target:self action:@selector(toggleToolbar)]];
    [back setEnabled:NO];
    [forward setEnabled:NO];
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
    [aWebView stopLoading];
}
- (void) viewDidLoad{
    [self setHidesBottomBarWhenPushed:YES];
    [[self toolbar] setTintColor:defaultColor];
    activityIndicator = [[MBProgressHUD alloc] initWithView:[self view]];
    [activityIndicator setMode:MBProgressHUDModeIndeterminate];
    [activityIndicator setTag:1];
    [aWebView setDataDetectorTypes:UIDataDetectorTypeAll];
    if (htmlToLoad != NULL) {
        //NSLog(@"loading the HTML document");
        [aWebView loadHTMLString:htmlToLoad baseURL:nil];
    }
    else {
        //NSLog(@"starting a web request");
        dispatch_queue_t webWorker;
        webWorker = dispatch_queue_create("com.icambrian.webWorker", NULL);
        dispatch_async(webWorker, ^{
            //NSLog(@"Working Asynchronously");
            [aWebView loadRequest:[NSURLRequest requestWithURL:websiteToUse cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
        });
        //the queue is being released because the it has been loaded.
        dispatch_release(webWorker);
        
    }

}
#pragma mark -
#pragma mark Custom Functions
- (void) toggleToolbar{
    //NSLog(@"toggling the back/forward toolbar");
    if ([toolbar isHidden]) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.9];
        [toolbar setCenter:CGPointMake(toolbar.center.x, toolbar.center.y - 44)];
        [UIView commitAnimations];
        [toolbar setHidden:NO];
        [[self navigationItem].rightBarButtonItem setTitle:@"Hide"];
    }
    else {
        [toolbar setCenter:CGPointMake(toolbar.center.x, toolbar.center.y + 44)];
        [[self navigationItem].rightBarButtonItem setTitle:@"Show"];
        [toolbar setHidden:YES];
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
        websiteToUse = [theWebsite copy];
    }
    [[self aWebView] setScalesPageToFit:YES];
    [self loadView];
    return self;
}

- (webView*) initWithHTMLString:(NSString *)htmlFile{
    //initializes with HTML data
    self = [super init];
    //NSLog(@"custom initializer for an HTML file.");
    [aWebView setScalesPageToFit:NO];
    htmlToLoad = [htmlFile copy];
    [self loadView];
    return self;
}

#pragma mark -
#pragma mark webView methods
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicator setCenter:[self view].center];
    [[self view] addSubview:activityIndicator];
    [activityIndicator show:YES];
    //NSLog(@"showing the spinning thing");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //does start load requests
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //hiding the spinny thing for the webview loading
    //NSLog(@"Finished Loading");
    [webView canGoBack]?[back setEnabled:YES]:[back setEnabled:NO];
    [webView canGoForward]?[forward setEnabled:YES]:[forward setEnabled:NO];
    [activityIndicator hide:YES];
    [activityIndicator removeFromSuperview];
    //NSLog(@"hiding the spinning thing");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (error.code != NSURLErrorCancelled){
        [aWebView stopLoading];
        [activityIndicator hide:YES];
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
    [aWebView loadHTMLString:@"" baseURL:nil];
}



@end
