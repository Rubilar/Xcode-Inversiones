//
//  NINAppDelegate.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 18-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import "NINAppDelegate.h"
#import "NINHomeController.h"
#import "NINAutentificacionController.h"
#import "NINSettingController.h"
#import "NINActionsController.h"
#import "NINNewsController.h"

@implementation NINAppDelegate


int indexNews            =0;
int indexNewsVf          =0;
int stateNews            =0;
NSString *SettingsSuggestlKey   = @"suggest";
NSString *SettingsIpsaKey       = @"ipsa";
NSString *SettingsRankingKey    = @"ranking";
NSString *Rut                   = @"Rut";
NSString *WebInversiones        = @"http://www.elmercurio.com/inversiones";

NSString *scriptText = @"<script> var min=16; var max=25; function increaseFontSize() {  var p = document.getElementsByTagName('op');  for(i=0;i<p.length;i++) {  if(p[i].style.fontSize) { var s = parseInt(p[i].style.fontSize.replace(\"px\",\"\"));  } else { var s = 16; } if(s!=max) {s += 1; } p[i].style.fontSize = s+\"px\"   }  } function decreaseFontSize() { var p = document.getElementsByTagName('op');  for(i=0;i<p.length;i++) { if(p[i].style.fontSize) { var s = parseInt(p[i].style.fontSize.replace(\"px\",\"\")); } else { var s = 16;  } if(s!=min) { s -= 1;   } p[i].style.fontSize = s+\"px\" }  }</script><style> img { max-width:650px; }</style></head>";                                                                                                                                                                                                          
                                                                                                                                                                                                                 
NSString *font =@"<div class='herramientas-nota'><div class='med-sup-nota-comentarios'><div id='cuDetalleNoticia_divComentarios' class='content-comments fl'></div></div><div class='med-sup-nota-imprsup'><div class='a_mas'><a href='javascript:increaseFontSize();'>A<sup>+</sup></a></div><div class='a_menos'><a href='javascript:decreaseFontSize();'>A<sup>-</sup></a></div></div></div>";

//array news
 NSMutableArray *arrayNewsTitle;
 NSMutableArray *arrayNewsDescription;
 NSMutableArray *arrayNewsGloss;
 NSMutableArray *arrayNewsID;
 NSMutableArray *arrayNewsImg;
 NSMutableArray *arrayNewsTime;
 NSMutableArray *arrayNewsText;
//end News


//array Home
NSMutableArray *thumbnails;
NSMutableArray *tableData;
NSMutableArray *prepTime;
NSMutableArray *webUrls;

// Struct Recomendation
NSMutableArray *arrayHomeRecomendationCompany;
NSMutableArray *arrayHomeRecomendationMnemonic;
NSMutableArray *arrayHomeRecomendationRecommendation;
NSMutableArray *arrayHomeRecomendationCurrentPrice;

// Struct Table Index
NSMutableArray *arrayHomeIndexChileName;
NSMutableArray *arrayHomeIndexChileValue;
NSMutableArray *arrayHomeIndexChileVar;
NSMutableArray *arrayHomeIndexChileTipe;

// Struct Table Gloval
NSMutableArray *arrayHomeIndexGlobalName;
NSMutableArray *arrayHomeIndexGlobalFlag;
NSMutableArray *arrayHomeIndexGlobalValue;
NSMutableArray *arrayHomeIndexGlobalVar;
NSMutableArray *arrayHomeIndexGlobalTipe;

//Array  Banner
NSMutableArray *arrayHomeNewsTitle;
NSMutableArray *arrayHomeNewsDate;
NSMutableArray *arrayHomeNewsUrl;
NSMutableArray *arrayHomeNewsId;

// Struct Banner
NSMutableArray *arrayBannerId;
NSMutableArray *arrayBannerTitle;
NSMutableArray *arrayBannerSeccion;
NSMutableArray *arrayBannerImg;
NSMutableArray *arrayBannerDate;
NSMutableArray *arrayBannerTime;

NSMutableArray *arraySynthesis;
NSMutableArray *arraySinthesisId;
//end Home


//arry Actions
NSMutableArray * arrayRecomendationCompany;
NSMutableArray * arrayRecomendationMnemonic;
NSMutableArray * arrayRecomendationBrokerage;
NSMutableArray * arrayRecomendationRecommendation;
NSMutableArray * arrayRecomendationCurrentPrice;
NSMutableArray * arrayRecomendationPriceTarget;
NSMutableArray * arrayRecomendationEstimated;
NSMutableArray * arrayRecomendationDate;
NSMutableArray * arrayRecomendationNumberStudies;
// end Actions


//array Index


// Struct Table Banner

NSMutableArray * arrayBannerTitle;
NSMutableArray * arrayBannerDescription;
NSMutableArray * arrayBannerImg;

// Struct Table News
NSMutableArray * arrayIndexGlobalName;
NSMutableArray * arrayIndexGlobalFlag;
NSMutableArray * arrayIndexGlobalValue;
NSMutableArray * arrayIndexGlobalVar;
NSMutableArray * arrayIndexGlobalTipe;

// Struct Table News
NSMutableArray * arrayIndexChileName;
NSMutableArray * arrayIndexChileValue;
NSMutableArray * arrayIndexChileVar;
NSMutableArray * arrayIndexChileTipe;

// Struct Table Uf
NSMutableArray * arrayUfName;
NSMutableArray * arrayUfValue;

// Struct Table Utm
NSMutableArray * arrayUtmName;
NSMutableArray * arrayUtmValue;

// Struct Table Currency
NSMutableArray * arrayMoneyName;
NSMutableArray * arrayMoneyValue;
NSMutableArray * arrayMoneyVariation;

//end Index


// Array Mutual Fund

//Array Valor Cuota
NSMutableArray *arrayFundsValueCuotaName;
NSMutableArray *arrayFundsValueCuotaValue;
NSMutableArray *arrayFundsValueCuotaTipe;
NSMutableArray *arrayFundsValueCuotaTime;

//Array Inversiones netas

NSMutableArray *arrayFundsInvestmentsName;
NSMutableArray *arrayFundsInvestmentsValue;
NSMutableArray *arrayFundsInvestmentsPatrimony;
NSMutableArray *arrayFundsInvestmentsTipe;
NSMutableArray *arrayFundsInvestmentsTime;

//Array Series Cuotas

NSMutableArray *arrayFundsSeriesCuotaName;
NSMutableArray *arrayFundsSeriesCuotaValue;
NSMutableArray *arrayFundsSeriesCuotaTipe;
NSMutableArray *arrayFundsSeriesCuotaTime;
NSMutableArray *arrayFundsSeriesCuotaPatrimony;

NSMutableArray *arrayFundsValueWinCuotaNameAux;
NSMutableArray *arrayFundsValueWinCuotaValueAux;
NSMutableArray *arrayFundsValueLoserCuotaNameAux;
NSMutableArray *arrayFundsValueLoserCuotaValueAux;


// //Array Inversiones netas Aux


NSMutableArray *arrayFundsInvestmentsWinNameAux;
NSMutableArray *arrayFundsInvestmentsWinValueAux;
NSMutableArray *arrayFundsInvestmentsWinPatrimonyAux;
NSMutableArray *arrayFundsInvestmentsLoserNameAux;
NSMutableArray *arrayFundsInvestmentsLoserValueAux;
NSMutableArray *arrayFundsInvestmentsLoserPatrimonyAux;

// //Array Auxiliar Series Cuota

NSMutableArray *arrayFundsSeriesLoserCuotaNameAux;
NSMutableArray *arrayFundsSeriesLoserCuotaValueAux;
NSMutableArray *arrayFundsSeriesLoserCuotaPatrimonyAux;
NSMutableArray *arrayFundsSeriesWinCuotaNameAux;
NSMutableArray *arrayFundsSeriesWinCuotaValueAux;
NSMutableArray *arrayFundsSeriesWinCuotaPatrimonyAux;





//Array Valor Cuota

NSMutableArray *arraySeriesFundsValueCuotaName;
NSMutableArray *arraySeriesFundsValueCuotaValue;
NSMutableArray *arraySeriesFundsValueCuotaTipe;
NSMutableArray *arraySeriesFundsValueCuotaTime;

// //Array Auxiliares Valor Cuota

NSMutableArray *arraySeriesFundsValueWinCuotaNameAux;
NSMutableArray *arraySeriesFundsValueWinCuotaValueAux;

NSMutableArray *arraySeriesFundsValueLoserCuotaNameAux;
NSMutableArray *arraySeriesFundsValueLoserCuotaValueAux;

//Array Inversiones netas

NSMutableArray *arraySeriesFundsInvestmentsName;
NSMutableArray *arraySeriesFundsInvestmentsValue;
NSMutableArray *arraySeriesFundsInvestmentsPatrimony;
NSMutableArray *arraySeriesFundsInvestmentsTipe;
NSMutableArray *arraySeriesFundsInvestmentsTime;

// //Array Inversiones netas

NSMutableArray *arraySeriesFundsInvestmentsWinNameAux;
NSMutableArray *arraySeriesFundsInvestmentsWinValueAux;
NSMutableArray *arraySeriesFundsInvestmentsWinPatrimonyAux;

NSMutableArray *arraySeriesFundsInvestmentsLoserNameAux;
NSMutableArray *arraySeriesFundsInvestmentsLoserValueAux;
NSMutableArray *arraySeriesFundsInvestmentsLoserPatrimonyAux;

//Array Series Cuotas

NSMutableArray *arraySeriesFundsSeriesCuotaName;
NSMutableArray *arraySeriesFundsSeriesCuotaValue;
NSMutableArray *arraySeriesFundsSeriesCuotaTipe;
NSMutableArray *arraySeriesFundsSeriesCuotaTime;
NSMutableArray *arraySeriesFundsSeriesCuotaPatrimony;

// Array Auxiliares Series Cuotas

NSMutableArray *arraySeriesFundsSeriesWinCuotaNameAux;
NSMutableArray *arraySeriesFundsSeriesWinCuotaValueAux;
NSMutableArray *arraySeriesFundsSeriesWinCuotaPatrimonyAux;

NSMutableArray *arraySeriesFundsSeriesLoserCuotaNameAux;
NSMutableArray *arraySeriesFundsSeriesLoserCuotaValueAux;
NSMutableArray *arraySeriesFundsSeriesLoserCuotaPatrimonyAux;

NSMutableArray * arrayCorredoraId;
NSMutableArray * arrayCorredoraNombre;

NSMutableArray * arrayEmpresaId;
NSMutableArray * arrayEmpresaNombre;




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], SettingsSuggestlKey,
                                 [NSNumber numberWithBool:YES], SettingsIpsaKey,
                                 [NSNumber numberWithBool:YES], SettingsRankingKey,
                                 [NSNumber numberWithInt:0], Rut,
                                 nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"" forKey:@"newsId"];
    [defaults setObject:@"" forKey:@"newsTitle"];
    [defaults setObject:@"" forKey:@"newsDescription"];
    [defaults setObject:@"" forKey:@"newsGloss"];
    [defaults setObject:@"" forKey:@"newsDate"];
    [defaults setObject:@"" forKey:@"newsImg"];

    [defaults setObject:@"" forKey:@"recommendationCompany"];
    [defaults setObject:@"" forKey:@"recommendationMnemonic"];
    [defaults setObject:@"" forKey:@"recommendationBrokerage"];
    [defaults setObject:@"" forKey:@"recommendationTipe"];
    [defaults setObject:@"" forKey:@"recommendationCurrentPrice"];
    [defaults setObject:@"" forKey:@"recommendationPriceTarget"];
    [defaults setObject:@"" forKey:@"recommendationEstimated"];
    [defaults setObject:@"" forKey:@"recommendationDate"];
    [defaults setObject:@"" forKey:@"recommendationNumberStudies"];

    [defaults setObject:@"http://www.elmercurio.com/inversiones" forKey:@"webInversiones"];
    [defaults synchronize];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/authentication.php"];
    NSURL * serviceUrl = [NSURL URLWithString:ms];
    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
    [serviceRequest setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSError *error;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSString *Test = @"ok";
    
    if(true){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.viewController = [[NINHomeController alloc] initWithNibName:@"NINHomeView_iPhone" bundle:nil];
        } else {
            self.viewController = [[NINHomeController alloc] initWithNibName:@"NINHomeView_iPad" bundle:nil];
        }
    }else{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.viewController = [[NINAutentificacionController alloc] initWithNibName:@"NINAutentificacionView_iPad" bundle:nil];
        } else {
            self.viewController = [[NINAutentificacionController alloc] initWithNibName:@"NINAutentificacionView_iPad" bundle:nil];
        }
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    //[self configureMediaPlayerController];
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{ 
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [[token componentsSeparatedByString:@" "] componentsJoinedByString:@""];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *rut = [defaults objectForKey:@"rut"];
    [defaults setObject:token forKey:@"savedToken"];
    [defaults synchronize];
    
    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/token.php?os=iOS&token="];
    [ms appendString:token];
    [ms appendString:@"&rut="];
    if(rut){
        [ms appendString:rut];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        ms = [[NSMutableString alloc] initWithString:ms];
        [ms appendString:@"&type=iPhone"];
    } else {
        ms = [[NSMutableString alloc] initWithString:ms];
        [ms appendString:@"&type=iPad"];
    }
    NSLog(@"Url: %@",ms);
    
    NSURL * serviceUrl = [NSURL URLWithString:ms];
    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
    [serviceRequest setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSError *error;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"Respuesta ingreso :%@",strdata);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification
{
    NSString *type    = [[notification objectForKey:@"aps"] objectForKey:@"type"];
    NSString *alert = [[notification objectForKey:@"aps"] objectForKey:@"alert"];
    NSString *info = [[notification objectForKey:@"aps"] objectForKey:@"info"];
    
    if([type isEqualToString:@"recomendacion"]){
        // Message in alert
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Recomendación" message:info delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.viewController = [[NINActionsController alloc] initWithNibName:@"NINActionsController" bundle:nil];
        } else {
            self.viewController = [[NINActionsController alloc] initWithNibName:@"NINActionsController" bundle:nil];
        }
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
    if([type isEqualToString:@"ipsa"]){
        // Message in alert
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"IPSA" message:info delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    if([type isEqualToString:@"ranking"]){
        // Message in alert
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Ranking" message:info delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.viewController = [[NINNewsController alloc] initWithNibName:@"NINNewsView_iPad" bundle:nil];
        } else {
            self.viewController = [[NINNewsController alloc] initWithNibName:@"NINNewsView_iPad" bundle:nil];
        }
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)configureMediaPlayerController
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"VideoIntro" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    MPMoviePlayerViewController *moviePlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    moviePlayerView.moviePlayer.controlStyle = MPMovieControlStyleNone;
    moviePlayerView.moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
    
    [self.viewController presentViewController:moviePlayerView animated:NO completion:0];
}

- (void)moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[notification name]
                                                  object:nil];
    [self.viewController dismissViewControllerAnimated:NO completion:0];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stringRut = [NSString stringWithFormat:@"%i", [[defaults objectForKey:Rut] intValue]];
    
    // Add NSString *token = [defaults objectForKey:@"savedToken"];
    
    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/authentication.php?token="];
    [ms appendString:@"123456"];
    [ms appendString:@"&rut="];
    [ms appendString:stringRut];

    NSURL * serviceUrl = [NSURL URLWithString:ms];
    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
    [serviceRequest setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSString *Test = @"ok";
    if(![strdata isEqual: Test]){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.viewController = [[NINAutentificacionController alloc] initWithNibName:@"NINAutentificacionView_iPad" bundle:nil];
        } else {
            self.viewController = [[NINAutentificacionController alloc] initWithNibName:@"NINAutentificacionView_iPad" bundle:nil];
        }
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
     */
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
