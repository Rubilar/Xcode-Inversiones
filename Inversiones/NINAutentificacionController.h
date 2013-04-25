//
//  NINAutentificacionController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 21-02-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINAutentificacionController : UIViewController{
 
    UILabel *LabelResponds;
    UITextField *textFieldRut;
    
}

@property (nonatomic, retain) IBOutlet UILabel *LabelResponds;
@property (nonatomic, retain) IBOutlet UITextField *textFieldRut;

@end
