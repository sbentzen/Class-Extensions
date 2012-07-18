//
//  webView.h
//
//  Created by Shaun on Thursday, April 22 2010.
//  Copyright 2010 SambaWorks. All rights reserved.
//

#import "MBProgressHUD.h"

/** 
 * My convinience webview class, With… a toolbar for back and forward buttons, and all __You__ have to do is supply the images.
 */
@interface webView : UIViewController <UIWebViewDelegate,MBProgressHUDDelegate> {
	UIWebView *aWebView;
	NSURL *websiteToUse;
	NSString *htmlToLoad;
	MBProgressHUD *activityIndicator;
	UIToolbar *toolbar;
	UIBarButtonItem *back;
	UIBarButtonItem *forward;
}

/** @name Properties*/


/** The webview that loads the webpage*/
@property(nonatomic,strong) UIWebView *aWebView;
/** an activity indicator, saying that the page is loading*/
@property(nonatomic,strong) MBProgressHUD *activityIndicator;
/** the toolbar*/
@property(nonatomic,strong)	UIToolbar *toolbar;
/** the back button*/
@property(nonatomic,strong)	UIBarButtonItem *back;
/** The forward button*/
@property(nonatomic,strong)	UIBarButtonItem *forward;
/** The website (URL) to go to*/
@property(nonatomic,strong) NSURL *websiteToUse;
/** an html document to load into the webview*/
@property(nonatomic,strong) NSString *htmlToLoad;

/**@name Methods */

/** Initializer method. It initalizes with a website to load and the title to place into the nav bar.
 * @param theWebsite what website to load
 * @param titleToUse what title should be placed into the nav bar
 */
- (webView *) initWithWebsite:(NSURL *)theWebsite andTitle:(NSString *) titleToUse;
/** Another initializer method.
 * This one initalizes with an HTML document
 * @param htmlFile the HTML file in NSString form.
 */
- (webView *) initWithHTMLString:(NSString *)htmlFile;


@end
