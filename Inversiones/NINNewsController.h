//
//  NINNewsController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 18-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITextView.h>


@interface NINNewsController :  UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{
    
    // News
    IBOutlet UILabel *viewTitle;
    IBOutlet UILabel *viewDate;
    IBOutlet UILabel *viewDescription;
    IBOutlet UITextView *viewGloss;
    IBOutlet UIImageView *viewImage;
    IBOutlet UIView *viewSynthesis;

    //  Arrays News
    NSURL *urlNews;
    NSURL *urlDetailNews;
    
    NSXMLParser *xmlNews;   //permite leer y parsear un xml
    NSXMLParser *xmlDetailNews;   //permite leer y parsear un xml
    
    NSURLRequest *request;
    NSMutableString *string;
    
    NSInteger *countAux;
    UIWebView *webView;
	NSString *sourceText;
    
    UIActivityIndicatorView *loanding;
    UIImageView *backgroundLoanding;
    UIView *viewNews;
}

@property (nonatomic, retain) IBOutlet UITableView * tableNews;
@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loanding;;
@property (nonatomic, retain) IBOutlet UIImageView *imageArrow;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundLoanding;
@property (nonatomic, retain) IBOutlet UIView *viewNews;
@property (nonatomic, retain) IBOutlet UIButton *buttonPrevious;
@property (nonatomic, retain) IBOutlet UIButton *buttonNexs;

@end

