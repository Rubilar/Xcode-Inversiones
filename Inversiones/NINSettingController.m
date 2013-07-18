//
//  NINSettingController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 23-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//  Test

#import "NINSettingController.h"
#import "NINHomeController.h"
#import "NINNewsController.h"
#import "NINWebController.h"
#import "NINActionsController.h"
#import "NINIndexController.h"
#import "NINAppDelegate.h"
#import "NINMutualFundsController.h"
#import <QuartzCore/QuartzCore.h>

@interface NINSettingController ()

@property (nonatomic, weak) IBOutlet UISwitch *suggest;
@property (nonatomic, weak) IBOutlet UISwitch *ipsa;
@property (nonatomic, weak) IBOutlet UISwitch *ranking;

@end

@implementation NINSettingController

@synthesize  viewSettingRecomendation;
@synthesize  viewSettingIpsa;
@synthesize  viewSettingRankings;

@synthesize suggest =_suggest;
@synthesize ipsa    =_ipsa;
@synthesize ranking =_ranking;

#define TAG_SUGGEST     10
#define TAG_IPSA        20
#define TAG_RANKING     30

#pragma mark -

#pragma mark === UIViewController ===
#pragma mark -


- (void)viewDidLoad
{
    
    viewSettingRecomendation.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewSettingRecomendation.layer.borderWidth = 1;
    
    viewSettingIpsa.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewSettingIpsa.layer.borderWidth = 1;
    
    viewSettingRankings.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
    viewSettingRankings.layer.borderWidth = 1;
    
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.suggest.on = [defaults boolForKey:SettingsSuggestlKey];
    self.ipsa.on = [defaults boolForKey:SettingsIpsaKey];
    self.ranking.on = [defaults boolForKey:SettingsRankingKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark === Actions ===
#pragma mark -

- (IBAction)switchToggled:(UISwitch *)sender
{
    NSError *error = nil;
    NSString *webUrl =[[NSUserDefaults standardUserDefaults] stringForKey:@"webInversiones"];
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:webUrl]encoding:NSASCIIStringEncoding error:&error];
    if ( URLString != NULL ) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *loadToken = [defaults objectForKey:@"savedToken"];
        
        switch (sender.tag){
                
            case TAG_SUGGEST:
                [defaults setBool:sender.on forKey:SettingsSuggestlKey];
                if([defaults boolForKey:SettingsSuggestlKey]){
                    
                    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/setting.php?type=1&value=true&token="];
                    [ms appendString:loadToken];
                    NSURL * serviceUrl = [NSURL URLWithString:ms];
                    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
                    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
                    [serviceRequest setHTTPMethod:@"GET"];
                    //eliminar
                    NSURLResponse *response;
                    NSError *error;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
                    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",strdata);
                    //
                    
                }else{
                    
                    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/setting.php?type=1&value=false&token="];
                    [ms appendString:loadToken];
                    NSURL * serviceUrl = [NSURL URLWithString:ms];
                    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
                    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
                    [serviceRequest setHTTPMethod:@"GET"];
                    //eliminar
                    NSURLResponse *response;
                    NSError *error;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
                    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",strdata);
                    //
                    
                }
                break;
                
            case TAG_IPSA:
                [defaults setBool:sender.on forKey:SettingsIpsaKey];
                if([defaults boolForKey:SettingsIpsaKey]){
                    
                    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/setting.php?type=2&value=true&token="];
                    [ms appendString:loadToken];
                    NSURL * serviceUrl = [NSURL URLWithString:ms];
                    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
                    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
                    [serviceRequest setHTTPMethod:@"GET"];
                    //eliminar
                    NSURLResponse *response;
                    NSError *error;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
                    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",strdata);
                    //
                    
                }else{
                    
                    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/setting.php?type=2&value=false&token="];
                    [ms appendString:loadToken];
                    NSURL * serviceUrl = [NSURL URLWithString:ms];
                    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
                    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
                    [serviceRequest setHTTPMethod:@"GET"];
                    //eliminar
                    NSURLResponse *response;
                    NSError *error;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
                    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",strdata);
                    //
                    
                }
                break;
                
            case TAG_RANKING:
                [defaults setBool:sender.on forKey:SettingsRankingKey];
                if([defaults boolForKey:SettingsRankingKey]){
                    
                    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/setting.php?type=3&value=true&token="];
                    [ms appendString:loadToken];
                    NSURL * serviceUrl = [NSURL URLWithString:ms];
                    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
                    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
                    [serviceRequest setHTTPMethod:@"GET"];
                    //eliminar
                    NSURLResponse *response;
                    NSError *error;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
                    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",strdata);
                    //
                    
                }else{
                    
                    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/setting.php?type=3&value=false&token="];
                    [ms appendString:loadToken];
                    NSURL * serviceUrl = [NSURL URLWithString:ms];
                    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
                    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
                    [serviceRequest setHTTPMethod:@"GET"];
                    //eliminar
                    NSURLResponse *response;
                    NSError *error;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
                    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",strdata);
                    //
                }
                break;
        }
        [super viewDidLoad];
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Alerta" message:@"No se encuentra conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [mes show];
    }
}

//Change View //

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
