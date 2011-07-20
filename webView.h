//
//  webView.h
//
//  Created by Shaun on Thursday, April 22 2010.
//  Copyright 2010 SambaWorks. All rights reserved.
//

#import "MBProgressHUD.h"

@interface webView : UIViewController <UIWebViewDelegate,MBProgressHUDDelegate> {
	IBOutlet UIWebView *theWebView;
    NSTimer *Timer;
	NSURL *websiteToUse;
	NSString *htmlToLoad;
	MBProgressHUD *progress;
	IBOutlet UIToolbar *toolbar;
	IBOutlet UIBarButtonItem *back;
	IBOutlet UIBarButtonItem *forward;
    IBOutlet UIBarButtonItem *spaceOne;
    IBOutlet UIBarButtonItem *spaceTwo;
}

@property(nonatomic,retain) IBOutlet UIWebView *theWebView;
@property(nonatomic,retain) MBProgressHUD *progress;
@property(nonatomic,retain)	IBOutlet UIToolbar *toolbar;
@property(nonatomic,retain)	IBOutlet UIBarButtonItem *back;
@property(nonatomic,retain)	IBOutlet UIBarButtonItem *forward;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *spaceOne;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *spaceTwo;
@property (retain) NSURL *websiteToUse;
@property (retain) NSString *htmlToLoad;


- (webView *) initWithWebsite:(NSURL *)theWebsite andTitle:(NSString *) titleToUse;
- (webView *) initWithHTMLString:(NSString *)htmlFile;


@end
