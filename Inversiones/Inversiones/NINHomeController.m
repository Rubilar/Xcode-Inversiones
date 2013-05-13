//
//  NINHomeController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 18-01-13.
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

@implementation NINHomeController
@synthesize viewFlag;
@synthesize viewIndexs;
@synthesize viewNews;
@synthesize viewActions;
@synthesize viewSynthesis;
@synthesize viewGraphics;
@synthesize webNews;
@synthesize labelDate;
@synthesize labelSynthesis;

- (void)viewDidLoad
{

    countAux =0;
    NSError* error = nil;
    NSString *newsUrl =@"http://www.elmercurio.com/inversiones/herramientas/tablet/graficoapp.aspx";
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:newsUrl] encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        NSURL *Url = [NSURL URLWithString:newsUrl];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:Url];
        [webNews loadRequest:requestObj];
        [super viewDidLoad];
    }else{
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    viewNews.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewActions.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewSynthesis.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewGraphics.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    _sintesis.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewIndexs.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewIndexs.layer.borderWidth = 1;
    viewNews.layer.borderWidth = 1;
    viewActions.layer.borderWidth = 1;
    viewSynthesis.layer.borderWidth = 1;
    viewGraphics.layer.borderWidth = 1;
    _sintesis.layer.borderWidth = 1;
    
    // Date
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE dd MMMM, YYYY"];
    labelDate.text = [dateFormat stringFromDate:today];
    
    if (!arrayHomeNewsTitle || !arrayHomeNewsTitle.count){
        //  Arrays Recomendation
        arrayHomeRecomendationCompany           = [[NSMutableArray alloc] init];
        arrayHomeRecomendationMnemonic          = [[NSMutableArray alloc] init];
        arrayHomeRecomendationRecommendation    = [[NSMutableArray alloc] init];
        arrayHomeRecomendationCurrentPrice      = [[NSMutableArray alloc] init];
    
        //  Arrays Banner
        arrayBannerId           = [[NSMutableArray alloc] init];
        arrayBannerTitle        = [[NSMutableArray alloc] init];
        arrayBannerSeccion      = [[NSMutableArray alloc] init];
        arrayBannerImg          = [[NSMutableArray alloc] init];
        arrayBannerTime         = [[NSMutableArray alloc] init];
        arrayBannerDate         = [[NSMutableArray alloc] init];
    
        //  Arrays Chile
        arrayHomeIndexChileName  = [[NSMutableArray alloc] init];
        arrayHomeIndexChileValue = [[NSMutableArray alloc] init];
        arrayHomeIndexChileVar   = [[NSMutableArray alloc] init];
    
        //  Arrays Global
        arrayHomeIndexGlobalName = [[NSMutableArray alloc] init];
        arrayHomeIndexGlobalValue= [[NSMutableArray alloc] init];
        arrayHomeIndexGlobalVar  = [[NSMutableArray alloc] init];
    
        //  Arrays News
        arrayHomeNewsTitle       = [[NSMutableArray alloc] init];
        arrayHomeNewsDate        = [[NSMutableArray alloc] init];
        arrayHomeNewsUrl         = [[NSMutableArray alloc] init];
        arrayHomeNewsId          = [[NSMutableArray alloc] init];
    
        arraySynthesis           = [[NSMutableArray alloc] init];
        arraySinthesisId         = [[NSMutableArray alloc] init];
        
    }else{
        NSString *synthesis = [[arraySynthesis  objectAtIndex:0] objectForKey:@"Titulo"];
        labelSynthesis.text = synthesis;
    }
    
    urlIndexChile   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=indices_chile"];
    urlIndexGlobal  = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=indices_globales"];
    urlNewsVF       = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=NoticiasVF"];
    urlSynthesis    = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=seccion&fn=cifra"];
    urlBanner       = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=titulares&fn=titulares"];
    urlActions      = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=comun&fn=UltimasRecomendaciones"];;

    if (!arrayHomeNewsTitle || !arrayHomeNewsTitle.count)
        [self performSelector:@selector(startShowing) withObject:nil afterDelay:0.1f];
    if (!arrayHomeNewsTitle || !arrayHomeNewsTitle.count)
        [self performSelector:@selector(startShowingBanner) withObject:nil afterDelay:0.1f];
    
}

-(void) startShowing{

    countAux = 4;
    xmlIndexGloval = [[NSXMLParser alloc] initWithContentsOfURL:urlIndexGlobal];
    [xmlIndexGloval setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexGloval parse]; //inicializa la rutina de parse
    [_tableStockGlobal reloadData];
    
    countAux = 8;
    xmlIndexChile = [[NSXMLParser alloc] initWithContentsOfURL:urlIndexChile];
    [xmlIndexChile setDelegate:self]; //delegamos desde el xml a self
    [xmlIndexChile parse]; //inicializa la rutina de parse
    [_tableStockChile reloadData];
    
    countAux = 12;
    xmlNewsVF = [[NSXMLParser alloc] initWithContentsOfURL:urlNewsVF];
    [xmlNewsVF setDelegate:self]; //delegamos desde el xml a self
    [xmlNewsVF parse]; //inicializa la rutina de parse
    [_tableNews reloadData];
    
    countAux = 16;
    xmlSynthesis = [[NSXMLParser alloc] initWithContentsOfURL:urlSynthesis];
    [xmlSynthesis setDelegate:self]; //delegamos desde el xml a self
    [xmlSynthesis parse]; //inicializa la rutina de parse
    
    countAux = 20;
    xmlActions = [[NSXMLParser alloc] initWithContentsOfURL:urlActions];
    [xmlActions setDelegate:self]; //delegamos desde el xml a self
    [xmlActions parse]; //inicializa la rutina de parse
    [_tableStockRecommended reloadData];
    

}

-(void) startShowingBanner{
    
    
    countAux = 0;
    xmlBanner = [[NSXMLParser alloc] initWithContentsOfURL:urlBanner];
    [xmlBanner setDelegate:self]; //delegamos desde el xml a self
    [xmlBanner parse]; //inicializa la rutina de parse
    [_tableBanner reloadData];
    
    NSError* error = nil;
    NSString *newsUrl =@"http://www.elmercurio.com/inversiones/herramientas/tablet/graficoapp.aspx";
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:newsUrl] encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        NSURL *Url = [NSURL URLWithString:newsUrl];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:Url];
        [webNews loadRequest:requestObj];
        [super viewDidLoad];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
        if ([elementName isEqualToString:@"Titulo"])
        {
            [item setObject:string forKey:@"Titulo"];
            NSString *stringRep = [NSString stringWithFormat:@"%@",item];
            if (stringRep.length>20){
                [arrayBannerTitle addObject:item];
            }
        }
        if ([elementName isEqualToString:@"Seccion"])
        {
            [item setObject:string forKey:@"Seccion"];
            [arrayBannerSeccion addObject:item];
        }
        if ([elementName isEqualToString:@"Url"])
        {
            [item setObject:string forKey:@"Url"];
            [arrayBannerImg addObject:item];
        }
        if ([elementName isEqualToString:@"Bajada"])
        {
            [item setObject:string forKey:@"Bajada"];
            [arrayBannerDate addObject:item];
        }
        if ([elementName isEqualToString:@"FechaPublicacion"])
        {
            [item setObject:string forKey:@"FechaPublicacion"];
            [arrayBannerTime addObject:item];
        }
        if ([elementName isEqualToString:@"IdNoticia"])
        {
            [item setObject:string forKey:@"IdNoticia"];
            [arrayBannerId addObject:item];
        }
    }
    
    // Global
    if(countAux==4){
        if ([elementName isEqualToString:@"nemo"])
        {
            [item setObject:string forKey:@"nemo"];
            [arrayHomeIndexGlobalName addObject:item];
        }
        if ([elementName isEqualToString:@"precio"])
        {
            [item setObject:string forKey:@"precio"];
            [arrayHomeIndexGlobalValue addObject:item];
        }
        if ([elementName isEqualToString:@"variacion_porcentaje"])
        {
            [item setObject:string forKey:@"variacion_porcentaje"];
            [arrayHomeIndexGlobalVar addObject:item];
        }
    }

    // Chile
    if(countAux==8){
        if ([elementName isEqualToString:@"simbolo"])
        {
            [item setObject:string forKey:@"simbolo"];
            [arrayHomeIndexChileName addObject:item];
        }
        if ([elementName isEqualToString:@"precio"])
        {
            [item setObject:string forKey:@"precio"];
            [arrayHomeIndexChileValue addObject:item];
        }
        if ([elementName isEqualToString:@"variacion"])
        {
            [item setObject:string forKey:@"variacion"];
            [arrayHomeIndexChileVar addObject:item];
        }
    }

    if(countAux==12){
        if ([elementName isEqualToString:@"Titulo"])
        {
            [item setObject:string forKey:@"Titulo"];
            [arrayHomeNewsTitle addObject:item];
        }
        if ([elementName isEqualToString:@"FechaPublicacion"])
        {
            [item setObject:string forKey:@"FechaPublicacion"];
            [arrayHomeNewsDate addObject:item];
        }
        if ([elementName isEqualToString:@"Permalink"])
        {
            [item setObject:string forKey:@"Permalink"];
            [arrayHomeNewsUrl addObject:item];
        }
        if ([elementName isEqualToString:@"IdNoticia"])
        {
            [item setObject:string forKey:@"IdNoticia"];
            [arrayHomeNewsId addObject:item];
        }
    }
    if(countAux==16){
        if ([elementName isEqualToString:@"Titulo"])
        {
            [item setObject:string forKey:@"Titulo"];
            [arraySynthesis addObject:item];
            NSIndexPath *index;
            labelSynthesis.text = [[arraySynthesis  objectAtIndex:index.row] objectForKey:@"Titulo"];
        }
            
        if ([elementName isEqualToString:@"IdNoticia"])
        {
            [item setObject:string forKey:@"IdNoticia"];
            [arraySinthesisId addObject:item];
            
        }
    }
    
    if(countAux==20){
        if ([elementName isEqualToString:@"Seccion"])
        {
            [item setObject:string forKey:@"Seccion"];
            [arrayHomeRecomendationCompany addObject:item];
        }
        if ([elementName isEqualToString:@"Subseccion"])
        {
            [item setObject:string forKey:@"Subseccion"];
            [arrayHomeRecomendationMnemonic addObject:item];
        }
        if ([elementName isEqualToString:@"Cuerpo"])
        {
            [item setObject:string forKey:@"Cuerpo"];
            [arrayHomeRecomendationRecommendation addObject:item];
        }
    }

    item=nil;
    string = [NSMutableString string]; //limpiamos el string
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@" Img  %@",arrayBannerImg);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == _tableBanner){
        return [arrayBannerId count];
    }
    if(tableView == _tableStockChile){
        return [arrayHomeIndexGlobalName count];
    }
    if(tableView == _tableStockGlobal){
        int *num = [arrayHomeIndexGlobalName count];
        return --num;
    }
    if(tableView == _tableStockRecommended){
        return [arrayHomeRecomendationMnemonic count];
    }
    if(tableView == _tableMutualFunds){
        return [arrayHomeRecomendationMnemonic count];
    }
    if(tableView == _tableNews){
        return [arrayHomeNewsTitle count];
    }
    
    if(tableView == _tableStockRecommended){
        return [arrayHomeRecomendationCompany count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //UITableViewCellStyleSubtitle tabla con subtitulo
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        if(tableView == _tableBanner){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableStockChile){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableStockGlobal){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableMutualFunds){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(tableView == _tableNews){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        if(tableView == _tableStockRecommended){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    if(tableView == _tableBanner){
        
        NSString *strTitle = [[arrayBannerTitle  objectAtIndex:indexPath.row]objectForKey:@"Titulo"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"é"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"ñ"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Aacute;" withString:@"Á"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Eacute;" withString:@"É"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Iacute;" withString:@"Í"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Oacute;" withString:@"Ó"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Uacute;" withString:@"Ú"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Ntilde;" withString:@"Ñ"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
        
        CGRect artistFrame = CGRectMake(0, 124,230, 35);
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.font = [UIFont boldSystemFontOfSize:11];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.backgroundColor = [[UIColor alloc] initWithRed:215/255.f green:215/255.f blue:215/255.f alpha:1.0];
        artistLabel.textColor = [[UIColor alloc] initWithRed:162/255.f green:27/255.f blue:27/255.f alpha:1.0];
        artistLabel.text = strTitle;
        artistLabel.textAlignment = UITextAlignmentCenter;
        artistLabel.numberOfLines=2;
        
        
        artistLabel.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
        artistLabel.layer.borderWidth = 1;
        
        [cell.contentView addSubview:artistLabel];
    
        NSMutableString *strUrlImg = [[arrayBannerImg  objectAtIndex:indexPath.row]objectForKey:@"Url"];
        
        CGRect albumFrame = CGRectMake(0, 0, 230, 125);
        self.viewFlag = [[UIImageView alloc] initWithFrame:albumFrame];
        self.viewFlag.image = [UIImage imageNamed:@""];

        cell.transform =CGAffineTransformMakeRotation(1.570796326794897);
        NSURL *aUrl = [NSURL URLWithString:strUrlImg];
        if(indexPath.row >3 ){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
                NSData *data0 = [NSData dataWithContentsOfURL:aUrl];
                UIImage *image = [UIImage imageWithData:data0];
                dispatch_sync(dispatch_get_main_queue(), ^(void) {
                    self.viewFlag.image = image;
                });
            });
        }else{
            NSData *data0 = [NSData dataWithContentsOfURL:aUrl];
            UIImage *image = [UIImage imageWithData:data0];
            self.viewFlag.image = image;
        }

        viewFlag.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
        viewFlag.layer.borderWidth = 1;
        [cell.contentView addSubview:self.viewFlag];
        _tableBanner.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _tableBanner.transform=CGAffineTransformMakeRotation(1.570796326794897*3);
    }

    if(tableView == _tableStockChile){
        
        NSString *strFloat = [ cell.detailTextLabel.text = [[arrayHomeIndexChileVar  objectAtIndex:indexPath.row] objectForKey:@"variacion"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        BOOL *tipe = NULL;
        if (strFloatE>0)
            tipe=true;
        
        CGRect varFrame = CGRectMake(270, 5, 40, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text =[[arrayHomeIndexChileVar  objectAtIndex:indexPath.row] objectForKey:@"variacion"];
        albumLabel.textAlignment = NSTextAlignmentRight;
        if (tipe)
            albumLabel.textColor = [UIColor grayColor];
        else
            albumLabel.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:albumLabel];
        
        strFloat  = [[[arrayHomeIndexChileValue  objectAtIndex:indexPath.row] objectForKey:@"precio"] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        strFloatE = (CGFloat)[strFloat floatValue];
        NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        
        CGRect songFrame = CGRectMake(120, 5, 100, 25);
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont systemFontOfSize:14];
        songLabel.highlightedTextColor = [UIColor whiteColor];
        songLabel.text = formattedNumber;
        songLabel.textAlignment = NSTextAlignmentRight;
        songLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:songLabel];

        CGRect artistFrame = CGRectMake(5, 5, 140, 25);
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont systemFontOfSize:15];
        artistLabel.textColor = [UIColor grayColor];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text =   [[arrayHomeIndexChileName  objectAtIndex:indexPath.row] objectForKey:@"simbolo"];
        [cell.contentView addSubview:artistLabel];
    }
    
    if(tableView == _tableStockGlobal){
        
        CGRect artistFrame = CGRectMake(5, 5, 150, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont systemFontOfSize:15];
        artistLabel.textColor = [UIColor grayColor];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text =[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"];
        [cell.contentView addSubview:artistLabel];
        
        NSString *strFloat  = [[[arrayHomeIndexGlobalValue  objectAtIndex:indexPath.row] objectForKey:@"precio"] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        CGFloat strFloatE = (CGFloat)[strFloat floatValue];
        NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        
        CGRect songFrame = CGRectMake(170, 5, 80, 25);
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont systemFontOfSize:14];
        songLabel.highlightedTextColor = [UIColor whiteColor];
        songLabel.text = formattedNumber;
        songLabel.textAlignment = NSTextAlignmentRight;
        songLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:songLabel];
        
        strFloat  = [[[arrayHomeIndexGlobalVar objectAtIndex:indexPath.row] objectForKey:@"variacion_porcentaje"]stringByReplacingOccurrencesOfString:@"," withString:@"."];
        strFloatE = (CGFloat)[strFloat floatValue];
        
        BOOL *tipe = NULL;
        
        if (strFloatE>0) 
            tipe=true;
        formattedNumber = [NSString stringWithFormat:@"%.02f", strFloatE];
        formattedNumber= [formattedNumber stringByReplacingOccurrencesOfString:@"." withString:@","];
        
        CGRect varFrame = CGRectMake(280, 5, 35, 25);
        UILabel *albumLabel = [[UILabel alloc] initWithFrame:varFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:13];
        albumLabel.highlightedTextColor = [UIColor whiteColor];
        albumLabel.text = formattedNumber;
        if (tipe)
            albumLabel.textColor = [UIColor grayColor];
        else
            albumLabel.textColor = [[UIColor alloc] initWithRed:146/255.f green:30/255.f blue:42/255.f alpha:1.0];
        [cell.contentView addSubview:albumLabel];
        
        CGRect albumFrame = CGRectMake(140, 12, 20, 14);
        self.viewFlag = [[UIImageView alloc] initWithFrame:albumFrame];
        
        if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"NASDAQ"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-usa"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"NIKKEI"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-japon"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"FTSE"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-uk"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"BOVESPA"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-brasil"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"IPC"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-mexico"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"MERVAL"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-argentina"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"IGVBL"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-peru"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"DAX"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-alemania"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"Ibex"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-spain"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"CAC 40"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-francia"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"HANG SENG"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-china"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"SHANGAI"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-china"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"DJI"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-uk"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"Lima Selectivo"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-spain"];
        else if([[[arrayHomeIndexGlobalName  objectAtIndex:indexPath.row] objectForKey:@"nemo"]isEqual:@"Ibex 35"])
            self.viewFlag.image = [UIImage imageNamed:@"flag-peru"];
        [cell.contentView addSubview:self.viewFlag];
    }

    if(tableView == _tableMutualFunds){
        
        CGRect artistFrame = CGRectMake(5, 5, 150, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont boldSystemFontOfSize:15];
        artistLabel.highlightedTextColor = [UIColor clearColor];
        artistLabel.text = [tableData objectAtIndex:indexPath.row];
        [cell.contentView addSubview:artistLabel];
        
        CGRect songFrame = CGRectMake(170, 5, 50, 25);
        
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont italicSystemFontOfSize:13];
        songLabel.highlightedTextColor = [UIColor clearColor];
        songLabel.text = [tableData objectAtIndex:indexPath.row];
        songLabel.textColor = [UIColor greenColor];
        [cell.contentView addSubview:songLabel];
        
        CGRect albumFrame = CGRectMake(230, 5, 80, 25);

        UILabel *albumLabel = [[UILabel alloc] initWithFrame:albumFrame] ;
        albumLabel.backgroundColor = [UIColor whiteColor];
        albumLabel.font = [UIFont systemFontOfSize:11];
        albumLabel.highlightedTextColor = [UIColor clearColor];
        albumLabel.text = [tableData objectAtIndex:indexPath.row];
        [cell.contentView addSubview:albumLabel];
    }
    if(tableView == _tableNews){
        
        NSString *strTitle = [[arrayHomeNewsTitle  objectAtIndex:indexPath.row] objectForKey:@"Titulo"];

        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"é"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"ñ"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Aacute;" withString:@"Á"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Eacute;" withString:@"É"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Iacute;" withString:@"Í"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Oacute;" withString:@"Ó"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Uacute;" withString:@"Ú"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&Ntilde;" withString:@"Ñ"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
        strTitle  = [strTitle stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
        
        NSString *strDate = [[arrayHomeNewsDate  objectAtIndex:indexPath.row] objectForKey:@"FechaPublicacion"];
        NSRange rangeYear = {0,4};
        NSRange rangeMont = {5,2};
        NSRange rangeDay = {8,2};
        // NSRange rangeTime = {11,5};
        
        NSString *year  = [strDate substringWithRange:rangeYear];
        NSString *month  = [strDate substringWithRange:rangeMont];
        NSString *day   = [strDate substringWithRange:rangeDay];
        //NSString *time  = [strDate substringWithRange:rangeTime];
        
        if([month isEqual:@"01"]){
            month = @"Enero";
        }else
            if ([month isEqual:@"02"]){
                month = @"Febrero";
            }else
                if ([month isEqual:@"03"]){
                    month = @"Marzo";
                }else
                    if ([month isEqual:@"04"]){
                        month = @"Abril";
                    }else
                        if ([month isEqual:@"05"]){
                            month = @"Mayo";
                        }else
                            if ([month isEqual:@"06"]){
                                month = @"Junio";
                            }else
                                if ([month isEqual:@"07"]){
                                    month = @"Julio";
                                }else
                                    if ([month isEqual:@"08"]){
                                        month = @"Agosto";
                                    }else
                                        if ([month isEqual:@"09"]){
                                            month = @"Septiembre";
                                        }else
                                            if ([month isEqual:@"10"]){
                                                month = @"Octubre";
                                            }
                                            else
                                                if ([month isEqual:@"11"]){
                                                    month = @"Noviembre";
                                                }
                                                else
                                                    if ([month isEqual:@"12"]){
                                                        month = @"Diciembre";
                                                    }
        strDate = [NSString stringWithFormat: @"%@ de %@ del %@",day,month,year];
        
        cell.textLabel.text = strTitle;
        cell.detailTextLabel.text = strDate;
        cell.textLabel.textColor = [[UIColor alloc] initWithRed:162/255.f green:27/255.f blue:27/255.f alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(tableView == _tableStockRecommended){
        
        CGRect artistFrame = CGRectMake(5, 5, 100, 25);
        
        UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistFrame];
        artistLabel.backgroundColor = [UIColor whiteColor];
        artistLabel.font = [UIFont systemFontOfSize:14];
        artistLabel.textColor = [UIColor grayColor];
        artistLabel.highlightedTextColor = [UIColor whiteColor];
        artistLabel.text = [[arrayHomeRecomendationCompany  objectAtIndex:indexPath.row] objectForKey:@"Seccion"];
        [cell.contentView addSubview:artistLabel];
        
        CGRect songFrame = CGRectMake(125, 5, 100, 25);
        
        UILabel *songLabel = [[UILabel alloc] initWithFrame:songFrame];
        songLabel.backgroundColor = [UIColor whiteColor];
        songLabel.font = [UIFont systemFontOfSize:13];
        songLabel.highlightedTextColor = [UIColor whiteColor];
        songLabel.text = [[arrayHomeRecomendationMnemonic  objectAtIndex:indexPath.row] objectForKey:@"Subseccion"];
        songLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:songLabel];
        
        CGRect albuFrame = CGRectMake(240, 5, 100, 25);
        
        UILabel *albuLabel = [[UILabel alloc] initWithFrame:albuFrame] ;
        albuLabel.backgroundColor = [UIColor whiteColor];
        albuLabel.font = [UIFont systemFontOfSize:13];
        albuLabel.textColor = [UIColor grayColor];
        albuLabel.highlightedTextColor = [UIColor whiteColor];
        albuLabel.text = [[arrayHomeRecomendationRecommendation  objectAtIndex:indexPath.row] objectForKey:@"Cuerpo"];
        [cell.contentView addSubview:albuLabel];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableBanner){
        return 235;
    }
    else
        return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableNews){
        
        indexNewsVf = indexPath.row;
        stateNews   = 1;
        [self changeViewNews:nil];
        
    }
    if(tableView == _tableBanner){

        indexNews = indexPath.row;
        [self changeViewNews:nil];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;//UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(IBAction)changeViewNews:(id)sender{
    NINNewsController *ViewNews;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        ViewNews =[[NINNewsController alloc] initWithNibName:@"NINNewsView_iPad" bundle:nil];
    } else {
        ViewNews =[[NINNewsController alloc] initWithNibName:@"NINNewsView_iPad" bundle:nil];
    }
    ViewNews.modalPresentationStyle = UIModalPresentationFullScreen;
    ViewNews.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:ViewNews animated:NO completion:nil];
}


- (IBAction) closeView:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)changeViewSynthesis:(id)sender{
    
    stateNews = 2;
    [self changeViewNews:nil];
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
        viewRecomendation =[[NINActionsController alloc] initWithNibName:@"NINActionsController" bundle:nil];
    } else {
        viewRecomendation =[[NINActionsController alloc] initWithNibName:@"NINActionsController" bundle:nil];
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

-(IBAction)changeViewMutualFunds:(id)sender{
    NINMutualFundsController *viewMutualFunds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewMutualFunds =[[NINMutualFundsController alloc] initWithNibName:@"NINMutualFundsView_iPad" bundle:nil];
    } else {
        viewMutualFunds =[[NINMutualFundsController alloc] initWithNibName:@"NINMutualFundsView_iPad" bundle:nil];
    }
    viewMutualFunds.modalPresentationStyle = UIModalPresentationFullScreen;
    viewMutualFunds.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:viewMutualFunds animated:NO  completion:nil];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////


-(IBAction)swipeGlobalUp:(id)sender{

        [UIView animateWithDuration:1.0f animations:^{
        [self.tableStockGlobal setCenter:CGPointMake(180.0, 80.0)];
        }];
        [UIView animateWithDuration:2.0f animations:^{  _tableStockGlobal.alpha = 1; }];

}

-(IBAction)swipeGlobalDown:(id)sender{
    
    [UIView animateWithDuration:1.0f animations:^{
        [self.tableStockGlobal setCenter:CGPointMake(175.0, 300.0)];
    }];
    [UIView animateWithDuration:2.0f animations:^{  _tableStockGlobal.alpha = 0; }];
    
}



@end
