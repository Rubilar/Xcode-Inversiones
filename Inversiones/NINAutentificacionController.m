//
//  NINAutentificacionController.m
//  Inversiones
//
//  Created by Nicolas Rubilar on 21-02-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import "NINAppDelegate.h"
#import "NINAutentificacionController.h"
#import "NINHomeController.h"

@implementation NINAutentificacionController
@synthesize textFieldRut;
@synthesize LabelResponds;

- (void)viewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stringRut = [NSString stringWithFormat:@"%i", [[defaults objectForKey:Rut] intValue]];
    textFieldRut.text =stringRut;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) buttonPressed:(id) sender{
    
    [textFieldRut resignFirstResponder];
	LabelResponds.text = textFieldRut.text;
    
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Add NSString *token = [defaults objectForKey:@"savedToken"]; */
    
    NSMutableString* ms = [[NSMutableString alloc] initWithString:@"http://prod.anexos.mersap.com/inversiones/authentication.php?token="];
    [ms appendString:@"123456"]; //Replace for Token
    [ms appendString:@"&rut="];
    [ms appendString:textFieldRut.text];
    
    NSURL * serviceUrl = [NSURL URLWithString:ms];
    NSMutableURLRequest * serviceRequest = [NSMutableURLRequest requestWithURL:serviceUrl];
    [serviceRequest setValue:@"text" forHTTPHeaderField:@"Content-type"];
    [serviceRequest setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:serviceRequest returningResponse:&response error:&error];
    NSString *strdata=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSString *Test = @"ok";
    if([strdata isEqual: Test]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:[textFieldRut.text intValue] forKey:Rut];
        
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
    else{
        LabelResponds.text=strdata;
    }
}

@end
