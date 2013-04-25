//
//  NINMutualFundsController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 23-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import "NINAppDelegate.h"
#import "NINHomeController.h"
#import "NINNewsController.h"
#import "NINWebController.h"
#import "NINActionsController.h"
#import "NINIndexController.h"
#import "NINSettingController.h"
#import "NINMutualFundsController.h"
#import "NINFundsSeriesController.h"
#import <QuartzCore/QuartzCore.h>

@implementation NINMutualFundsController
@synthesize segmentedControl;
@synthesize segmentedControlSerie;
@synthesize segmentedControlInvestments;
@synthesize StrindFundsValueDate;


- (void)viewDidLoad
{
    countAux =0;
    StrindFundsValueDate = @"1";
    
    _tableCategoryShareTop.layer.borderColor =[[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableCategoryShareTop.layer.borderWidth = 1;
    
    _tableCategoryShareLosers.layer.borderColor =[[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableCategoryShareLosers.layer.borderWidth = 1;
    
    _tableCategoryInvestmentsTop.layer.borderColor =[[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableCategoryInvestmentsTop.layer.borderWidth = 1;
    
    _tableCategoryInvestmentsLosers.layer.borderColor =[[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableCategoryInvestmentsLosers.layer.borderWidth = 1;
    
    _tableSeriesShareTop.layer.borderColor =[[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableSeriesShareTop.layer.borderWidth = 1;
    
    _tableSeriesShareLosers.layer.borderColor =[[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableSeriesShareLosers.layer.borderWidth = 1;
    
	// Do any additional setup after loading the view.
    
    urlFundsCategoryValueCuota          = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=RentabilidadCategoriasFM"];
    urlFundsCategoryInvestmentsNetas    = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=InversionesCategoriasFM"];
    urlFundsSeriesParticipes            = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=ParticipesCategoriasFM"];
    
    //Array Valor Cuota
    
    NSError* error = nil;
    NSString *URLString = [NSString stringWithContentsOfURL:urlFundsSeriesParticipes encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        [super viewDidLoad];
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [mes show];
    }
    
    if (!arrayFundsSeriesLoserCuotaNameAux || !arrayFundsSeriesLoserCuotaNameAux.count){
        
        arrayFundsValueCuotaName                = [[NSMutableArray alloc] init];
        arrayFundsValueCuotaValue               = [[NSMutableArray alloc] init];
        arrayFundsValueCuotaTipe                = [[NSMutableArray alloc] init];
        arrayFundsValueCuotaTime                = [[NSMutableArray alloc] init];
        // //Array Auxiliares Valor Cuota
        arrayFundsValueWinCuotaNameAux          = [[NSMutableArray alloc] init];
        arrayFundsValueWinCuotaValueAux         = [[NSMutableArray alloc] init];
        arrayFundsValueLoserCuotaNameAux        = [[NSMutableArray alloc] init];
        arrayFundsValueLoserCuotaValueAux       = [[NSMutableArray alloc] init];
        //Array Inversiones netas
        arrayFundsInvestmentsName               = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsValue              = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsPatrimony          = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsTipe               = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsTime               = [[NSMutableArray alloc] init];
        // //Array Inversiones netas Aux
        arrayFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
        arrayFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
        //Array Series Cuota
        arrayFundsSeriesCuotaName  = [[NSMutableArray alloc] init];
        arrayFundsSeriesCuotaValue = [[NSMutableArray alloc] init];
        arrayFundsSeriesCuotaTipe  = [[NSMutableArray alloc] init];
        arrayFundsSeriesCuotaTime  = [[NSMutableArray alloc] init];
        arrayFundsSeriesCuotaPatrimony  = [[NSMutableArray alloc] init];
    // //Array Auxiliar Series Cuota
        arrayFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
        arrayFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
        arrayFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
        arrayFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
        arrayFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
        arrayFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
    //Delegate Xmls
      [self performSelector:@selector(startShowing) withObject:nil afterDelay:0.1f]; 
        
    }
    
}




-(void) startShowing{

    xmlFundsCategoryValueCuota = [[NSXMLParser alloc] initWithContentsOfURL:urlFundsCategoryValueCuota];
    [xmlFundsCategoryValueCuota setDelegate:self]; //delegamos desde el xml a self
    [xmlFundsCategoryValueCuota parse]; //inicializa la rutina de parse
    
    xmlFundsSeriesInvestmentsNetas = [[NSXMLParser alloc] initWithContentsOfURL:urlFundsSeriesParticipes];
    [xmlFundsSeriesInvestmentsNetas setDelegate:self]; //delegamos desde el xml a self
    [xmlFundsSeriesInvestmentsNetas parse]; //inicializa la rutina de parse
    
    xmlFundsCategoryInvestmentsNetas = [[NSXMLParser alloc] initWithContentsOfURL:urlFundsCategoryInvestmentsNetas];
    [xmlFundsCategoryInvestmentsNetas setDelegate:self]; //delegamos desde el xml a self
    [xmlFundsCategoryInvestmentsNetas parse]; //inicializa la rutina de parse
    
    [_tableSeriesShareTop    reloadData];
    [_tableSeriesShareLosers reloadData];
    
    [_tableCategoryInvestmentsTop reloadData];
    [_tableCategoryInvestmentsLosers reloadData];
    
    [_tableCategoryShareTop    reloadData];
    [_tableCategoryShareLosers reloadData];
    
    NSError* error = nil;
    NSString *URLString = [NSString stringWithContentsOfURL:urlFundsSeriesParticipes encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        
        NSString *alertString = @"";
        
        if([arrayFundsValueCuotaName count]==0){
            alertString = [NSString stringWithFormat:@"%@ Rentabilidad ",alertString];
        }
        if([arrayFundsInvestmentsName count]==0){
            alertString = [NSString stringWithFormat:@"%@,Participes ",alertString];
        }
        if([arrayFundsSeriesCuotaName count]==0){
            alertString = [NSString stringWithFormat:@"%@,Inversiones Netas ",alertString];
        }
        if(alertString.length>1){
            alertString = [NSString stringWithFormat:@"Problemas con la data de: %@.",alertString];
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Alerta" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [mes show];
        }
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [mes show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//parecer XML

//Se ejecuta al abrir nodo raiz
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    
    string = [[NSMutableString alloc] init ];
}

//Se ejeucta cuando un nodo se abre
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
}

//se ejecuta cuando el contenido dentro del nodo
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s{
    
    [string appendString:s];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSMutableDictionary * item = [[NSMutableDictionary alloc] init ];
    
    // Global
    if(countAux==0){
        if ([elementName isEqualToString:@"categoria"])
        {
            [item setObject:string forKey:@"categoria"];
            [arrayFundsValueCuotaName addObject:item];
            
        }
        if ([elementName isEqualToString:@"tipo"])
        {
            [item setObject:string forKey:@"tipo"];
            [arrayFundsValueCuotaTipe addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arrayFundsValueCuotaValue addObject:item];
        }
        if ([elementName isEqualToString:@"orden_display"])
        {
            [item setObject:string forKey:@"orden_display"];
            [arrayFundsValueCuotaTime addObject:item];
        }
    }
    
    if(countAux==4){
        if ([elementName isEqualToString:@"categoria"])
        {
            [item setObject:string forKey:@"categoria"];
            [arrayFundsInvestmentsName addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arrayFundsInvestmentsValue addObject:item];
        }
        if ([elementName isEqualToString:@"participes"])
        {
            [item setObject:string forKey:@"participes"];
            [arrayFundsInvestmentsPatrimony addObject:item];
        }
        if ([elementName isEqualToString:@"tipo"])
        {
            [item setObject:string forKey:@"tipo"];
            [arrayFundsInvestmentsTipe addObject:item];
        }
        if ([elementName isEqualToString:@"orden_display"])
        {
            [item setObject:string forKey:@"orden_display"];
            [arrayFundsInvestmentsTime addObject:item];
        }
    }
    
    if(countAux==8){
        if ([elementName isEqualToString:@"categoria"])
        {
            [item setObject:string forKey:@"categoria"];
            [arrayFundsSeriesCuotaName addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arrayFundsSeriesCuotaValue addObject:item];
        }
        if ([elementName isEqualToString:@"tipo"])
        {
            [item setObject:string forKey:@"tipo"];
            [arrayFundsSeriesCuotaTipe addObject:item];
        }
        if ([elementName isEqualToString:@"orden_display"])
        {
            [item setObject:string forKey:@"orden_display"];
            [arrayFundsSeriesCuotaTime addObject:item];
        }
        if ([elementName isEqualToString:@"patrimonio"])
        {
            [item setObject:string forKey:@"patrimonio"];
            [arrayFundsSeriesCuotaPatrimony addObject:item];
        }
    }
    item=nil;
    string = [NSMutableString string]; //limpiamos el string
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    countAux = ++countAux;
    //NSLog(@"%@",arrayFundsSeriesCuotaTipe);
}

// end Parcer

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    
    // Array Categoria Valor cuota - Ganadoras
    if(tableView == _tableCategoryInvestmentsTop){
        for(NSInteger j=0;([arrayFundsValueCuotaName count])>j;j++)
        {
            NSString *stringTimeAux = [[arrayFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arrayFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                
                NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                [arrayFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arrayFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
            }
            
        }
        
        return [arrayFundsValueWinCuotaNameAux count];
    }
    
    // Array Categoria Valor cuota - Perdedoras
    if(tableView == _tableCategoryInvestmentsLosers){
        for(NSInteger j=0;([arrayFundsValueCuotaName count])>j;j++)
        {
            NSString *stringTimeAux = [[arrayFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arrayFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                
                NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                [arrayFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arrayFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
            }
        }
        return [arrayFundsValueLoserCuotaNameAux count];
    }
    
    // Array Categoria Inversion Neta
    
    if(tableView == _tableCategoryShareTop){
        for(NSInteger j=0;([arrayFundsInvestmentsName count])>j;j++)
        {
            
            NSString *stringTimeAux = [[arrayFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arrayFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                
                NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                [arrayFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                [arrayFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arrayFundsInvestmentsPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                [arrayFundsInvestmentsWinPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                
            }
        }
        return [arrayFundsInvestmentsWinNameAux count];
    }
    
    // Array Categoria Inversion Neta
    
    if(tableView == _tableCategoryShareLosers){
        for(NSInteger j=0;([arrayFundsInvestmentsName count])>j;j++)
        {
            NSString *stringTimeAux = [[arrayFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arrayFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                
                NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                [arrayFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                [arrayFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arrayFundsInvestmentsPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                [arrayFundsInvestmentsLoserPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
            }
        }
        return [arrayFundsInvestmentsLoserNameAux count];
    }
    
    //Participes
    
    if(tableView == _tableSeriesShareTop){
        for(NSInteger j=0;([arrayFundsSeriesCuotaName count])>j;j++)
        {
            NSString *stringTimeAux = [[arrayFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arrayFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Inversiones"])){
                
                NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                [arrayFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arrayFundsSeriesCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arrayFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                [arrayFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
            }
            
        }
        return [arrayFundsSeriesWinCuotaNameAux count];
    }
    
    if(tableView == _tableSeriesShareLosers){
        for(NSInteger j=0;([arrayFundsSeriesCuotaName count])>j;j++)
        {
            NSString *stringTimeAux = [[arrayFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arrayFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Inversiones"])){
                
                NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                [arrayFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arrayFundsSeriesCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arrayFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                [arrayFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
            }
            
        }
        return [arrayFundsSeriesLoserCuotaNameAux count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCellStyleSubtitle tabla con subtitulo
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        if(tableView == _tableCategoryShareTop){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(tableView == _tableCategoryShareLosers){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(tableView == _tableCategoryInvestmentsTop){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(tableView == _tableCategoryInvestmentsLosers){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(tableView == _tableSeriesShareTop){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(tableView == _tableSeriesShareLosers){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    if(tableView == _tableCategoryInvestmentsTop){
        
        CGRect frameInvestmentsTop = CGRectMake(10, 5, 240, 25);
        UILabel *labelInvestmentsTop = [[UILabel alloc] initWithFrame:frameInvestmentsTop];
        labelInvestmentsTop.backgroundColor = [UIColor whiteColor];
        labelInvestmentsTop.font = [UIFont boldSystemFontOfSize:13];
        labelInvestmentsTop.highlightedTextColor = [UIColor whiteColor];
        labelInvestmentsTop.text = [arrayFundsValueWinCuotaNameAux  objectAtIndex:indexPath.row];
        labelInvestmentsTop.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelInvestmentsTop];
        
        NSString *strFloat  = [[arrayFundsValueWinCuotaValueAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        CGRect varFrame = CGRectMake(280, 5, 50, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        albumLabel.textColor = [UIColor blackColor];
        albumLabel.textAlignment = NSTextAlignmentRight;
        
        [cell.contentView addSubview:albumLabel];
    }
    
    if(tableView == _tableCategoryInvestmentsLosers){
        
        CGRect frameInvestmentsLosersValue = CGRectMake(10, 5, 240, 25);
        UILabel *lableInvestmentsLosersValue = [[UILabel alloc] initWithFrame:frameInvestmentsLosersValue];
        lableInvestmentsLosersValue.backgroundColor = [UIColor whiteColor];
        lableInvestmentsLosersValue.font = [UIFont boldSystemFontOfSize:13];
        lableInvestmentsLosersValue.highlightedTextColor = [UIColor whiteColor];
        lableInvestmentsLosersValue.textColor = [UIColor blackColor];
        lableInvestmentsLosersValue.text =[arrayFundsValueLoserCuotaNameAux  objectAtIndex:indexPath.row];
        
        
        [cell.contentView addSubview:lableInvestmentsLosersValue];
        
        
        NSString *strFloat  = [[arrayFundsValueLoserCuotaValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        CGRect frameInvestmentsLosers = CGRectMake(280, 5, 50, 25);
        UILabel *labelInvestmentsLosers = [[UILabel alloc] initWithFrame:frameInvestmentsLosers] ;
        labelInvestmentsLosers.backgroundColor = [UIColor whiteColor];
        labelInvestmentsLosers.font = [UIFont systemFontOfSize:13];
        labelInvestmentsLosers.highlightedTextColor = [UIColor whiteColor];
        labelInvestmentsLosers.text = formattedNumber;
        labelInvestmentsLosers.textAlignment = NSTextAlignmentRight;
        labelInvestmentsLosers.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:labelInvestmentsLosers];
    }
    
    if(tableView == _tableCategoryShareTop){
        
        CGRect artistFrame = CGRectMake(10, 5, 200, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:12];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [arrayFundsInvestmentsWinNameAux  objectAtIndex:indexPath.row];
        artistLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:artistLabel];
        
        NSString *strFloat  = [[arrayFundsInvestmentsWinValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        CGRect varFrame = CGRectMake(290, 5, 50, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:12];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        albumLabel.textAlignment = NSTextAlignmentRight;
        albumLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:albumLabel];
        
        NSString *number = [[arrayFundsInvestmentsWinPatrimonyAux objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect framePatrimony = CGRectMake(200, 5, 60, 25);
        UILabel *labelPatrimony = [[UILabel alloc] initWithFrame:framePatrimony] ;
        labelPatrimony.backgroundColor = [UIColor whiteColor];
        labelPatrimony.font = [UIFont systemFontOfSize:12];
        labelPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelPatrimony.text = newString;
        labelPatrimony.textAlignment = NSTextAlignmentRight;
        labelPatrimony.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelPatrimony];
    }
    
    if(tableView == _tableCategoryShareLosers ){
        
        CGRect artistFrame = CGRectMake(10, 5, 200, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:12];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [arrayFundsInvestmentsLoserNameAux  objectAtIndex:indexPath.row];
        artistLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:artistLabel];
        
        NSString *strFloat  = [[arrayFundsInvestmentsLoserValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        CGRect varFrame = CGRectMake(290, 5, 50, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:12];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        albumLabel.textAlignment = NSTextAlignmentRight;
        albumLabel.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:albumLabel];
        
        NSString *number = [[arrayFundsInvestmentsLoserPatrimonyAux objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect framePatrimony = CGRectMake(200, 5, 60, 25);
        UILabel *labelPatrimony = [[UILabel alloc] initWithFrame:framePatrimony] ;
        labelPatrimony.backgroundColor = [UIColor whiteColor];
        labelPatrimony.font = [UIFont systemFontOfSize:12];
        labelPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelPatrimony.text = newString;
        labelPatrimony.textAlignment = NSTextAlignmentRight;
        labelPatrimony.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:labelPatrimony];
    }
    
    
    if(tableView == _tableSeriesShareTop){
        
        CGRect frameShareTop = CGRectMake(10, 5, 160, 25);
        
        UILabel *labelShareTop = [[UILabel alloc] initWithFrame:frameShareTop];
        labelShareTop.backgroundColor = [UIColor whiteColor];
        labelShareTop.font = [UIFont boldSystemFontOfSize:11];
        labelShareTop.highlightedTextColor = [UIColor whiteColor];
        labelShareTop.text = [arrayFundsSeriesWinCuotaNameAux  objectAtIndex:indexPath.row];
        labelShareTop.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareTop];
        
        NSString *strFloat  = [[arrayFundsSeriesWinCuotaValueAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        CGRect frameShareTopValue = CGRectMake(290, 5, 50, 25);
        
        UILabel *labelShareTopValue = [[UILabel alloc] initWithFrame:frameShareTopValue];
        labelShareTopValue.backgroundColor = [UIColor whiteColor];
        labelShareTopValue.font = [UIFont systemFontOfSize:12];
        labelShareTopValue.highlightedTextColor = [UIColor whiteColor];
        labelShareTopValue.text = formattedNumber;
        labelShareTopValue.textAlignment = NSTextAlignmentRight;
        labelShareTopValue.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareTopValue];
        
        NSString *number = [[arrayFundsSeriesWinCuotaPatrimonyAux objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect frameSeriesPatrimony = CGRectMake(160, 5, 120, 25);
        UILabel *labelSeriesPatrimony = [[UILabel alloc] initWithFrame:frameSeriesPatrimony];
        labelSeriesPatrimony.backgroundColor = [UIColor whiteColor];
        labelSeriesPatrimony.font = [UIFont systemFontOfSize:12];
        labelSeriesPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelSeriesPatrimony.text = newString;
        labelSeriesPatrimony.textAlignment = NSTextAlignmentRight;
        labelSeriesPatrimony.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelSeriesPatrimony];
    }
    
    if(tableView == _tableSeriesShareLosers){
        
        CGRect frameShareLosers = CGRectMake(10, 5, 160, 25);
        UILabel *labelShareLosers = [[UILabel alloc] initWithFrame:frameShareLosers];
        labelShareLosers.backgroundColor = [UIColor whiteColor];
        labelShareLosers.font = [UIFont boldSystemFontOfSize:11];
        labelShareLosers.highlightedTextColor = [UIColor whiteColor];
        labelShareLosers.text = [arrayFundsSeriesLoserCuotaNameAux  objectAtIndex:indexPath.row];
        labelShareLosers.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareLosers];
        
        NSString *strFloat  = [[arrayFundsSeriesLoserCuotaValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        CGRect frameShareLosersValue = CGRectMake(290, 5, 50, 25);
        
        UILabel *labelShareLosersValue = [[UILabel alloc] initWithFrame:frameShareLosersValue];
        labelShareLosersValue.backgroundColor = [UIColor whiteColor];
        labelShareLosersValue.font = [UIFont systemFontOfSize:12];
        labelShareLosersValue.highlightedTextColor = [UIColor whiteColor];
        labelShareLosersValue.text = formattedNumber;
        labelShareLosersValue.textAlignment = NSTextAlignmentRight;
        labelShareLosersValue.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:labelShareLosersValue];
        
        NSString *number = [[arrayFundsSeriesLoserCuotaPatrimonyAux objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect frameSeriesPatrimony = CGRectMake(160, 5, 120, 25);
        UILabel *labelSeriesPatrimony = [[UILabel alloc] initWithFrame:frameSeriesPatrimony];
        labelSeriesPatrimony.backgroundColor = [UIColor whiteColor];
        labelSeriesPatrimony.font = [UIFont systemFontOfSize:12];
        labelSeriesPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelSeriesPatrimony.text = newString;
        labelSeriesPatrimony.textAlignment = NSTextAlignmentRight;
        labelSeriesPatrimony.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:labelSeriesPatrimony];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (IBAction) closeView:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)changeViewNews:(id)sender{
    NINNewsController *viewNews;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewNews =[[NINNewsController alloc] initWithNibName:@"NINNewsView_iPad" bundle:nil];
    } else {
        viewNews =[[NINNewsController alloc] initWithNibName:@"NINNewsView_iPad" bundle:nil];
    }
    viewNews.modalPresentationStyle = UIModalPresentationFullScreen;
    viewNews.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewNews animated:NO completion:nil];
}

-(IBAction)changeViewWeb:(id)sender{
    NINWebController *viewWeb;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewWeb =[[NINWebController alloc] initWithNibName:@"NINWebView_iPad" bundle:nil];
    } else {
        viewWeb =[[NINWebController alloc] initWithNibName:@"NINWebView_iPad" bundle:nil];
    }
    viewWeb.modalPresentationStyle = UIModalPresentationFullScreen;
    viewWeb.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:viewWeb animated:YES completion:nil];
}

-(IBAction)changeViewRecomendation:(id)sender{
    NINActionsController *viewRecomendation;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewRecomendation =[[NINActionsController alloc] initWithNibName:@"NINActionsView_iPad" bundle:nil];
    } else {
        viewRecomendation =[[NINActionsController alloc] initWithNibName:@"NINActionsView_iPad" bundle:nil];
    }
    viewRecomendation.modalPresentationStyle = UIModalPresentationFullScreen;
    viewRecomendation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewRecomendation animated:NO completion:nil];
}

-(IBAction)changeViewIndex:(id)sender{
    NINIndexController *viewIndex;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewIndex =[[NINIndexController alloc] initWithNibName:@"NINIndexView_iPad" bundle:nil];
    } else {
        viewIndex =[[NINIndexController alloc] initWithNibName:@"NINIndexView_iPad" bundle:nil];
    }
    viewIndex.modalPresentationStyle = UIModalPresentationFullScreen;
    viewIndex.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewIndex animated:NO completion:nil];
}

-(IBAction)changeViewHome:(id)sender{
    NINHomeController *viewHome;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewHome =[[NINHomeController alloc] initWithNibName:@"NINHomeView_iPad" bundle:nil];
    } else {
        viewHome =[[NINHomeController alloc] initWithNibName:@"NINHomeView_iPad" bundle:nil];
    }
    viewHome.modalPresentationStyle = UIModalPresentationFullScreen;
    viewHome.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewHome animated:NO completion:nil];
}

-(IBAction)changeViewSetting:(id)sender{
    NINSettingController *viewSetting;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewSetting =[[NINSettingController alloc] initWithNibName:@"NINSettingView_iPad" bundle:nil];
    } else {
        viewSetting =[[NINSettingController alloc] initWithNibName:@"NINSettingView_iPad" bundle:nil];
    }
    viewSetting.modalPresentationStyle = UIModalPresentationFullScreen;
    viewSetting.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewSetting animated:NO completion:nil];
}

-(IBAction)changeFundsSeries:(id)sender{
    NINFundsSeriesController *viewSeries;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewSeries =[[NINFundsSeriesController alloc] initWithNibName:@"NINFundsSeriesView_iPad" bundle:nil];
    } else {
        viewSeries =[[NINFundsSeriesController alloc] initWithNibName:@"NINFundsSeriesView_iPad" bundle:nil];
    }
    viewSeries.modalPresentationStyle = UIModalPresentationFullScreen;
    viewSeries.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:viewSeries animated:YES completion:nil];
}


-(IBAction) segmentedControlInvestmentsChanged{
    switch (self.segmentedControlInvestments.selectedSegmentIndex) {
        case 0:
            StrindFundsValueDate = @"1";
            arrayFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsInvestmentsWinNameAux count])>j;j++)
            {
                
                NSString *stringTimeAux = [[arrayFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryShareTop    reloadData];
            [_tableCategoryShareLosers reloadData];

            break;
        case 1:
            StrindFundsValueDate = @"3";
            arrayFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsInvestmentsWinNameAux count])>j;j++)
            {
                
                NSString *stringTimeAux = [[arrayFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryShareTop    reloadData];
            [_tableCategoryShareLosers reloadData];
            
            break;
            
        case 2:
            StrindFundsValueDate = @"5";
            arrayFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
            arrayFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsInvestmentsWinNameAux count])>j;j++)
            {
                
                NSString *stringTimeAux = [[arrayFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsInvestmentsName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryShareTop    reloadData];
            [_tableCategoryShareLosers reloadData];

            break;
        default:
            break;
    }
}

-(IBAction) segmentedSerieIndexChanged{
    switch (self.segmentedControlSerie.selectedSegmentIndex) {
        case 0:
            StrindFundsValueDate = @"1";
            arrayFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsSeriesWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arrayFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                    [arrayFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                    [arrayFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
            }
            [_tableSeriesShareTop    reloadData];
            [_tableSeriesShareLosers reloadData];

            break;
        case 1:
            StrindFundsValueDate = @"3";
            arrayFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsSeriesWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arrayFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                    [arrayFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                    [arrayFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
            }
            [_tableSeriesShareTop    reloadData];
            [_tableSeriesShareLosers reloadData];

            break;
            
        case 2:
            StrindFundsValueDate = @"5";
            arrayFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsSeriesWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arrayFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                    [arrayFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arrayFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arrayFundsSeriesCuotaPatrimony objectAtIndex:j] objectForKey:@"patrimonio"];
                    [arrayFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
            }
            [_tableSeriesShareTop    reloadData];
            [_tableSeriesShareLosers reloadData];

            break;
        default:
            break;
    }
}



-(IBAction) segmentedControlIndexChanged{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            StrindFundsValueDate = @"1";
            arrayFundsValueWinCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsValueWinCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsValueLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsValueLoserCuotaValueAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsValueWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arrayFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    
                    NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryInvestmentsTop    reloadData];
            [_tableCategoryInvestmentsLosers reloadData];

            break;
        case 1:
            StrindFundsValueDate = @"3";
            arrayFundsValueWinCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsValueWinCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsValueLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsValueLoserCuotaValueAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsValueWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arrayFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            [_tableCategoryInvestmentsTop reloadData];
            [_tableCategoryInvestmentsLosers reloadData];

            break;
            
        case 2:
            StrindFundsValueDate = @"5";
            arrayFundsValueWinCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsValueWinCuotaValueAux = [[NSMutableArray alloc] init];
            arrayFundsValueLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arrayFundsValueLoserCuotaValueAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arrayFundsValueWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arrayFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arrayFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    
                    NSString  *auxCategory = [[arrayFundsValueCuotaName  objectAtIndex:j] objectForKey:@"categoria"];
                    [arrayFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arrayFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arrayFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            [_tableCategoryInvestmentsTop reloadData];
            [_tableCategoryInvestmentsLosers reloadData];
            break;
        default:
            break;
    }
}

@end
