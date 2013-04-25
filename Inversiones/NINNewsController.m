//
//  NINNewsController.m
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

@implementation NINNewsController
@synthesize webView;
@synthesize loanding;
@synthesize backgroundLoanding;

- (void)viewDidLoad
{
    if(indexNews==0)
        _buttonPrevious.hidden = true;
    else
        _buttonPrevious.hidden = false;
    if(indexNews==subtract([arrayNewsID count]))
        _buttonNexs.hidden = true;
    else
        _buttonNexs.hidden = false;
        
    loanding.startAnimating;
    loanding.hidden = true;
    backgroundLoanding.hidden = true;
    
    _tableNews.alpha = 0;
    _tableNews.layer.borderColor = [[UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f] CGColor];
    viewSynthesis.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewSynthesis.layer.borderWidth = 1;
    _tableNews.layer.borderWidth = 3;
    
    if (!arrayNewsTitle || !arrayNewsTitle.count){
        //contenedor para las noticias
        arrayNewsTitle          = [[NSMutableArray alloc] init];
        arrayNewsDescription    = [[NSMutableArray alloc] init];
        arrayNewsGloss          = [[NSMutableArray alloc] init];
        arrayNewsID             = [[NSMutableArray alloc] init];
        arrayNewsImg            = [[NSMutableArray alloc] init];
        arrayNewsTime           = [[NSMutableArray alloc] init];
        arrayNewsText           = [[NSMutableArray alloc] init];
    }
    
    urlNews   = [NSURL URLWithString: @"http://www.elmercurio.com/inversiones/xmlresponse/xml.aspx?key=titulares&fn=titulares"];
    if(stateConnection(urlNews)){
        
        [self performSelector:@selector(showingNews) withObject:nil afterDelay:0.1f];
        if (stateNews == 0){
            [self performSelector:@selector(showingNews) withObject:nil afterDelay:0.1f];
        }else{
            if(stateNews == 1){
                [self performSelector:@selector(showingNewsVf) withObject:nil afterDelay:0.1f];
            }else{
                if(stateNews == 2){
                    [self performSelector:@selector(showingNewsSinthesis) withObject:nil afterDelay:0.1f];
                }
            }
        }
    }else{
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(void) showingNews{
    if (!arrayNewsTitle || !arrayNewsTitle.count){
        if (!arrayNewsTitle || !arrayNewsTitle.count){
            xmlNews = [[NSXMLParser alloc] initWithContentsOfURL:urlNews];
            [xmlNews setDelegate:self]; //delegamos desde el xml a self
            [xmlNews parse]; //inicializa la rutina de parse
            [_tableNews reloadData];
        }
    }
    loanding.hidden = false;
    backgroundLoanding.hidden =false;
    [self showNews];
}

-(void) showingNewsSinthesis{
    if (!arrayNewsTitle || !arrayNewsTitle.count){
        if (!arrayNewsTitle || !arrayNewsTitle.count){
            xmlNews = [[NSXMLParser alloc] initWithContentsOfURL:urlNews];
            [xmlNews setDelegate:self]; //delegamos desde el xml a self
            [xmlNews parse]; //inicializa la rutina de parse
            [_tableNews reloadData];
        }
    }
    
    NSString *strTitle =[[arraySynthesis objectAtIndex:0]objectForKey:@"Titulo"];
    NSString *idNews = [[arraySinthesisId objectAtIndex:0]objectForKey:@"IdNoticia"];
    int intId = [idNews intValue];
    
    urlDetailNews = [NSURL URLWithString:[NSString stringWithFormat: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlnoticia.aspx?key=noticia&id=%i",intId]];
    xmlDetailNews = [[NSXMLParser alloc] initWithContentsOfURL:urlDetailNews];
    [xmlDetailNews setDelegate:self]; //delegamos desde el xml a self
    [xmlDetailNews parse]; //inicializa la rutina de parse
    
    NSString *textFormat  =  formatText([[arrayNewsText objectAtIndex:0]objectForKey:@"Texto"]);
    NSString *html =[NSString stringWithFormat:@"<html>%@<body><h1 class='titulo_nota'>%@</h1><br><div class='content_info_nota'><br><op><div class='contenedor_txt_despliegue'>%@</div></op></div></body></html>",css,strTitle,textFormat];
    
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    arrayNewsText = [[NSMutableArray alloc] init];
    [self performSelector:@selector(stopLoanding) withObject:nil afterDelay:5.0f];
    
}

-(void) showingNewsVf{
    if (!arrayNewsTitle || !arrayNewsTitle.count){
        if (!arrayNewsTitle || !arrayNewsTitle.count){
            xmlNews = [[NSXMLParser alloc] initWithContentsOfURL:urlNews];
            [xmlNews setDelegate:self]; //delegamos desde el xml a self
            [xmlNews parse]; //inicializa la rutina de parse
            [_tableNews reloadData];
        }
    }

    loanding.hidden = false;
    backgroundLoanding.hidden =false;
    
    NSString *Titulo = [[arrayHomeNewsTitle  objectAtIndex:indexNewsVf]objectForKey:@"Titulo"];
    NSString *Id     = [[arrayHomeNewsId  objectAtIndex:indexNewsVf]objectForKey:@"IdNoticia"];
    NSString * strDate =[[arrayHomeNewsDate objectAtIndex:indexNewsVf]objectForKey:@"FechaPublicacion"];
    NSString *dateFotmat = formatDate(strDate);
    
    urlDetailNews = [NSURL URLWithString:[NSString stringWithFormat: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlnoticia.aspx?key=noticia&id=%@",Id]];
    xmlDetailNews = [[NSXMLParser alloc] initWithContentsOfURL:urlDetailNews];
    [xmlDetailNews setDelegate:self]; //delegamos desde el xml a self
    [xmlDetailNews parse]; //inicializa la rutina de parse
    
    NSString *strText       =[[arrayNewsText objectAtIndex:0]objectForKey:@"Texto"];
    NSString *textFormat  =  formatText(strText);
    
    NSString  *html =[NSString stringWithFormat:@"<html>%@<body><div class='fecha_nota'>%@</div><h1 class='titulo_nota'>%@</h1><p class='bajada'></p><br><div class='content_info_nota'><br><op><div class='contenedor_txt_despliegue'>%@</div></op></div></body></html>",css,dateFotmat,Titulo,textFormat];
    
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    arrayNewsText = [[NSMutableArray alloc] init];
    [self performSelector:@selector(stopLoanding) withObject:nil afterDelay:5.0f];
    
    stateNews = 0;
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
    
    if ([elementName isEqualToString:@"Titulo"])
    {
        [item setObject:string forKey:@"Titulo"];
        
        NSString *stringRep = [NSString stringWithFormat:@"%@",item];
        
        if (stringRep.length>20){
            [arrayNewsTitle addObject:item];
        }
    }
    if ([elementName isEqualToString:@"Bajada"])
    {
        [item setObject:string forKey:@"Bajada"];
        [arrayNewsDescription addObject:item];
    }
    if ([elementName isEqualToString:@"IdNoticia"])
    {
        [item setObject:string forKey:@"IdNoticia"];
        [arrayNewsID addObject:item];
    }
    
    if ([elementName isEqualToString:@"FechaPublicacion"])
    {
        [item setObject:string forKey:@"FechaPublicacion"];
        [arrayNewsTime addObject:item];
    }
    
    if ([elementName isEqualToString:@"Texto"])
    {
        [item setObject:string forKey:@"Texto"];
        [arrayNewsText addObject:item];
    }
    
    if ([elementName isEqualToString:@"Url"])
    {
        [item setObject:string forKey:@"Url"];
        [arrayNewsImg addObject:item];
    }
    item=nil;
    string = [NSMutableString string]; //limpiamos el string
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //countAux = ++countAux;
    //NSLog(@"Titulo %@",arrayNewsImg);
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
    if(tableView == _tableNews){
        
        return [arrayNewsID count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        if(tableView == _tableNews){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
    }
        NSString * strTitle =formatAcute([[arrayNewsTitle  objectAtIndex:indexPath.row] objectForKey:@"Titulo"]);
        NSString * strDescription =formatAcute([[arrayNewsDescription  objectAtIndex:indexPath.row]objectForKey:@"Bajada"]);
   
        cell.textLabel.text = strTitle;
        cell.detailTextLabel.text = strDescription;
        cell.textLabel.textColor = [[UIColor alloc] initWithRed:162/255.f green:27/255.f blue:27/255.f alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    loanding.hidden = false;
    backgroundLoanding.hidden = false;
    indexNews = indexPath.row;
    [UIView animateWithDuration:0.2 animations:^{ _tableNews.alpha = 0;_imageArrow.image = [UIImage imageNamed: @""]; }];
   [self showNews];
}

-(void) showNews
{
    if(indexNews==0){
        _buttonPrevious.hidden = true;
    }else
        _buttonPrevious.hidden = false;
    if(indexNews==subtract([arrayNewsID count])){
        _buttonNexs.hidden = true;
    }else
        _buttonNexs.hidden = false;
    
    NSString *idNews = [[arrayNewsID objectAtIndex:indexNews]objectForKey:@"IdNoticia"];
    urlDetailNews = [NSURL URLWithString:[NSString stringWithFormat: @"http://www.elmercurio.com/inversiones/xmlresponse/xmlnoticia.aspx?key=noticia&id=%@",idNews]];
    xmlDetailNews = [[NSXMLParser alloc] initWithContentsOfURL:urlDetailNews];
    [xmlDetailNews setDelegate:self]; //delegamos desde el xml a self
    [xmlDetailNews parse]; //inicializa la rutina de parse
    
    NSString *dateFotmat = formatDate([[arrayNewsTime objectAtIndex:indexNews]objectForKey:@"FechaPublicacion"]);
    NSString * strTitle =[[arrayNewsTitle objectAtIndex:indexNews]objectForKey:@"Titulo"];
    NSString *strUrlImg =[[arrayNewsImg objectAtIndex:indexNews]objectForKey:@"Url"];
    NSString *strDescription =[[arrayNewsDescription objectAtIndex:indexNews]objectForKey:@"Bajada"];
    NSString *textFormat  =  formatText([[arrayNewsText objectAtIndex:0]objectForKey:@"Texto"]);
    NSMutableString *html;
    
    if(strUrlImg.length > 2)
        html =[NSString stringWithFormat:@"<html>%@<body><div class='fecha_nota'>%@<br></div><h1 class='titulo_nota'>%@</h1><div style='clear:both; float: left; width: 400px;'> <img src='%@' alt='Slide'></div><div style='float:left; width: 250px; font-size:19px;'>%@</div><br><div class='content_info_nota'><br>%@<op><div id='p1' class='contenedor_txt_despliegue'>%@</div></op></div></body></html>",css,dateFotmat,strTitle,strUrlImg,strDescription,font,textFormat];
    else
        html =[NSString stringWithFormat:@"<html>%@<body><div class='fecha_nota'>%@</div><h1 class='titulo_nota'>%@</h1><p class='bajada'>%@</p><br><div class='content_info_nota'><br><op><div class='contenedor_txt_despliegue'>%@</div></op></div></body></html>",css,dateFotmat,strTitle,strDescription,textFormat];
    
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    arrayNewsText = [[NSMutableArray alloc] init];
    [self performSelector:@selector(stopLoanding) withObject:nil afterDelay:4.0f];
}


NSString* formatText(NSString *text)
{
    NSString *str = [text stringByReplacingOccurrencesOfString:@": [$]" withString:@"[$"];
    str = [str stringByReplacingOccurrencesOfString:@"[$]" withString:@"]"];
    
    NSMutableString *ms = [NSMutableString stringWithCapacity:[str length]];
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    NSString *s = nil;
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"[$" intoString:&s];
        if (s != nil)
            [ms appendString:s];
        [scanner scanUpToString:@"]" intoString:NULL];
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation]+1];
        s = nil;
    }
    NSString *auxString = [NSString stringWithString:ms];
    auxString = [auxString stringByReplacingOccurrencesOfString:@"haga clic" withString:@""];
    auxString = [auxString stringByReplacingOccurrencesOfString:@"aqu&iacute;" withString:@""];
    return auxString;
}

NSString* formatDate(NSString *strDate)
{
    NSRange rangeYear = {0,4}, rangeMont = {5,2} ,rangeDay = {8,2};
    NSString *year = [strDate substringWithRange:rangeYear], *month = [strDate substringWithRange:rangeMont], *day = [strDate substringWithRange:rangeDay];

    if([month isEqual:@"01"])
        month = @"Enero";else if ([month isEqual:@"02"])
        month = @"Febrero";else if ([month isEqual:@"03"])
        month = @"Marzo";else if ([month isEqual:@"04"])
        month = @"Abril";else if ([month isEqual:@"05"])
        month = @"Mayo";else if ([month isEqual:@"06"])
        month = @"Junio";else if ([month isEqual:@"07"])
        month = @"Julio";else if ([month isEqual:@"08"])
        month = @"Agosto";else if ([month isEqual:@"09"])
        month = @"Septiembre";else if ([month isEqual:@"10"])
        month = @"Octubre";else if ([month isEqual:@"11"])
        month = @"Noviembre";else if ([month isEqual:@"12"])
        month = @"Diciembre";
    
    strDate = [NSString stringWithFormat: @"%@ de %@ del %@",day,month,year];
    return strDate;
}

NSString* formatAcute(NSString *strTitle)
{
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
    return strTitle;
}



bool stateConnection(NSURL *url){
    NSError* error = nil;
    NSString *URLString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        return true;
    }else{
        return false;
    }
}

-(void) stopLoanding{
    loanding.hidden = true;
    backgroundLoanding.hidden = true;
}

- (IBAction) hideTabNews:(id)sender{
    if((_tableNews.alpha == 1))
        [UIView animateWithDuration:0.2 animations:^{ _tableNews.alpha = 0; _imageArrow.image = [UIImage imageNamed: @""];}];
    else
        [UIView animateWithDuration:0.2 animations:^{ _tableNews.alpha = 1; _imageArrow.image = [UIImage imageNamed: @"atras_d.png"];}];
}

int add (int a)
{
    int b = 1; int c;
    c = a + b;
    return c;
}

int subtract (int a)
{
    int b = 1; int c;
    c = a - b;
    return c;
}

////////////

-(IBAction)swipeNewsNext:(id)sender{
    NSLog(@"Index: %i",indexNews);
    NSLog(@"comp: %i",subtract([arrayNewsID count]));
    if(indexNews< subtract([arrayNewsID count])){
        indexNews = add(indexNews);

        [UIView animateWithDuration:0.2 animations:^{ _tableNews.alpha = 0;_imageArrow.image = [UIImage imageNamed: @""]; }];
        [UIView animateWithDuration:2.0f animations:^{
            [self.viewNews setCenter:CGPointMake(-1000.0,480.0)];
        }];
        loanding.hidden = false;
        backgroundLoanding.hidden = false;

        [self performSelector:@selector(viewClear) withObject:nil afterDelay:3.0f];
        [self performSelector:@selector(nextNews) withObject:nil afterDelay:4.0f];
    }
}

-(IBAction)swipeNewsPrevious:(id)sender{
    if(indexNews>0){
        indexNews = subtract(indexNews);
        [UIView animateWithDuration:0.2 animations:^{ _tableNews.alpha = 0;_imageArrow.image = [UIImage imageNamed: @""]; }];
        [UIView animateWithDuration:2.0f animations:^{
            [self.viewNews setCenter:CGPointMake(1300.0,480.0)];
        }];
        loanding.hidden = false;
        backgroundLoanding.hidden = false;
        
        [self performSelector:@selector(viewClear) withObject:nil afterDelay:3.0f];
        [self performSelector:@selector(nextNews) withObject:nil afterDelay:4.0f];
    }
}

-(void) viewClear{
    [self.webView loadHTMLString:@"" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}


-(void) nextNews{
    [self showNews];
    [self.viewNews setCenter:CGPointMake(355.0,480.0)];
}

////////////


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

-(IBAction)changeViewMutualFunds:(id)sender{
    NINMutualFundsController *viewMutualFunds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewMutualFunds =[[NINMutualFundsController alloc] initWithNibName:@"NINMutualFundsView_iPad" bundle:nil];
    } else {
        viewMutualFunds =[[NINMutualFundsController alloc] initWithNibName:@"NINMutualFundsView_iPad" bundle:nil];
    }
    viewMutualFunds.modalPresentationStyle = UIModalPresentationFullScreen;
    viewMutualFunds.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:viewMutualFunds animated:NO completion:nil];
}

- (IBAction) closeView:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
