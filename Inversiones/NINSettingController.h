//
//  NINSettingController.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 23-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINSettingController : UIViewController{

    IBOutlet UIView *viewSettingRecomendation;
    IBOutlet UIView *viewSettingIpsa;
    IBOutlet UIView *viewSettingRankings;
}

@property (nonatomic, retain) IBOutlet UIView *viewSettingRecomendation;
@property (nonatomic, retain) IBOutlet UIView *viewSettingIpsa;
@property (nonatomic, retain) IBOutlet UIView *viewSettingRankings;

@end
