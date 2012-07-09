//
//  webView.h
//
//  Created by Shaun on Thursday, April 22 2010.
//  Copyright 2010 SambaWorks. All rights reserved.
//

#import "MBProgressHUD.h"

@interface webView : UIViewController <UIWebViewDelegate,MBProgressHUDDelegate> {
	IBOutlet UIWebView *aWebView;
	NSURL *websiteToUse;
	NSString *htmlToLoad;
	MBProgressHUD *activityIndicator;
	IBOutlet UIToolbar *toolbar;
	IBOutlet UIBarButtonItem *back;
	IBOutlet UIBarButtonItem *forward;
}

@property(nonatomic,strong) IBOutlet UIWebView *aWebView;
@property(nonatomic,strong) MBProgressHUD *activityIndicator;
@property(nonatomic,strong)	IBOutlet UIToolbar *toolbar;
@property(nonatomic,strong)	IBOutlet UIBarButtonItem *back;
@property(nonatomic,strong)	IBOutlet UIBarButtonItem *forward;
@property(nonatomic,strong) NSURL *websiteToUse;
@property(nonatomic,strong) NSString *htmlToLoad;


- (webView *) initWithWebsite:(NSURL *)theWebsite andTitle:(NSString *) titleToUse;
- (webView *) initWithHTMLString:(NSString *)htmlFile;


@end
