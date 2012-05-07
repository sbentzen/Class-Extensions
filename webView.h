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

@property(nonatomic,strong) IBOutlet UIWebView *theWebView;
@property(nonatomic,strong) MBProgressHUD *progress;
@property(nonatomic,strong)	IBOutlet UIToolbar *toolbar;
@property(nonatomic,strong)	IBOutlet UIBarButtonItem *back;
@property(nonatomic,strong)	IBOutlet UIBarButtonItem *forward;
@property(nonatomic,strong) IBOutlet UIBarButtonItem *spaceOne;
@property(nonatomic,strong) IBOutlet UIBarButtonItem *spaceTwo;
@property(nonatomic,strong) NSURL *websiteToUse;
@property(nonatomic,strong) NSString *htmlToLoad;


- (webView *) initWithWebsite:(NSURL *)theWebsite andTitle:(NSString *) titleToUse;
- (webView *) initWithHTMLString:(NSString *)htmlFile;


@end
