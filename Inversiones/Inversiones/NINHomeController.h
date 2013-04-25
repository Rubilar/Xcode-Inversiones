//
//  NINViewController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 18-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINHomeController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{
    
    IBOutlet UIView *viewIndexs;
    IBOutlet UIView *viewNews;
    IBOutlet UIView *viewActions;
    IBOutlet UIView *viewSynthesis;
    IBOutlet UIView *viewGraphics;
    IBOutlet UIWebView *webNews;
    
    IBOutlet UILabel *labelDate;
    IBOutlet UILabel *labelSynthesis;
    
    // Image Flag
    IBOutlet UIImageView * viewFlag;

    NSXMLParser *xmlIndexChile;    //permite leer y parsear un xml
    NSXMLParser *xmlIndexGloval;   //permite leer y parsear un xml
    NSXMLParser *xmlNewsVF;   //permite leer y parsear un xml
    NSXMLParser *xmlSynthesis;   //permite leer y parsear un xml
    NSXMLParser *xmlBanner;   //permite leer y parsear un xml
    NSXMLParser *xmlActions;   //permite leer y parsear un xml
    
    NSURL *urlIndexChile;
    NSURL *urlIndexGlobal;
    NSURL *urlNewsVF;
    NSURL *urlSynthesis;
    NSURL *urlBanner;
    NSURL *urlActions;
    
    NSURLRequest *request;
    NSMutableString *string;
    NSInteger *countAux;
}

@property (nonatomic, retain) UIWebView *webNews;

@property (nonatomic, retain) IBOutlet UIView *viewSynthesis;
@property (nonatomic, retain) IBOutlet UIView *viewIndexs;
@property (nonatomic, retain) IBOutlet UIView *viewNews;
@property (nonatomic, retain) IBOutlet UIView *viewActions;
@property (nonatomic, retain) IBOutlet UIView *viewGraphics;

@property (nonatomic, retain) UIImageView *viewFlag;
@property (nonatomic, retain) IBOutlet UITableView * tableBanner;

@property (nonatomic, retain) IBOutlet UITableView * tableStockChile;
@property (nonatomic, retain) IBOutlet UITableView * tableStockGlobal;

@property (nonatomic, retain) IBOutlet UITableView * tableStockRecommended;
@property (nonatomic, retain) IBOutlet UITableView * tableMutualFunds;
@property (nonatomic, retain) IBOutlet UITableView * tableNews;

@property (nonatomic, retain) IBOutlet UILabel *labelDate;
@property (nonatomic, retain) IBOutlet UILabel *labelSynthesis;

@property(nonatomic, retain) IBOutlet UIButton *sintesis;

@end
