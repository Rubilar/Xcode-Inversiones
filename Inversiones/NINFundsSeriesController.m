//
//  NINFundsSeriesController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 15-03-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//
#import "NINAppDelegate.h"
#import "NINFundsSeriesController.h"
#import <QuartzCore/QuartzCore.h>

@interface NINFundsSeriesController ()

@end

@implementation NINFundsSeriesController
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
    
    urlFundsCategoryValueCuota          = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=RentabilidadSeriesFM"];
    urlFundsCategoryInvestmentsNetas    = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=ParticipesSeriesFM"];
    urlFundsSeriesParticipes            = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=InversionesSeriesFM"];
    
    NSError* error = nil;
    NSString *URLString = [NSString stringWithContentsOfURL:urlFundsSeriesParticipes encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        [super viewDidLoad];
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [mes show];
    }
    
    //Array Valor Cuota
    if (!arraySeriesFundsValueWinCuotaValueAux || !arraySeriesFundsValueWinCuotaValueAux.count){
        arraySeriesFundsValueCuotaName                = [[NSMutableArray alloc] init];
        arraySeriesFundsValueCuotaValue               = [[NSMutableArray alloc] init];
        arraySeriesFundsValueCuotaTipe                = [[NSMutableArray alloc] init];
        arraySeriesFundsValueCuotaTime                = [[NSMutableArray alloc] init];
    
        // //Array Auxiliares Valor Cuota
    
        arraySeriesFundsValueWinCuotaNameAux          = [[NSMutableArray alloc] init];
        arraySeriesFundsValueWinCuotaValueAux         = [[NSMutableArray alloc] init];
    
        arraySeriesFundsValueLoserCuotaNameAux        = [[NSMutableArray alloc] init];
        arraySeriesFundsValueLoserCuotaValueAux       = [[NSMutableArray alloc] init];
    
        //Array Inversiones netas
    
        arraySeriesFundsInvestmentsName               = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsValue              = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsPatrimony          = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsTipe               = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsTime               = [[NSMutableArray alloc] init];
    
        // //Array Inversiones netas Aux
    
    
        arraySeriesFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
    
        arraySeriesFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
        arraySeriesFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
    
    
        //Array Series Cuota
            
        arraySeriesFundsSeriesCuotaName  = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesCuotaValue = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesCuotaTipe  = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesCuotaTime  = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesCuotaPatrimony = [[NSMutableArray alloc] init];
    
        // //Array Auxiliar Series Cuota
    
        arraySeriesFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
    
    
        arraySeriesFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
        arraySeriesFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
    
        //Delegate Xmls
    }
    

}
-(void)viewDidAppear:(BOOL)animated {
    
    if (!arraySeriesFundsValueWinCuotaValueAux || !arraySeriesFundsValueWinCuotaValueAux.count){

        xmlFundsCategoryValueCuota = [[NSXMLParser alloc] initWithContentsOfURL:urlFundsCategoryValueCuota];
        [xmlFundsCategoryValueCuota setDelegate:self]; //delegamos desde el xml a self
        [xmlFundsCategoryValueCuota parse]; //inicializa la rutina de parse
    
        xmlFundsCategoryInvestmentsNetas = [[NSXMLParser alloc] initWithContentsOfURL:urlFundsCategoryInvestmentsNetas];
        [xmlFundsCategoryInvestmentsNetas setDelegate:self]; //delegamos desde el xml a self
        [xmlFundsCategoryInvestmentsNetas parse]; //inicializa la rutina de parse
    
        xmlFundsSeriesInvestmentsNetas = [[NSXMLParser alloc] initWithContentsOfURL:urlFundsSeriesParticipes];
        [xmlFundsSeriesInvestmentsNetas setDelegate:self]; //delegamos desde el xml a self
        [xmlFundsSeriesInvestmentsNetas parse]; //inicializa la rutina de parse
    
        [_tableCategoryShareTop    reloadData];
        [_tableCategoryShareLosers reloadData];
    
        [_tableSeriesShareTop    reloadData];
        [_tableSeriesShareLosers reloadData];
    
        [_tableCategoryInvestmentsTop reloadData];
        [_tableCategoryInvestmentsLosers reloadData];
    
        [super viewDidAppear:animated];
    
        //code to reload table viewdata
        
        NSError* error = nil;
        NSString *URLString = [NSString stringWithContentsOfURL:urlFundsSeriesParticipes encoding:NSASCIIStringEncoding error:&error];
        if ( URLString != NULL ) {
            
            NSString *alertString = @"";
            
            if([arraySeriesFundsValueCuotaName count]==0){
                alertString = [NSString stringWithFormat:@"%@ Rentabilidad ",alertString];
            }
            if([arraySeriesFundsInvestmentsName count]==0){
                alertString = [NSString stringWithFormat:@"%@,Participes ",alertString];
            }
            if([arraySeriesFundsSeriesCuotaName count]==0){
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
        if ([elementName isEqualToString:@"nombre_serie"])
        {
            [item setObject:string forKey:@"nombre_serie"];
            [arraySeriesFundsValueCuotaName addObject:item];
            
        }
        if ([elementName isEqualToString:@"tipo"])
        {
            [item setObject:string forKey:@"tipo"];
            [arraySeriesFundsValueCuotaTipe addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arraySeriesFundsValueCuotaValue addObject:item];
        }
        if ([elementName isEqualToString:@"orden_display"])
        {
            [item setObject:string forKey:@"orden_display"];
            [arraySeriesFundsValueCuotaTime addObject:item];
        }
    }
    
    if(countAux==4){
        if ([elementName isEqualToString:@"nombre_serie"])
        {
            [item setObject:string forKey:@"nombre_serie"];
            [arraySeriesFundsInvestmentsName addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arraySeriesFundsInvestmentsValue addObject:item];
        }
        if ([elementName isEqualToString:@"tipo"])
        {
            [item setObject:string forKey:@"tipo"];
            [arraySeriesFundsInvestmentsTipe addObject:item];
        }
        if ([elementName isEqualToString:@"orden_display"])
        {
            [item setObject:string forKey:@"orden_display"];
            [arraySeriesFundsInvestmentsTime addObject:item];
        }
        if ([elementName isEqualToString:@"participes"])
        {
            [item setObject:string forKey:@"participes"];
            [arraySeriesFundsInvestmentsPatrimony addObject:item];
        }
    }
    
    if(countAux==8){
        if ([elementName isEqualToString:@"nombre_serie"])
        {
            [item setObject:string forKey:@"nombre_serie"];
            [arraySeriesFundsSeriesCuotaName addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arraySeriesFundsSeriesCuotaValue addObject:item];
        }
        if ([elementName isEqualToString:@"tipo"])
        {
            [item setObject:string forKey:@"tipo"];
            [arraySeriesFundsSeriesCuotaTipe addObject:item];
        }
        if ([elementName isEqualToString:@"orden_display"])
        {
            [item setObject:string forKey:@"orden_display"];
            [arraySeriesFundsSeriesCuotaTime addObject:item];
        }
        if ([elementName isEqualToString:@"participes"])
        {
            [item setObject:string forKey:@"participes"];
            [arraySeriesFundsSeriesCuotaPatrimony addObject:item];
        }
    }
    
    item=nil;
    string = [NSMutableString string]; //limpiamos el string
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    countAux = ++countAux;
   //NSLog(@"%@",arraySeriesFundsInvestmentsPatrimony);
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
        for(NSInteger j=0;([arraySeriesFundsValueCuotaName count])>j;j++)
        {
            NSString *stringTimeAux = [[arraySeriesFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arraySeriesFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                
                NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                [arraySeriesFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arraySeriesFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
            }
            
        }
        return [arraySeriesFundsValueWinCuotaNameAux count];
    }
    
    // Array Categoria Valor cuota - Perdedoras
    if(tableView == _tableCategoryInvestmentsLosers){
        for(NSInteger j=0;([arraySeriesFundsValueCuotaName count])>j;j++)
        {
            NSString *stringTimeAux = [[arraySeriesFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arraySeriesFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                
                NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                [arraySeriesFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arraySeriesFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
            }
        }
        return [arraySeriesFundsValueLoserCuotaNameAux count];
    }
    
    // Participes//
    
    if(tableView == _tableCategoryShareTop){
        for(NSInteger j=0;([arraySeriesFundsInvestmentsName count])>j;j++)
        {
            
            NSString *stringTimeAux = [[arraySeriesFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arraySeriesFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                
                NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                [arraySeriesFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                [arraySeriesFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arraySeriesFundsInvestmentsPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                [arraySeriesFundsInvestmentsWinPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
            }
        }
        return [arraySeriesFundsInvestmentsWinNameAux count];
    }
    
    if(tableView == _tableCategoryShareLosers){
        for(NSInteger j=0;([arraySeriesFundsInvestmentsName count])>j;j++)
        {
            NSString *stringTimeAux = [[arraySeriesFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arraySeriesFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
            
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                
                NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                [arraySeriesFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                [arraySeriesFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arraySeriesFundsInvestmentsPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                [arraySeriesFundsInvestmentsLoserPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                
            }
        }
        return [arraySeriesFundsInvestmentsLoserNameAux count];
    }
    
    //Series
    
    if(tableView == _tableSeriesShareTop){
        for(NSInteger j=0;([arraySeriesFundsSeriesCuotaName count])>j;j++){
            NSString *stringTimeAux = [[arraySeriesFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arraySeriesFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Inversiones"])){
                
                NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                [arraySeriesFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arraySeriesFundsSeriesCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arraySeriesFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                [arraySeriesFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
            }
            
        }
        return [arraySeriesFundsSeriesWinCuotaNameAux count];
    }
    
    if(tableView == _tableSeriesShareLosers){
        for(NSInteger j=0;([arraySeriesFundsSeriesCuotaName count])>j;j++){
            NSString *stringTimeAux = [[arraySeriesFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
            NSString *stringTipeAux = [[arraySeriesFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
            if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Inversiones"])){
                
                NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                [arraySeriesFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                
                NSString *auxValue = [[arraySeriesFundsSeriesCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                [arraySeriesFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                
                NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                [arraySeriesFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
            }
            
        }
        return [arraySeriesFundsSeriesLoserCuotaNameAux count];
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
        labelInvestmentsTop.text = [arraySeriesFundsValueWinCuotaNameAux  objectAtIndex:indexPath.row];
        labelInvestmentsTop.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelInvestmentsTop];
        
        //funcion
        NSString *strFloat  = [[arraySeriesFundsValueWinCuotaValueAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        
        
        CGRect varFrame = CGRectMake(280, 5, 50, 35);
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
        lableInvestmentsLosersValue.text =[arraySeriesFundsValueLoserCuotaNameAux  objectAtIndex:indexPath.row];
        [cell.contentView addSubview:lableInvestmentsLosersValue];
        
        //funcion
        NSString *strFloat  = [[arraySeriesFundsValueLoserCuotaValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE<(100*-1)) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        
        
        CGRect frameInvestmentsLosers = CGRectMake(250, 5, 80, 25);
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
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [arraySeriesFundsInvestmentsWinNameAux  objectAtIndex:indexPath.row];
        artistLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:artistLabel];
        
        //funcion
        NSString *strFloat  = [[arraySeriesFundsInvestmentsWinValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        
        
        CGRect varFrame = CGRectMake(280, 5, 60, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        albumLabel.textAlignment = NSTextAlignmentRight;
        albumLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:albumLabel];
        
        NSString *number = [[arraySeriesFundsInvestmentsWinPatrimonyAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect framePatrimony = CGRectMake(200, 5, 60, 25);
        UILabel *labelPatrimony = [[UILabel alloc] initWithFrame:framePatrimony] ;
        labelPatrimony.backgroundColor = [UIColor whiteColor];
        labelPatrimony.font = [UIFont systemFontOfSize:13];
        labelPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelPatrimony.text = newString;
        labelPatrimony.textAlignment = NSTextAlignmentRight;
        labelPatrimony.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelPatrimony];
    }
    //papapapa
    if(tableView == _tableCategoryShareLosers ){
        
        CGRect artistFrame = CGRectMake(10, 5, 200, 25);
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [arraySeriesFundsInvestmentsLoserNameAux  objectAtIndex:indexPath.row];
        artistLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:artistLabel];
        
        //funcion
        NSString *strFloat  = [[arraySeriesFundsInvestmentsLoserValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;

        if(strFloatE<(100*-1)) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        
        
        CGRect varFrame = CGRectMake(290, 5, 50, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        albumLabel.textAlignment = NSTextAlignmentRight;
        albumLabel.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:albumLabel];
        
        NSString *number = [[arraySeriesFundsInvestmentsLoserPatrimonyAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect framePatrimony = CGRectMake(200, 5, 60, 25);
        UILabel *labelPatrimony = [[UILabel alloc] initWithFrame:framePatrimony] ;
        labelPatrimony.backgroundColor = [UIColor whiteColor];
        labelPatrimony.font = [UIFont systemFontOfSize:13];
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
        labelShareTop.font = [UIFont boldSystemFontOfSize:13];
        labelShareTop.highlightedTextColor = [UIColor whiteColor];
        labelShareTop.text = [arraySeriesFundsSeriesWinCuotaNameAux  objectAtIndex:indexPath.row];
        labelShareTop.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareTop];
        
        //funcion
        NSString *strFloat  = [[arraySeriesFundsSeriesWinCuotaValueAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        
        NSString *formattedNumber;
        if(strFloatE>100) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        
        CGRect frameShareTopValue = CGRectMake(290, 5, 55, 25);
        UILabel *labelShareTopValue = [[UILabel alloc] initWithFrame:frameShareTopValue];
        labelShareTopValue.backgroundColor = [UIColor whiteColor];
        labelShareTopValue.font = [UIFont systemFontOfSize:12];
        labelShareTopValue.highlightedTextColor = [UIColor whiteColor];
        labelShareTopValue.text = formattedNumber;
        labelShareTopValue.textAlignment = NSTextAlignmentRight;
        labelShareTopValue.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareTopValue];
        
        NSString *number = [[arraySeriesFundsSeriesWinCuotaPatrimonyAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];

        CGRect frameShareTopPatrimony = CGRectMake(160, 5, 120, 25);
        UILabel *labelShareTopPatrimony = [[UILabel alloc] initWithFrame:frameShareTopPatrimony];
        labelShareTopPatrimony.backgroundColor = [UIColor whiteColor];
        labelShareTopPatrimony.font = [UIFont systemFontOfSize:12];
        labelShareTopPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelShareTopPatrimony.text = newString;
        labelShareTopPatrimony.textAlignment = NSTextAlignmentRight;
        labelShareTopPatrimony.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareTopPatrimony];
    }
    
    if(tableView == _tableSeriesShareLosers){
        
        CGRect frameShareLosers = CGRectMake(10, 5, 160, 25);
        UILabel *labelShareLosers = [[UILabel alloc] initWithFrame:frameShareLosers];
        labelShareLosers.backgroundColor = [UIColor whiteColor];
        labelShareLosers.font = [UIFont boldSystemFontOfSize:11];
        labelShareLosers.highlightedTextColor = [UIColor whiteColor];
        labelShareLosers.text = [arraySeriesFundsSeriesLoserCuotaNameAux  objectAtIndex:indexPath.row];
        labelShareLosers.textColor = [UIColor blackColor];
        [cell.contentView addSubview:labelShareLosers];
        
        //funcion
        NSString *strFloat  = [[arraySeriesFundsSeriesLoserCuotaValueAux  objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        int valor = strFloatE*100;
        strFloatE = (floor(valor)/100);
        NSString *formattedNumber;
        if(strFloatE<(100*-1)) formattedNumber = [NSString stringWithFormat:@"%.0f", strFloatE]; else formattedNumber = [NSString stringWithFormat:@"%.2f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        formattedNumber = [formattedNumber stringByAppendingString:@"%"];
        
        CGRect frameShareLosersValue = CGRectMake(290, 5, 58, 25);
        UILabel *labelShareLosersValue = [[UILabel alloc] initWithFrame:frameShareLosersValue];
        labelShareLosersValue.backgroundColor = [UIColor whiteColor];
        labelShareLosersValue.font = [UIFont systemFontOfSize:12];
        labelShareLosersValue.highlightedTextColor = [UIColor whiteColor];
        labelShareLosersValue.text = formattedNumber;
        labelShareLosersValue.textAlignment = NSTextAlignmentRight;
        labelShareLosersValue.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:labelShareLosersValue];
        
        NSString *number = [[arraySeriesFundsSeriesLoserCuotaPatrimonyAux  objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect frameShareTopPatrimony = CGRectMake(160, 5, 120, 25);
        UILabel *labelShareTopPatrimony = [[UILabel alloc] initWithFrame:frameShareTopPatrimony];
        labelShareTopPatrimony.backgroundColor = [UIColor whiteColor];
        labelShareTopPatrimony.font = [UIFont systemFontOfSize:12];
        labelShareTopPatrimony.highlightedTextColor = [UIColor whiteColor];
        labelShareTopPatrimony.text = newString;
        labelShareTopPatrimony.textAlignment = NSTextAlignmentRight;
        labelShareTopPatrimony.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:labelShareTopPatrimony];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}



//segundo

-(IBAction) segmentedControlInvestmentsChanged{
    switch (self.segmentedControlInvestments.selectedSegmentIndex) {
        case 0:
            StrindFundsValueDate = @"1";
            arraySeriesFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsInvestmentsWinNameAux count])>j;j++)
            {
                
                NSString *stringTimeAux = [[arraySeriesFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryShareTop    reloadData];
            [_tableCategoryShareLosers reloadData];

            break;
        case 1:
            StrindFundsValueDate = @"3";
            arraySeriesFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsInvestmentsWinNameAux count])>j;j++)
            {
                
                NSString *stringTimeAux = [[arraySeriesFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryShareTop    reloadData];
            [_tableCategoryShareLosers reloadData];

            break;
            
        case 2:
            StrindFundsValueDate = @"5";
            arraySeriesFundsInvestmentsWinNameAux         = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsWinValueAux        = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsWinPatrimonyAux    = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserNameAux       = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserValueAux      = [[NSMutableArray alloc] init];
            arraySeriesFundsInvestmentsLoserPatrimonyAux  = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsInvestmentsWinNameAux count])>j;j++)
            {
                
                NSString *stringTimeAux = [[arraySeriesFundsInvestmentsTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsInvestmentsTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Aumento Partícipes"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsInvestmentsWinNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsInvestmentsWinValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Pérdida Partícipes"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsInvestmentsName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsInvestmentsLoserNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsInvestmentsValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsInvestmentsLoserValueAux addObject:[NSString stringWithFormat:auxValue]];
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
            arraySeriesFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsSeriesWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arraySeriesFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                    [arraySeriesFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                    [arraySeriesFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
            }
            [_tableSeriesShareTop    reloadData];
            [_tableSeriesShareLosers reloadData];

            break;
        case 1:
            StrindFundsValueDate = @"3";
            arraySeriesFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsSeriesWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arraySeriesFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                    [arraySeriesFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
                
                if((([stringTimeAux isEqual:StrindFundsValueDate])||([stringTimeAux isEqualToString:@"1 semana"]))&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                    [arraySeriesFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
            }
            [_tableSeriesShareTop    reloadData];
            [_tableSeriesShareLosers reloadData];

            break;
            
        case 2:
            StrindFundsValueDate = @"5";
            arraySeriesFundsSeriesWinCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesWinCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesWinCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            arraySeriesFundsSeriesLoserCuotaPatrimonyAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsSeriesWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arraySeriesFundsSeriesCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsSeriesCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsSeriesWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsSeriesWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                    [arraySeriesFundsSeriesWinCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsSeriesCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsSeriesLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsSeriesLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                    
                    NSString *auxPatrimony = [[arraySeriesFundsSeriesCuotaPatrimony  objectAtIndex:j] objectForKey:@"participes"];
                    [arraySeriesFundsSeriesLoserCuotaPatrimonyAux addObject:[NSString stringWithFormat:auxPatrimony]];
                }
            }
            [_tableSeriesShareTop    reloadData];
            [_tableSeriesShareLosers reloadData];

            break;
        default:
            break;
    }
}

////    Primero

-(IBAction) segmentedControlIndexChanged{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            StrindFundsValueDate = @"1";
            arraySeriesFundsValueWinCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueWinCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueLoserCuotaValueAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsValueWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arraySeriesFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryInvestmentsTop    reloadData];
            [_tableCategoryInvestmentsLosers reloadData];

            break;
        case 1:
            StrindFundsValueDate = @"3";
            arraySeriesFundsValueWinCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueWinCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueLoserCuotaValueAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsValueWinCuotaNameAux count])>j;j++)
            {
                NSString *stringTimeAux = [[arraySeriesFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            [_tableCategoryInvestmentsTop reloadData];
            [_tableCategoryInvestmentsLosers reloadData];

            break;
            
        case 2:
            StrindFundsValueDate = @"5";
            arraySeriesFundsValueWinCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueWinCuotaValueAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueLoserCuotaNameAux = [[NSMutableArray alloc] init];
            arraySeriesFundsValueLoserCuotaValueAux = [[NSMutableArray alloc] init];
            
            for(NSInteger j=0;([arraySeriesFundsValueWinCuotaNameAux count])>j;j++){
                NSString *stringTimeAux = [[arraySeriesFundsValueCuotaTime  objectAtIndex:j] objectForKey:@"orden_display"];
                NSString *stringTipeAux = [[arraySeriesFundsValueCuotaTipe  objectAtIndex:j] objectForKey:@"tipo"];
                
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Ganadoras"])){
                    NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsValueWinCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsValueWinCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
                if(([stringTimeAux isEqual:StrindFundsValueDate])&&([stringTipeAux isEqualToString:@"Perdedoras"])){
                    
                    NSString  *auxCategory = [[arraySeriesFundsValueCuotaName  objectAtIndex:j] objectForKey:@"nombre_serie"];
                    [arraySeriesFundsValueLoserCuotaNameAux addObject:[NSString stringWithFormat:auxCategory]];
                    
                    NSString *auxValue = [[arraySeriesFundsValueCuotaValue  objectAtIndex:j] objectForKey:@"valor"];
                    [arraySeriesFundsValueLoserCuotaValueAux addObject:[NSString stringWithFormat:auxValue]];
                }
            }
            
            [_tableCategoryInvestmentsTop reloadData];
            [_tableCategoryInvestmentsLosers reloadData];
            break;
    
    }
}

@end