//
//  NINIndexController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 22-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import "NINAppDelegate.h"
#import "NINIndexController.h"
#import "NINNewsController.h"
#import "NINHomeController.h"
#import "NINWebController.h"
#import "NINActionsController.h"
#import "NINSettingController.h"
#import "NINMutualFundsController.h"
#import <QuartzCore/QuartzCore.h>

@interface NINIndexController ()

@end

@implementation NINIndexController

- (void)viewDidLoad
{
    countAux =0;
    
    titleIndexChile.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    titleIndexChile.layer.borderWidth = 1;
    
    titleIndexGlobal.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    titleIndexGlobal.layer.borderWidth = 1;
    
    titleCurrency.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    titleCurrency.layer.borderWidth = 1;
    
    titleUf.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    titleUf.layer.borderWidth = 1;
    
    titleUtm.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    titleUtm.layer.borderWidth = 1;
    
    _tableMoney.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableMoney.layer.borderWidth = 1;
    
    _tableStockGlobal.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableStockGlobal.layer.borderWidth = 1;
    
    _tableStockChile.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableStockChile.layer.borderWidth = 1;
    
    _tableUf.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableUf.layer.borderWidth = 1;
    
    _tableUtm.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableUtm.layer.borderWidth = 1;
    
    _tableMoney.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _tableMoney.layer.borderWidth = 1;
    
    
    urlIndexChile   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=indices_chile"];
    urlIndexGlobal  = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=indices_globales"];
    urlIndexMoney   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=monedas"];
    urlIndexUf      = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=uf"];
    urlIndexUtm     = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=utm"];
    
    
    [super viewDidLoad];
    
    //contenedor para las noticias
    if (!arrayIndexChileName || !arrayIndexChileName.count){
        arrayIndexChileName  = [[NSMutableArray alloc] init];
        arrayIndexChileValue = [[NSMutableArray alloc] init];
        arrayIndexChileVar   = [[NSMutableArray alloc] init];
        arrayIndexGlobalName = [[NSMutableArray alloc] init];
        arrayIndexGlobalValue= [[NSMutableArray alloc] init];
        arrayIndexGlobalVar  = [[NSMutableArray alloc] init];
        arrayMoneyName       = [[NSMutableArray alloc] init];
        arrayMoneyValue      = [[NSMutableArray alloc] init];
        arrayMoneyVariation  = [[NSMutableArray alloc] init];
        arrayUfName          = [[NSMutableArray alloc] init];
        arrayUfValue         = [[NSMutableArray alloc] init];
        arrayUtmName         = [[NSMutableArray alloc] init];
        arrayUtmValue        = [[NSMutableArray alloc] init];
        
        [self performSelector:@selector(startShowing) withObject:nil afterDelay:0.1f];
    }
}

-(void) startShowing{

    //inicializa el parser conb el contenido de la url
    xmlIndexGloval = [[NSXMLParser alloc] initWithContentsOfURL:urlIndexGlobal];
    [xmlIndexGloval setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexGloval parse]; //inicializa la rutina de parse
    
    
    xmlIndexChile = [[NSXMLParser alloc] initWithContentsOfURL:urlIndexChile];
    [xmlIndexChile setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexChile parse]; //inicializa la rutina de parse
    
    xmlIndexMoney = [[NSXMLParser alloc] initWithContentsOfURL:urlIndexMoney];
    [xmlIndexMoney setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexMoney parse]; //inicializa la rutina de parse
    
    xmlIndexUf= [[NSXMLParser alloc] initWithContentsOfURL:urlIndexUf];
    [xmlIndexUf setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexUf parse]; //inicializa la rutina de parse
    
    xmlIndexUtm = [[NSXMLParser alloc] initWithContentsOfURL:urlIndexUtm];
    [xmlIndexUtm setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexUtm parse]; //inicializa la rutina de parse
    
    [_tableStockChile reloadData];
    [_tableStockGlobal reloadData];
    [_tableUf reloadData];
    [_tableUtm    reloadData];
    [_tableMoney reloadData];
    
    NSError* error = nil;
    NSString *URLString = [NSString stringWithContentsOfURL:urlIndexMoney encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        
        NSString *alertString = @"";
        
        if([arrayUfName count]==0){
            alertString = [NSString stringWithFormat:@"%@ Uf ",alertString];
        }
        if([arrayUtmName count]==0){
            alertString = [NSString stringWithFormat:@"%@,Utm ",alertString];
        }
        if([arrayIndexChileName count]==0){
            alertString = [NSString stringWithFormat:@"%@,Index Chile ",alertString];
        }
        if([arrayIndexGlobalName count]==0){
            alertString = [NSString stringWithFormat:@"%@,Index Global ",alertString];
        }
        if([arrayMoneyName count]==0){
            alertString = [NSString stringWithFormat:@"%@,Moneda ",alertString];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
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
    
    // Chile
    if(countAux==4){
        if ([elementName isEqualToString:@"simbolo"])
        {
            [item setObject:string forKey:@"simbolo"];
            [arrayIndexChileName addObject:item];
        }
        if ([elementName isEqualToString:@"precio"])
        {
            [item setObject:string forKey:@"precio"];
            [arrayIndexChileValue addObject:item];
        }
        if ([elementName isEqualToString:@"variacion"])
        {
            [item setObject:string forKey:@"variacion"];
            [arrayIndexChileVar addObject:item];
        }
    }
    // Global
    if(countAux==0){
        if ([elementName isEqualToString:@"nemo"])
        {
            [item setObject:string forKey:@"nemo"];
            [arrayIndexGlobalName addObject:item];
        }
        if ([elementName isEqualToString:@"precio"])
        {
            [item setObject:string forKey:@"precio"];
            [arrayIndexGlobalValue addObject:item];
        }
        if ([elementName isEqualToString:@"variacion_porcentaje"])
        {
            [item setObject:string forKey:@"variacion_porcentaje"];
            [arrayIndexGlobalVar addObject:item];
        }
    }
    // Money
    if(countAux==8){
        if ([elementName isEqualToString:@"nemotecnico"])
        {
            [item setObject:string forKey:@"nemotecnico"];
            [arrayMoneyName addObject:item];
        }
        if ([elementName isEqualToString:@"pesos_moneda"])
        {
            [item setObject:string forKey:@"pesos_moneda"];
            [arrayMoneyValue addObject:item];
        }
        if ([elementName isEqualToString:@"variacion_porcentaje"])
        {
            [item setObject:string forKey:@"variacion_porcentaje"];
            [arrayMoneyVariation addObject:item];
        }
    }
    // Uf
    if(countAux==12){
        if ([elementName isEqualToString:@"fecha"])
        {
            [item setObject:string forKey:@"fecha"];
            [arrayUfName addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arrayUfValue addObject:item];
        }
    }
    //Utm
    if(countAux==16){
        if ([elementName isEqualToString:@"fecha"])
        {
            [item setObject:string forKey:@"fecha"];
            [arrayUtmName addObject:item];
        }
        if ([elementName isEqualToString:@"valor"])
        {
            [item setObject:string forKey:@"valor"];
            [arrayUtmValue addObject:item];
        }
    }
   item=nil;
    string = [NSMutableString string]; //limpiamos el string
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    countAux = ++countAux;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tableStockChile){
        return [arrayIndexChileName count];
    }
    if(tableView == _tableStockGlobal){
        int *num= [arrayIndexGlobalName count];
        return (num-1);
    }
    if(tableView == _tableMoney){
        return [arrayMoneyName count];
    }
    if(tableView == _tableUf){
        return [arrayUfName count];
            
    }
    if(tableView == _tableUtm){
        return [arrayUtmName count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        if(tableView == _tableStockChile){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableStockGlobal){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableMoney){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableUf){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableUtm){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }

    
    if(tableView == _tableStockChile){
    
        NSString * strFloat  = [ cell.detailTextLabel.text = [[arrayIndexChileVar  objectAtIndex:indexPath.row] objectForKey:@"variacion"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        BOOL *tipe = NULL;
        if (strFloatE>0)
            tipe=true;
        CGRect varFrame = CGRectMake(290, 7, 80, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = cell.detailTextLabel.text = [[arrayIndexChileVar  objectAtIndex:indexPath.row] objectForKey:@"variacion"];
        if (tipe)
            albumLabel.textColor = [UIColor blackColor];
        else
            albumLabel.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:albumLabel];
        
        NSString *number =[[[arrayIndexChileValue  objectAtIndex:indexPath.row] objectForKey:@"precio"] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect songFrame = CGRectMake(175, 7, 70, 25);
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont systemFontOfSize:13];
        songLabel.highlightedTextColor = [UIColor whiteColor];
        songLabel.text = newString;
        songLabel.textColor = [UIColor blackColor];
        songLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:songLabel];
         
        CGRect artistFrame = CGRectMake(10, 7, 150, 25);
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [[arrayIndexChileName  objectAtIndex:indexPath.row] objectForKey:@"simbolo"];
        artistLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:artistLabel];
    }
    
    if(tableView == _tableStockGlobal){
        
        CGRect artistFrame = CGRectMake(10, 7, 150, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"];
        [cell.contentView addSubview:artistLabel];
  
        NSString *number = [[[arrayIndexGlobalValue  objectAtIndex:indexPath.row] objectForKey:@"precio"] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMinimumFractionDigits:2];
        [formatter setMaximumFractionDigits:2];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];;
       
        CGRect songFrame = CGRectMake(180, 7, 70, 25);
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont systemFontOfSize:13];
        songLabel.highlightedTextColor = [UIColor whiteColor];
        songLabel.text = newString;
        songLabel.textAlignment = NSTextAlignmentRight;
        songLabel.textColor = [UIColor blackColor];
        
        [cell.contentView addSubview:songLabel];
        
        NSString *strFloat  = [[[arrayIndexGlobalVar objectAtIndex:indexPath.row] objectForKey:@"variacion_porcentaje"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        BOOL *tipe = NULL;
        if (strFloatE>0) {
            tipe=true;
        }
        NSString *formattedNumber = [NSString stringWithFormat:@"%.02f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        
        CGRect varFrame = CGRectMake(265, 7, 50, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        albumLabel.textAlignment = NSTextAlignmentRight;
        if (tipe)
            albumLabel.textColor = [UIColor blackColor];
        else
            albumLabel.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        
        [cell.contentView addSubview:albumLabel];
        
        CGRect albumFrame = CGRectMake(140, 12, 20, 14);
        self.viewFlag = [[UIImageView alloc] initWithFrame:albumFrame];
        
        if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"NASDAQ"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-usa"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"NIKKEI"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-japon"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"FTSE"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-uk"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"BOVESPA"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-brasil"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"IPC"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-mexico"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"MERVAL"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-argentina"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"IGVBL"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-peru"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"DAX"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-alemania"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"Ibex"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-spain"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"CAC 40"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-francia"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"HANG SENG"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-china"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"SHANGAI"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-china"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"DJI"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-uk"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"Lima Selectivo"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-spain"];
        else if([[[arrayIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"Ibex 35"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-peru"];

        [cell.contentView addSubview:self.viewFlag];
        
    }

    if(tableView == _tableMoney){

        CGRect artistFrame = CGRectMake(10, 7, 180, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [[arrayMoneyName  objectAtIndex:indexPath.row] objectForKey:@"nemotecnico"];
        [cell.contentView addSubview:artistLabel];
        
       
        
        NSString *number = [[[arrayMoneyValue  objectAtIndex:indexPath.row] objectForKey:@"pesos_moneda"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2]; // Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect varFrame = CGRectMake(185, 7, 50, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = newString;
        albumLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:albumLabel];
        
        NSString *strFloat  = [[[arrayMoneyVariation  objectAtIndex:indexPath.row] objectForKey:@"variacion_porcentaje"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        NSString *formattedNumber = [NSString stringWithFormat:@"%.02f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        
        CGRect vaFrame = CGRectMake(280, 7, 80, 25);
        UILabel *albumLab = [[UILabel alloc] initWithFrame:vaFrame] ;
        albumLab.backgroundColor = [UIColor whiteColor];
        albumLab.font = [UIFont systemFontOfSize:13];
        albumLab.highlightedTextColor = [UIColor whiteColor];
        albumLab.text = formattedNumber;
        [cell.contentView addSubview:albumLab];
        
    }
    
    if(tableView == _tableUf){
        
        CGRect artistFrame = CGRectMake(5, 7, 200, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        if(indexPath.row==0)
            artistLabel.text = @"Precio de Ayer";
        if(indexPath.row==1)
            artistLabel.text = @"Precio de Hoy";
        if(indexPath.row==2)
            artistLabel.text = @"Precio de Mañana";

        [cell.contentView addSubview:artistLabel];
        
        NSString *number = [[[arrayUfValue  objectAtIndex:indexPath.row] objectForKey:@"valor"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];
        
        CGRect varFrame = CGRectMake(235, 7, 80, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = newString;
        [cell.contentView addSubview:albumLabel];
    }
    
    if(tableView == _tableUtm){

        NSArray *split = [[[arrayUtmName  objectAtIndex:indexPath.row] objectForKey:@"fecha"] componentsSeparatedByString:@"/"];
        CGRect artistFrame = CGRectMake(5, 7, 200, 25);
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:13];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"1"])
            artistLabel.text = @"Enero";
        else
            if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"2"])
                artistLabel.text = @"Febrero";
            else
                if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"3"])
                    artistLabel.text = @"Marzo";
                else
                    if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"4"])
                        artistLabel.text = @"Abril";
                    else
                        if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"5"])
                            artistLabel.text = @"Mayo";
                        else
                            if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"6"])
                                artistLabel.text = @"Junio";
                            else
                                if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"7"])
                                    artistLabel.text = @"Julio";
                                else
                                    if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"8"])
                                        artistLabel.text = @"Agosto";
                                    else
                                        if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"9"])
                                            artistLabel.text = @"Septiembre";
                                        else
                                            if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"10"])
                                                artistLabel.text = @"Octubre";
                                            else
                                                if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"11"])
                                                    artistLabel.text = @"Noviembre";
                                                else
                                                    if([[split[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual: @"12"])
                                                        artistLabel.text = @"Diciembre";
        //artistLabel.text = [[arrayUtmName  objectAtIndex:indexPath.row] objectForKey:@"fecha"];
        [cell.contentView addSubview:artistLabel];
        
        NSString *number = [[arrayUtmValue  objectAtIndex:indexPath.row] objectForKey:@"valor"];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];// Set this if you need 2 digits
        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[number floatValue]]];

        CGRect varFrame = CGRectMake(235, 7, 80, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = newString;
        [cell.contentView addSubview:albumLabel];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;//UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (IBAction) closeView:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)changeViewNews:(id)sender
{
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

-(IBAction)changeViewMutualFunds:(id)sender{
    NINMutualFundsController *viewMutualFunds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewMutualFunds =[[NINMutualFundsController alloc] initWithNibName:@"NINMutualFundsView_iPad" bundle:nil];
    } else {
        viewMutualFunds =[[NINMutualFundsController alloc] initWithNibName:@"NINMutualFundsView_iPad" bundle:nil];
    }
    viewMutualFunds.modalPresentationStyle = UIModalPresentationFullScreen;
    viewMutualFunds.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewMutualFunds animated:NO completion:nil];
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

@end

    
