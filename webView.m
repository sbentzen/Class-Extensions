//
//  webView.m
//
//  Created by Shaun on Thursday, April 22 2010.
//  Copyright 2010 SambaWorks. All rights reserved.
//

#import "webView.h"
#import "Definitions.h"


@implementation webView
@synthesize theWebView;
@synthesize progress;
@synthesize back;
@synthesize forward;
@synthesize toolbar;
@synthesize websiteToUse;
@synthesize htmlToLoad;
@synthesize spaceOne;
@synthesize spaceTwo;

- (void)hudWasHidden{
    [progress removeFromSuperview];
    [progress release];
}

#pragma mark -
#pragma mark view lifecycle
- (void)loadView {
    //setting the view. this is called in the init methods and at the very end it calls viewdidload, because by the time you get to the end, it has loaded
    //NSLog(@"Loading the view");
    [[self theWebView] setDelegate:self];
    [[self navigationItem]setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Hide"style:UIBarButtonItemStyleBordered target:self action:@selector(toggleToolbar)]autorelease]];
    [back setEnabled:NO];
    [forward setEnabled:NO];
    [self viewDidLoad];

}


- (void) viewWillDisappear:(BOOL)animated{
    //when the view is disappearing set the hide button to nil, remove the delegate and stop the loading
    //NSLog(@"Removing some things, stopping the loading and setting the delegate to nil");
    [[self navigationItem] setRightBarButtonItem:nil];
    [[self theWebView] setDelegate:nil];
    [theWebView stopLoading];
}
- (void) viewDidLoad{
    [self setHidesBottomBarWhenPushed:YES];
    [[self toolbar] setTintColor:defaultColor];
    progress = [[MBProgressHUD alloc] initWithView:[self view]];
    [progress setMode:MBProgressHUDModeIndeterminate];
    [progress setTag:1];
    [theWebView setDataDetectorTypes:UIDataDetectorTypeAll];
    if (htmlToLoad != NULL) {
        //NSLog(@"loading the HTML document");
        [theWebView loadHTMLString:htmlToLoad baseURL:nil];
        [htmlToLoad release];
    }
    else {
        //NSLog(@"starting a web request");
        dispatch_queue_t webWorker;
        webWorker = dispatch_queue_create("com.icambrian.webWorker", NULL);
        dispatch_async(webWorker, ^{
            //NSLog(@"Working Asynchronously");
            [theWebView loadRequest:[NSURLRequest requestWithURL:websiteToUse cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
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
    [[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"webView%@",isiPad?@"-iPad":@""] owner:self options:nil];
    
    if (self) {
        [self setTitle:titleToUse];
        websiteToUse = [theWebsite copy];
    }
    [[self theWebView] setScalesPageToFit:YES];
    [self loadView];
    return self;
}

- (webView*) initWithHTMLString:(NSString *)htmlFile{
    //initializes with HTML data
    self = [super init];
    //NSLog(@"custom initializer for an HTML file.");
    if isiPad {
        [[NSBundle mainBundle] loadNibNamed:@"webView-iPad" owner:self options:nil];
        //NSLog(@"ipad nib");
    }
    else {
        [[NSBundle mainBundle] loadNibNamed:@"webView" owner:self options:nil];
        //NSLog(@"iphone nib");
    }
    [theWebView setScalesPageToFit:NO];
    htmlToLoad = [htmlFile copy];
    [self loadView];
    return self;
}

#pragma mark -
#pragma mark webView methods
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [progress setCenter:[self view].center];
    [[self view] addSubview:progress];
    [progress show:YES];
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
    [progress hide:YES];
    [progress removeFromSuperview];
    //NSLog(@"hiding the spinning thing");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (error.code != NSURLErrorCancelled){
        [theWebView stopLoading];
        [progress hide:YES];
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
    back = nil;
    forward = nil;
    [spaceOne release];
    [spaceTwo release];
    [progress release];
    [theWebView loadHTMLString:@"" baseURL:nil];
    [theWebView release];
    [websiteToUse release];
    theWebView = nil;
    [super dealloc];
}



@end
