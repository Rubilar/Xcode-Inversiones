//
//  NINIndexController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 22-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINIndexController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{
    
    // News
    
    IBOutlet UILabel * viewTitle;
    IBOutlet UILabel * viewDate;
    IBOutlet UILabel * viewDescription;
    IBOutlet UITextView * viewGloss;
    IBOutlet UIImageView * viewImage;
    IBOutlet UIImageView * viewFlag;
    
    UILabel * titleIndexChile;
    UILabel * titleIndexGlobal;
    UILabel * titleCurrency;
    UILabel * titleUtm;
    UILabel * titleUf;
    
    NSMutableArray * noticias;
    
    NSXMLParser * xmlIndexChile;    //permite leer y parsear un xml
    NSXMLParser * xmlIndexGloval;   //permite leer y parsear un xml
    NSXMLParser * xmlIndexMoney;    //permite leer y parsear un xml
    NSXMLParser * xmlIndexUf;       //permite leer y parsear un xml
    NSXMLParser * xmlIndexUtm;      //permite leer y parsear un xml
    
    NSURL *urlIndexChile;
    NSURL *urlIndexGlobal;
    NSURL *urlIndexMoney;
    NSURL *urlIndexUf;
    NSURL *urlIndexUtm;
    
    NSURLRequest *request;
    NSMutableString *string;
    NSInteger *countAux;
}


@property (nonatomic, retain) UIImageView *viewFlag;
@property (nonatomic, retain) IBOutlet UITableView * tableStockChile;
@property (nonatomic, retain) IBOutlet UITableView * tableStockGlobal;
@property (nonatomic, retain) IBOutlet UITableView * tableUf;
@property (nonatomic, retain) IBOutlet UITableView * tableUtm;
@property (nonatomic, retain) IBOutlet UITableView * tableMoney;

@end
