//
//  NINMutualFundsController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 23-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINMutualFundsController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{
    
    
    NSXMLParser * xmlFundsCategoryValueCuota;    //permite leer y parsear un xml
    NSXMLParser * xmlFundsSeriesInvestmentsNetas;    //permite leer y parsear un xml
    NSXMLParser * xmlFundsCategoryInvestmentsNetas;    //permite leer y parsear un xml
    
    NSURL *urlFundsCategoryValueCuota;
    NSURL *urlFundsCategoryInvestmentsNetas;
    NSURL *urlFundsSeriesParticipes;

    NSURLRequest *request;
    
    NSMutableString *string;
    
    NSInteger *countAux;
    
    UISegmentedControl *segmentedControl;
    UISegmentedControl *segmentedControlSerie;
    UISegmentedControl *segmentedControlInvestments;
    
    NSString *StrindFundsValueDate;
    NSString *StrindSeriesValueDate;
}

@property (nonatomic, retain) IBOutlet UITableView *tableCategoryShareTop;
@property (nonatomic, retain) IBOutlet UITableView *tableCategoryShareLosers;
@property (nonatomic, retain) IBOutlet UITableView *tableCategoryInvestmentsTop;
@property (nonatomic, retain) IBOutlet UITableView *tableCategoryInvestmentsLosers;
@property (nonatomic, retain) IBOutlet UITableView *tableSeriesShareTop;
@property (nonatomic, retain) IBOutlet UITableView *tableSeriesShareLosers;

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControlSerie;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControlInvestments;

@property (nonatomic, retain) IBOutlet NSString *StrindFundsValueDate;

@end
