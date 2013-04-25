//
//  NINRecommendationController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 21-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINActionsController :  UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{

    IBOutlet UILabel * viewCompany;
    IBOutlet UILabel * viewMnemonic;
    IBOutlet UILabel * viewBrokerage;
    IBOutlet UILabel * viewRecommendation;
    IBOutlet UILabel * viewCurrentPrice;
    IBOutlet UILabel * viewPriceTarget;
    IBOutlet UILabel * viewEstimated;
    IBOutlet UILabel * viewDate;
    IBOutlet UILabel * viewNumberStudies;

    // Struct Recomendation
    

    NSArray * arrayFilterRecomendation;
    
    UISegmentedControl *segmentedControl;
    
    NSXMLParser *xmlActions;   //permite leer y parsear un xml
    NSXMLParser *xmlFilterCorredora;   //permite leer y parsear un xml
    NSXMLParser *xmlFilterEmpresa;   //permite leer y parsear un xml
    
    NSURL *urlActions;
    NSURL *urlFilterCorredora;
    NSURL *urlFilterEmpresa;
    
    NSURLRequest *request;
    NSMutableString *string;
    
    NSInteger *countAux;
}

@property(nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property(nonatomic, retain) IBOutlet UIView       *viewAcction;
@property(nonatomic, retain) IBOutlet UITableView  *tableRecomendation;
@property(nonatomic, retain) UIPopoverController   *popoverController;
@property(nonatomic, retain) IBOutlet UIButton     *popoverButton;
@property(nonatomic, retain) IBOutlet UITableView  *tableFilterCorredora;
@property(nonatomic, retain) IBOutlet UITableView  *tableFilterEmpresa;
@property(nonatomic, retain) IBOutlet UITableView  *tableFilterRecomendation;
@property(nonatomic, retain) IBOutlet UIImageView  *arrowCorredora;
@property(nonatomic, retain) IBOutlet UIImageView  *arrowEmpresa;
@property(nonatomic, retain) IBOutlet UIButton     *buttonLast;
@property(nonatomic, retain) IBOutlet UIButton     *buttonUpgrades;
@property(nonatomic, retain) IBOutlet UIButton     *buttonDowgrade;
@property(nonatomic, retain) IBOutlet UIButton     *buttonCorredora;
@property(nonatomic, retain) IBOutlet UIButton     *buttonEmpresa;

@end
