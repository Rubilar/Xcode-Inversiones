//
//  NINRecommendationController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 21-01-13.
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

#import <QuartzCore/QuartzCore.h>

@implementation NINActionsController
@synthesize segmentedControl;
@synthesize popoverController;
@synthesize popoverButton;
@synthesize viewAcction;

- (void)viewDidLoad
{

    _tableFilterCorredora.alpha = 0;
    _arrowCorredora.alpha = 0;
    _tableFilterEmpresa.alpha = 0;
    _arrowEmpresa.alpha = 0;
    
    viewCompany.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationCompany"];
    viewMnemonic.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationMnemonic"];
    viewBrokerage.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationBrokerage"];
    viewRecommendation.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationTipe"];
    viewCurrentPrice.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationCurrentPrice"];
    viewPriceTarget.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationPriceTarget"];
    viewEstimated.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationEstimated"];
    viewDate.text =[[NSUserDefaults standardUserDefaults] stringForKey:@"recommendationDate"];

    [super viewDidLoad];
    
    urlActions   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?accion=1&cant=19"];
    urlFilterCorredora = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?corredora=1"];
    urlFilterEmpresa = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?Empresa=1"];
    
    NSError* error = nil;
    NSString *URLString = [NSString stringWithContentsOfURL:urlFilterEmpresa encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        [super viewDidLoad];
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [mes show];
    }


    viewAcction.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewAcction.layer.borderWidth = 1;
    
    _tableFilterCorredora.layer.borderColor = [[UIColor colorWithRed:85/255.f green:85/255.f blue:85/255.f alpha:1.0f] CGColor];
    _tableFilterCorredora.layer.borderWidth = 4;
    
    _tableFilterEmpresa.layer.borderColor = [[UIColor colorWithRed:85/255.f green:85/255.f blue:85/255.f alpha:1.0f] CGColor];
    _tableFilterEmpresa.layer.borderWidth = 4;
  
    if (!arrayCorredoraNombre || !arrayCorredoraNombre.count){
    //  Arrays Recomendation
        arrayRecomendationCompany       = [[NSMutableArray alloc] init];
        arrayRecomendationMnemonic      = [[NSMutableArray alloc] init];
        arrayRecomendationBrokerage     = [[NSMutableArray alloc] init];
        arrayRecomendationRecommendation= [[NSMutableArray alloc] init];
        arrayRecomendationPriceTarget   = [[NSMutableArray alloc] init];
        arrayRecomendationCurrentPrice  = [[NSMutableArray alloc] init];
        arrayRecomendationEstimated     = [[NSMutableArray alloc] init];
        arrayRecomendationDate          = [[NSMutableArray alloc] init];
        arrayCorredoraNombre  = [[NSMutableArray alloc] init];
        arrayCorredoraId      = [[NSMutableArray alloc] init];
        arrayEmpresaNombre    = [[NSMutableArray alloc] init];
        arrayEmpresaId        = [[NSMutableArray alloc] init];
    }
    
    if (!arrayCorredoraNombre || !arrayCorredoraNombre.count)
        [self performSelector:@selector(startShowingAction) withObject:nil afterDelay:0.01f];
}

-(void) startShowingAction{

    countAux = 0;
    xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlActions];
    [xmlActions setDelegate:self]; //delegamos desde el xml a self
    [xmlActions parse]; //inicializa la rutina de parse
    
     [_tableRecomendation reloadData];
    
    countAux = 4;
    xmlFilterCorredora = [[NSXMLParser alloc] initWithContentsOfURL:urlFilterCorredora];
    [xmlFilterCorredora setDelegate:self]; //delegamos desde el xml a self
    [xmlFilterCorredora parse]; //inicializa la rutina de parse
    
     [_tableFilterCorredora reloadData];
    
    countAux = 8;
    xmlFilterEmpresa = [[NSXMLParser alloc] initWithContentsOfURL:urlFilterEmpresa];
    [xmlFilterEmpresa setDelegate:self]; //delegamos desde el xml a self
    [xmlFilterEmpresa parse]; //inicializa la rutina de parse
    
     [_tableFilterEmpresa reloadData];
    
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
    if(countAux==0){
        if ([elementName isEqualToString:@"Empresa"]){
            [item setObject:string forKey:@"Empresa"];
            [arrayRecomendationCompany addObject:item];
        }
        if ([elementName isEqualToString:@"Nemo"]){
            [item setObject:string forKey:@"Nemo"];
            [arrayRecomendationMnemonic addObject:item];
        }
        if ([elementName isEqualToString:@"Corredora"]){
            [item setObject:string forKey:@"Corredora"];
            [arrayRecomendationBrokerage addObject:item];
        }
        if ([elementName isEqualToString:@"Recomendacion"]){
                [item setObject:string forKey:@"Recomendacion"];
                [arrayRecomendationRecommendation addObject:item];
        }
        if ([elementName isEqualToString:@"PrecioActual"]){
            [item setObject:string forKey:@"PrecioActual"];
            [arrayRecomendationPriceTarget addObject:item];
        }
        if ([elementName isEqualToString:@"Precio"]){
            [item setObject:string forKey:@"Precio"];
            [arrayRecomendationCurrentPrice addObject:item];
        }
        if ([elementName isEqualToString:@"Variacion"]){
            [item setObject:string forKey:@"Variacion"];
            [arrayRecomendationEstimated addObject:item];
        }
        if ([elementName isEqualToString:@"Fecha"]){
            [item setObject:string forKey:@"Fecha"];
            [arrayRecomendationDate addObject:item];
        }
    }
    if(countAux==4){
        if ([elementName isEqualToString:@"id"]){
            [item setObject:string forKey:@"id"];
            [arrayCorredoraId addObject:item];
        }
        if ([elementName isEqualToString:@"Nombre"]){
            [item setObject:string forKey:@"Nombre"];
            [arrayCorredoraNombre addObject:item];
        }
    }
    if(countAux==8){
        if ([elementName isEqualToString:@"id_Empresa"]){
            [item setObject:string forKey:@"id_Empresa"];
            [arrayEmpresaId addObject:item];
        }
        if ([elementName isEqualToString:@"Nombre"]){
            [item setObject:string forKey:@"Nombre"];
            [arrayEmpresaNombre addObject:item];
        }
    }
    
    item=nil;
    string = [NSMutableString string]; //limpiamos el string
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //countAux = ++countAux;
    //NSLog(@"empresa %@",arrayCorredoraNombre);
}
//Fin parcer Xml


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == _tableRecomendation){
        return [arrayRecomendationCompany count];
    }
    if(tableView == _tableFilterCorredora){
        return [arrayCorredoraNombre count];
    }
    if(tableView == _tableFilterEmpresa){
        return [arrayEmpresaNombre count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        if(tableView == _tableRecomendation)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableFilterCorredora)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        if(tableView == _tableFilterEmpresa)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
    }
    
    if(tableView == _tableRecomendation)
    {
        CGRect artistFrame = CGRectMake(5, 15, 150, 10);
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:12];
        artistLabel.highlightedTextColor = [UIColor clearColor];
        artistLabel.text = [[arrayRecomendationCompany objectAtIndex:indexPath.row]objectForKey:@"Empresa"];
        artistLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:artistLabel];
        
        CGRect songFrame = CGRectMake(160, 15, 80, 10);
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont italicSystemFontOfSize:10];
        songLabel.highlightedTextColor = [UIColor clearColor];
        songLabel.text = [[arrayRecomendationMnemonic objectAtIndex:indexPath.row]objectForKey:@"Nemo"];
        songLabel.textAlignment = NSTextAlignmentCenter;
        songLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:songLabel];
        
        CGRect albumFrame = CGRectMake(250, 15, 80, 10);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:albumFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:10];
        albumLabel.highlightedTextColor = [UIColor clearColor];
        albumLabel.text = [[arrayRecomendationBrokerage objectAtIndex:indexPath.row]objectForKey:@"Corredora"];
        albumLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:albumLabel];
        
        CGRect recommendationFrame = CGRectMake(340, 15, 90, 10);
        
        UILabel *recommendationLabel = [[UILabel alloc] initWithFrame:recommendationFrame] ;
        recommendationLabel.backgroundColor = [UIColor whiteColor];
        recommendationLabel.font = [UIFont systemFontOfSize:11];
        recommendationLabel.highlightedTextColor = [UIColor clearColor];
        recommendationLabel.text = [[arrayRecomendationRecommendation objectAtIndex:indexPath.row]objectForKey:@"Recomendacion"];
        recommendationLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:recommendationLabel];
        
        CGRect priceTargetFrame = CGRectMake(440, 15, 100, 10);
        
        UILabel *priceTargeLabel = [[UILabel alloc] initWithFrame:priceTargetFrame] ;
        priceTargeLabel.backgroundColor = [UIColor whiteColor];
        priceTargeLabel.font = [UIFont systemFontOfSize:11];
        priceTargeLabel.textAlignment = NSTextAlignmentRight;
        priceTargeLabel.highlightedTextColor = [UIColor clearColor];
        priceTargeLabel.text = [[arrayRecomendationPriceTarget objectAtIndex:indexPath.row]objectForKey:@"PrecioActual"];
        [cell.contentView addSubview:priceTargeLabel];
        
        
        CGRect estimatedFrame = CGRectMake(550, 15, 70, 10);
        
        UILabel *estimatedLabel = [[UILabel alloc] initWithFrame:estimatedFrame] ;
        estimatedLabel.backgroundColor = [UIColor whiteColor];
        estimatedLabel.font = [UIFont systemFontOfSize:12];
        estimatedLabel.highlightedTextColor = [UIColor clearColor];
        estimatedLabel.textAlignment = NSTextAlignmentRight;
        estimatedLabel.text = [[arrayRecomendationEstimated objectAtIndex:indexPath.row]objectForKey:@"Variacion"];
        [cell.contentView addSubview:estimatedLabel];
        
        
        CGRect dateFrame = CGRectMake(625, 15, 75, 10);
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateFrame] ;
        dateLabel.backgroundColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.highlightedTextColor = [UIColor clearColor];
        dateLabel.text = [[arrayRecomendationDate objectAtIndex:indexPath.row]objectForKey:@"Fecha"];
        [cell.contentView addSubview:dateLabel];
    }
    if(tableView == _tableFilterCorredora)
    {
        cell.textLabel.text = [[arrayCorredoraNombre  objectAtIndex:indexPath.row]objectForKey:@"Nombre"];
        cell.textLabel.textColor = [[UIColor alloc] initWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0];
    }
    if(tableView == _tableFilterEmpresa)
    {
        cell.textLabel.text = [[arrayEmpresaNombre  objectAtIndex:indexPath.row]objectForKey:@"Nombre"];
        cell.textLabel.textColor = [[UIColor alloc] initWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 35;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tableRecomendation)
    {
        _tableFilterCorredora.alpha = 0;
        _arrowCorredora.alpha = 0;
        
        _tableFilterEmpresa.alpha = 0;
        _arrowEmpresa.alpha = 0;
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[[arrayRecomendationCompany objectAtIndex:indexPath.row]objectForKey:@"Empresa"] forKey:@"recommendationCompany"];
        [defaults setObject:[[arrayRecomendationMnemonic objectAtIndex:indexPath.row]objectForKey:@"Nemo"] forKey:@"recommendationMnemonic"];
        [defaults setObject:[[arrayRecomendationBrokerage objectAtIndex:indexPath.row]objectForKey:@"Corredora"] forKey:@"recommendationBrokerage"];
        [defaults setObject:[[arrayRecomendationRecommendation objectAtIndex:indexPath.row]objectForKey:@"Recomendacion"] forKey:@"recommendationTipe"];
        [defaults setObject:[[arrayRecomendationCurrentPrice objectAtIndex:indexPath.row]objectForKey:@"PrecioActual"] forKey:@"recommendationCurrentPrice"];
        [defaults setObject:[[arrayRecomendationPriceTarget objectAtIndex:indexPath.row]objectForKey:@"Precio"] forKey:@"recommendationPriceTarget"];
        [defaults setObject:[[arrayRecomendationEstimated objectAtIndex:indexPath.row]objectForKey:@"Variacion"] forKey:@"recommendationEstimated"];
        [defaults setObject:[[arrayRecomendationDate objectAtIndex:indexPath.row]objectForKey:@"Fecha"] forKey:@"recommendationDate"];
        //[defaults setObject:[[arrayRecomendationNumberStudies objectAtIndex:indexPath.row]objectForKey:@"Fecha"] forKey:@"recommendationNumberStudies"];
        [defaults synchronize];
        
        UIViewController* popoverContent = [[UIViewController alloc] init];
        UIView* popoverView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 810, 405)];
        popoverView.backgroundColor = [UIColor whiteColor];
        
        //Detalle de accion
        
        UILabel *lableDate = [[UILabel alloc] initWithFrame:CGRectMake(20,8,280,30)];
        lableDate.text = [[arrayRecomendationDate objectAtIndex:indexPath.row]objectForKey:@"Fecha"];
        lableDate.textColor = [UIColor grayColor];
        lableDate.font = [UIFont systemFontOfSize:13];
        [popoverView addSubview:lableDate];
        
        UILabel *lableCompany = [[UILabel alloc] initWithFrame:CGRectMake(20,40,300,30)];
        lableCompany.text = @" Compañia";
        lableCompany.font = [UIFont systemFontOfSize:13];
        lableCompany.textAlignment = NSTextAlignmentLeft;
        lableCompany.textColor = [UIColor blackColor];
        lableCompany.backgroundColor = [[UIColor alloc] initWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        [popoverView addSubview:lableCompany];
        
        
        UILabel *company = [[UILabel alloc] initWithFrame:CGRectMake(20,80,300,30)];
        company.text = [[arrayRecomendationCompany objectAtIndex:indexPath.row]objectForKey:@"Empresa"];
        company.font = [UIFont systemFontOfSize:14];
        company.textAlignment = NSTextAlignmentLeft;
        company.textColor = [UIColor grayColor];
        [popoverView addSubview:company];
        
        UILabel *lableMnemonic = [[UILabel alloc] initWithFrame:CGRectMake(325,40,100,30)];
        lableMnemonic.text = @" Nemotécnico";
        lableMnemonic.textColor = [UIColor blackColor];
        lableMnemonic.font = [UIFont systemFontOfSize:13];
        lableMnemonic.textAlignment = NSTextAlignmentLeft;
        lableMnemonic.backgroundColor = [[UIColor alloc] initWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        [popoverView addSubview:lableMnemonic];
        
        UILabel *nemonic = [[UILabel alloc] initWithFrame:CGRectMake(325,80,100,30)];
        nemonic.text = [[arrayRecomendationMnemonic objectAtIndex:indexPath.row]objectForKey:@"Nemo"];
        nemonic.textColor = [UIColor blackColor];
        nemonic.font = [UIFont systemFontOfSize:14];
        nemonic.textAlignment = NSTextAlignmentLeft;
        nemonic.textColor= [[UIColor alloc] initWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0];
        [popoverView addSubview:nemonic];
        
        UILabel *lableBrokerage = [[UILabel alloc] initWithFrame:CGRectMake(430,40,150,30)];
        lableBrokerage.text = @" Corredora";
        lableBrokerage.textColor = [UIColor blackColor];
        lableBrokerage.backgroundColor =[[UIColor alloc] initWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        lableBrokerage.font = [UIFont systemFontOfSize:13];
        lableBrokerage.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:lableBrokerage];
        
        UILabel *brokerage = [[UILabel alloc] initWithFrame:CGRectMake(430,80,150,30)];
        brokerage.text = [[arrayRecomendationBrokerage objectAtIndex:indexPath.row]objectForKey:@"Corredora"];
        brokerage.textColor = [UIColor blackColor];
        brokerage.font = [UIFont systemFontOfSize:13];
        brokerage.textAlignment = NSTextAlignmentLeft;
        brokerage.textColor = [UIColor grayColor];
        [popoverView addSubview:brokerage];
        
        
        //
        
        UILabel *lableRecommendatio = [[UILabel alloc] initWithFrame:CGRectMake(10,140,120,30)];
        lableRecommendatio.backgroundColor = [[UIColor alloc] initWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        lableRecommendatio.text = @" Recomendación";
        lableRecommendatio.textColor = [UIColor blackColor];
        lableRecommendatio.font = [UIFont systemFontOfSize:13];
        lableRecommendatio.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:lableRecommendatio];
        
        UILabel *recommendation = [[UILabel alloc] initWithFrame:CGRectMake(10,170,120,30)];
        recommendation.text = [[arrayRecomendationRecommendation objectAtIndex:indexPath.row]objectForKey:@"Recomendacion"];
        recommendation.textColor = [UIColor grayColor];
        recommendation.font = [UIFont systemFontOfSize:14];
        recommendation.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:recommendation];
        
        
        UILabel *lableUpside = [[UILabel alloc] initWithFrame:CGRectMake(135,140,170,30)];
        lableUpside.backgroundColor = [[UIColor alloc] initWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        lableUpside.text = @" Upside/Downside Estimado";
        lableUpside.textColor = [UIColor blackColor];
        lableUpside.font = [UIFont systemFontOfSize:13];
        lableUpside.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:lableUpside];
        
        UILabel *upside = [[UILabel alloc] initWithFrame:CGRectMake(135,170,170,30)];
        upside.text = [[arrayRecomendationEstimated objectAtIndex:indexPath.row]objectForKey:@"Variacion"];
        upside.textColor = [UIColor grayColor];
        upside.font = [UIFont systemFontOfSize:14];
        upside.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:upside];
        
        
        UILabel *priceTarget = [[UILabel alloc] initWithFrame:CGRectMake(310,140,190,30)];
        priceTarget.backgroundColor = [[UIColor alloc] initWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
        priceTarget.text = @" Precio objetivo";
        priceTarget.textColor = [UIColor blackColor];
        priceTarget.font = [UIFont systemFontOfSize:13];
        priceTarget.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:priceTarget];
        
        UILabel *lablePriceTarget = [[UILabel alloc] initWithFrame:CGRectMake(310,170,190,30)];
        lablePriceTarget.text = [[arrayRecomendationCurrentPrice objectAtIndex:indexPath.row]objectForKey:@"Precio"];
        lablePriceTarget.textColor = [UIColor grayColor];
        lablePriceTarget.font = [UIFont systemFontOfSize:14];
        lablePriceTarget.textAlignment = NSTextAlignmentLeft;
        [popoverView addSubview:lablePriceTarget];
        
        popoverContent.view = popoverView;
        
        popoverContent.contentSizeForViewInPopover = CGSizeMake(600, 400);
        self.popoverController = [[UIPopoverController alloc]
                                  initWithContentViewController:popoverContent] ;
        [self.popoverController presentPopoverFromRect:CGRectMake(350, 250, 100, 350)
                                                inView:self.view
                              permittedArrowDirections:0
                                              animated:YES];

    }
    
    if(tableView == _tableFilterCorredora){
        [UIView animateWithDuration:0.2 animations:^{ _tableFilterCorredora.alpha = 0; _arrowCorredora.alpha = 0;}];
        
        NSString *idCorredora = [[arrayCorredoraId objectAtIndex:indexPath.row]objectForKey:@"id"];
        NSString *newString = [[idCorredora componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
        NSString *UrlCorredora =[NSMutableString stringWithFormat:@"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?accion=1&cant=30&idCorredora=%@",newString];
        
        arrayRecomendationCompany = [[NSMutableArray alloc] init];
        arrayRecomendationMnemonic = [[NSMutableArray alloc] init];
        arrayRecomendationBrokerage = [[NSMutableArray alloc] init];
        arrayRecomendationRecommendation = [[NSMutableArray alloc] init];
        arrayRecomendationPriceTarget = [[NSMutableArray alloc] init];
        arrayRecomendationCurrentPrice = [[NSMutableArray alloc] init];
        arrayRecomendationEstimated = [[NSMutableArray alloc] init];
        arrayRecomendationDate = [[NSMutableArray alloc] init];
        
        countAux = 0;
        NSURL *urlLast   = [NSURL URLWithString: UrlCorredora];
        xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlLast];
        [xmlActions setDelegate:self]; //delegamos desde el xml a self
        [xmlActions parse]; //inicializa la rutina de parse
        [_tableRecomendation reloadData];
    }
    
    if(tableView == _tableFilterEmpresa){
        [UIView animateWithDuration:0.2 animations:^{ _tableFilterEmpresa.alpha = 0; _arrowEmpresa.alpha = 0;}];
        
        NSString *idCorredora = [[arrayEmpresaId objectAtIndex:indexPath.row]objectForKey:@"id_Empresa"];
        NSString *newString = [[idCorredora componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
        NSString *UrlCorredora =[NSMutableString stringWithFormat:@"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?accion=1&cant=30&idEmpresa=%@",newString];
        
        arrayRecomendationCompany = [[NSMutableArray alloc] init];
        arrayRecomendationMnemonic = [[NSMutableArray alloc] init];
        arrayRecomendationBrokerage = [[NSMutableArray alloc] init];
        arrayRecomendationRecommendation = [[NSMutableArray alloc] init];
        arrayRecomendationPriceTarget = [[NSMutableArray alloc] init];
        arrayRecomendationCurrentPrice = [[NSMutableArray alloc] init];
        arrayRecomendationEstimated = [[NSMutableArray alloc] init];
        arrayRecomendationDate = [[NSMutableArray alloc] init];
        
        countAux = 0;
        NSURL *urlLast   = [NSURL URLWithString: UrlCorredora];
        xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlLast];
        [xmlActions setDelegate:self]; //delegamos desde el xml a self
        [xmlActions parse]; //inicializa la rutina de parse
        [_tableRecomendation reloadData];
    }

}


//Functions Filters

- (IBAction) filterLast:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:^{ _buttonLast.alpha = 0.8; _buttonLast.alpha = 0.8; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonUpgrades.alpha = 1; _buttonUpgrades.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonDowgrade.alpha = 1; _buttonDowgrade.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonCorredora.alpha = 1; _buttonCorredora.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonEmpresa.alpha = 1; _buttonEmpresa.alpha = 1; }];
    
    [UIView animateWithDuration:0.2 animations:^{ _tableFilterCorredora.alpha = 0; _arrowCorredora.alpha = 0; }];
    [UIView animateWithDuration:0.2 animations:^{ _tableFilterEmpresa.alpha = 0; _arrowEmpresa.alpha = 0; }];

    arrayRecomendationCompany = [[NSMutableArray alloc] init];
    arrayRecomendationMnemonic = [[NSMutableArray alloc] init];
    arrayRecomendationBrokerage = [[NSMutableArray alloc] init];
    arrayRecomendationRecommendation = [[NSMutableArray alloc] init];
    arrayRecomendationPriceTarget = [[NSMutableArray alloc] init];
    arrayRecomendationCurrentPrice = [[NSMutableArray alloc] init];
    arrayRecomendationEstimated = [[NSMutableArray alloc] init];
    arrayRecomendationDate = [[NSMutableArray alloc] init];

    countAux = 0;
    NSURL *urlLast   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?accion=1&cant=30&Ultimas=1"];
    xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlLast];
    [xmlActions setDelegate:self]; //delegamos desde el xml a self
    [xmlActions parse]; //inicializa la rutina de parse
    [_tableRecomendation reloadData];
    
}

- (IBAction) filterUpgrades:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:^{ _buttonLast.alpha = 1; _buttonLast.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonUpgrades.alpha = 0.8; _buttonUpgrades.alpha = 0.8; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonDowgrade.alpha = 1; _buttonDowgrade.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonCorredora.alpha = 1; _buttonCorredora.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonEmpresa.alpha = 1; _buttonEmpresa.alpha = 1; }];
    
    [UIView animateWithDuration:0.2 animations:^{ _tableFilterCorredora.alpha = 0; _arrowCorredora.alpha = 0; }];
    [UIView animateWithDuration:0.2 animations:^{ _tableFilterEmpresa.alpha = 0; _arrowEmpresa.alpha = 0; }];
    
    arrayRecomendationCompany = [[NSMutableArray alloc] init];
    arrayRecomendationMnemonic = [[NSMutableArray alloc] init];
    arrayRecomendationBrokerage = [[NSMutableArray alloc] init];
    arrayRecomendationRecommendation = [[NSMutableArray alloc] init];
    arrayRecomendationPriceTarget = [[NSMutableArray alloc] init];
    arrayRecomendationCurrentPrice = [[NSMutableArray alloc] init];
    arrayRecomendationEstimated = [[NSMutableArray alloc] init];
    arrayRecomendationDate = [[NSMutableArray alloc] init];

    countAux = 0;
    NSURL *urlLast   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?accion=1&cant=30&Mejora=1"];
    xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlLast];
    [xmlActions setDelegate:self]; //delegamos desde el xml a self
    [xmlActions parse]; //inicializa la rutina de parse
    [_tableRecomendation reloadData];
    
}

- (IBAction) filterDownsGrades:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:^{ _buttonLast.alpha = 1; _buttonLast.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonUpgrades.alpha = 1; _buttonUpgrades.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonDowgrade.alpha = 0.8; _buttonDowgrade.alpha = 0.8; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonCorredora.alpha = 1; _buttonCorredora.alpha = 1;}];
    [UIView animateWithDuration:0.2 animations:^{ _buttonEmpresa.alpha = 1; _buttonEmpresa.alpha = 1; }];
     
    [UIView animateWithDuration:0.2 animations:^{ _tableFilterCorredora.alpha = 0; _arrowCorredora.alpha = 0; }];
    [UIView animateWithDuration:0.2 animations:^{ _tableFilterEmpresa.alpha = 0; _arrowEmpresa.alpha = 0; }];

    arrayRecomendationCompany = [[NSMutableArray alloc] init];
    arrayRecomendationMnemonic = [[NSMutableArray alloc] init];
    arrayRecomendationBrokerage = [[NSMutableArray alloc] init];
    arrayRecomendationRecommendation = [[NSMutableArray alloc] init];
    arrayRecomendationPriceTarget = [[NSMutableArray alloc] init];
    arrayRecomendationCurrentPrice = [[NSMutableArray alloc] init];
    arrayRecomendationEstimated = [[NSMutableArray alloc] init];
    arrayRecomendationDate = [[NSMutableArray alloc] init];
    
    NSURL *urlLast   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlaccionesrec.aspx?accion=1&cant=30&Degrada=1"];
    xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlLast];
    [xmlActions setDelegate:self]; //delegamos desde el xml a self
    [xmlActions parse]; //inicializa la rutina de parse
    [_tableRecomendation reloadData];
    
}

- (IBAction) hideFilterCorredora:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:^{ _buttonLast.alpha = 1; _buttonLast.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonUpgrades.alpha = 1; _buttonUpgrades.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonDowgrade.alpha = 1; _buttonDowgrade.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonCorredora.alpha = 0.8; _buttonCorredora.alpha = 0.8;}];
    [UIView animateWithDuration:0.2 animations:^{ _buttonEmpresa.alpha = 1; _buttonEmpresa.alpha = 1; }];
    
    if((_tableFilterCorredora.alpha == 1))
        [UIView animateWithDuration:0.2 animations:^{ _tableFilterCorredora.alpha = 0; _arrowCorredora.alpha = 0; }];
    else
        [UIView animateWithDuration:0.2 animations:^{ _tableFilterCorredora.alpha = 1; _arrowCorredora.alpha = 1; }];
    if((_tableFilterEmpresa.alpha == 1))
        [UIView animateWithDuration:0.1 animations:^{ _tableFilterEmpresa.alpha = 0; _arrowEmpresa.alpha = 0; }];

    
}

- (IBAction) hideFilterEmpresa:(id)sender{

    
    [UIView animateWithDuration:0.2 animations:^{ _buttonLast.alpha = 1; _buttonLast.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonUpgrades.alpha = 1; _buttonUpgrades.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonDowgrade.alpha = 1; _buttonDowgrade.alpha = 1; }];
    [UIView animateWithDuration:0.2 animations:^{ _buttonCorredora.alpha = 1; _buttonCorredora.alpha = 1;}];
    [UIView animateWithDuration:0.2 animations:^{ _buttonEmpresa.alpha = 0.8; _buttonEmpresa.alpha = 0.8; }];
    
    if((_tableFilterEmpresa.alpha == 1))
        [UIView animateWithDuration:0.2 animations:^{ _tableFilterEmpresa.alpha = 0; _arrowEmpresa.alpha = 0; }];
    else
        [UIView animateWithDuration:0.2 animations:^{ _tableFilterEmpresa.alpha = 1; _arrowEmpresa.alpha = 1; }];
    if((_tableFilterCorredora.alpha == 1))
        [UIView animateWithDuration:0.1 animations:^{ _tableFilterCorredora.alpha = 0; _arrowCorredora.alpha = 0; }];
}

//fin filter

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

@end
