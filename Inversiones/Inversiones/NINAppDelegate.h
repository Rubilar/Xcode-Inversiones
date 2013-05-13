//
//  NINAppDelegate.h
//  Inversiones
//
//  Created by Nicolas Rubilar on 18-01-13.
//  Copyright (c) 2013 com.neonline.Inversiones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@class NINHomeController;

@interface NINAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NINHomeController *viewController;

extern int indexNews;
extern int indexNewsVf;
extern int stateNews;
extern NSString  *SettingsSuggestlKey;
extern NSString  *SettingsIpsaKey;
extern NSString  *SettingsRankingKey;
extern NSString  *Rut;
extern NSString  *scriptText;
extern NSString  *font;

//array News
extern NSMutableArray *arrayNewsTitle;
extern NSMutableArray *arrayNewsDescription;
extern NSMutableArray *arrayNewsGloss;
extern NSMutableArray *arrayNewsID;
extern NSMutableArray *arrayNewsImg;
extern NSMutableArray *arrayNewsTime;
extern NSMutableArray *arrayNewsText;
//en News

//array Home
extern NSMutableArray *thumbnails;
extern NSMutableArray *tableData;
extern NSMutableArray *prepTime;
extern NSMutableArray *webUrls;


// Struct Recomendation
extern NSMutableArray *arrayHomeRecomendationCompany;
extern NSMutableArray *arrayHomeRecomendationMnemonic;
extern NSMutableArray *arrayHomeRecomendationRecommendation;
extern NSMutableArray *arrayHomeRecomendationCurrentPrice;

// Struct Table Index
extern NSMutableArray *arrayHomeIndexChileName;
extern NSMutableArray *arrayHomeIndexChileValue;
extern NSMutableArray *arrayHomeIndexChileVar;
extern NSMutableArray *arrayHomeIndexChileTipe;

// Struct Table Gloval
extern NSMutableArray *arrayHomeIndexGlobalName;
extern NSMutableArray *arrayHomeIndexGlobalFlag;
extern NSMutableArray *arrayHomeIndexGlobalValue;
extern NSMutableArray *arrayHomeIndexGlobalVar;
extern NSMutableArray *arrayHomeIndexGlobalTipe;

//Array  Banner
extern NSMutableArray *arrayHomeNewsTitle;
extern NSMutableArray *arrayHomeNewsDate;
extern NSMutableArray *arrayHomeNewsUrl;
extern NSMutableArray *arrayHomeNewsId;

// Struct Banner
extern NSMutableArray *arrayBannerId;
extern NSMutableArray *arrayBannerTitle;
extern NSMutableArray *arrayBannerSeccion;
extern NSMutableArray *arrayBannerImg;
extern NSMutableArray *arrayBannerDate;
extern NSMutableArray *arrayBannerTime;

extern NSMutableArray *arraySynthesis;
extern NSMutableArray *arraySinthesisId;

//end Home

// Array Actions

extern NSMutableArray *arrayRecomendationCompany;
extern NSMutableArray *arrayRecomendationMnemonic;
extern NSMutableArray *arrayRecomendationBrokerage;
extern NSMutableArray *arrayRecomendationRecommendation;
extern NSMutableArray *arrayRecomendationCurrentPrice;
extern NSMutableArray *arrayRecomendationPriceTarget;
extern NSMutableArray *arrayRecomendationEstimated;
extern NSMutableArray *arrayRecomendationDate;
extern NSMutableArray *arrayRecomendationNumberStudies;

//end Action

// Struct Table Banner

extern NSMutableArray * arrayBannerTitle;
extern NSMutableArray * arrayBannerDescription;
extern NSMutableArray * arrayBannerImg;

//Struct Table News
extern NSMutableArray * arrayIndexGlobalName;
extern NSMutableArray * arrayIndexGlobalFlag;
extern NSMutableArray * arrayIndexGlobalValue;
extern NSMutableArray * arrayIndexGlobalVar;
extern NSMutableArray * arrayIndexGlobalTipe;

// Struct Table News
extern NSMutableArray * arrayIndexChileName;
extern NSMutableArray * arrayIndexChileValue;
extern NSMutableArray * arrayIndexChileVar;
extern NSMutableArray * arrayIndexChileTipe;


// Struct Table Uf
extern NSMutableArray * arrayUfName;
extern NSMutableArray * arrayUfValue;

// Struct Table Utm
extern NSMutableArray * arrayUtmName;
extern NSMutableArray * arrayUtmValue;

// Struct Table Currency
extern NSMutableArray * arrayMoneyName;
extern NSMutableArray * arrayMoneyValue;
extern NSMutableArray * arrayMoneyVariation;

// Array Mutual

//Array Valor Cuota
extern NSMutableArray *arrayFundsValueCuotaName;
extern NSMutableArray *arrayFundsValueCuotaValue;
extern NSMutableArray *arrayFundsValueCuotaTipe;
extern NSMutableArray *arrayFundsValueCuotaTime;


//Array Inversiones netas
extern NSMutableArray *arrayFundsInvestmentsName;
extern NSMutableArray *arrayFundsInvestmentsValue;
extern NSMutableArray *arrayFundsInvestmentsPatrimony;
extern NSMutableArray *arrayFundsInvestmentsTipe;
extern NSMutableArray *arrayFundsInvestmentsTime;


//Array Series Cuotas
extern NSMutableArray *arrayFundsSeriesCuotaName;
extern NSMutableArray *arrayFundsSeriesCuotaValue;
extern NSMutableArray *arrayFundsSeriesCuotaTipe;
extern NSMutableArray *arrayFundsSeriesCuotaTime;
extern NSMutableArray *arrayFundsSeriesCuotaPatrimony;

extern NSMutableArray *arrayFundsValueWinCuotaNameAux;
extern NSMutableArray *arrayFundsValueWinCuotaValueAux;
extern NSMutableArray *arrayFundsValueLoserCuotaNameAux;
extern NSMutableArray *arrayFundsValueLoserCuotaValueAux;


// //Array Inversiones netas Aux


extern NSMutableArray *arrayFundsInvestmentsWinNameAux;
extern NSMutableArray *arrayFundsInvestmentsWinValueAux;
extern NSMutableArray *arrayFundsInvestmentsWinPatrimonyAux;
extern NSMutableArray *arrayFundsInvestmentsLoserNameAux;
extern NSMutableArray *arrayFundsInvestmentsLoserValueAux;
extern NSMutableArray *arrayFundsInvestmentsLoserPatrimonyAux;


// //Array Auxiliar Series Cuota

extern NSMutableArray *arrayFundsSeriesLoserCuotaNameAux;
extern NSMutableArray *arrayFundsSeriesLoserCuotaValueAux;
extern NSMutableArray *arrayFundsSeriesLoserCuotaPatrimonyAux;
extern NSMutableArray *arrayFundsSeriesWinCuotaNameAux;
extern NSMutableArray *arrayFundsSeriesWinCuotaValueAux;
extern NSMutableArray *arrayFundsSeriesWinCuotaPatrimonyAux;


//end Mutual

// Array mutual Funti

//Array Valor Cuota

extern NSMutableArray *arraySeriesFundsValueCuotaName;
extern NSMutableArray *arraySeriesFundsValueCuotaValue;
extern NSMutableArray *arraySeriesFundsValueCuotaTipe;
extern NSMutableArray *arraySeriesFundsValueCuotaTime;

// //Array Auxiliares Valor Cuota

extern NSMutableArray *arraySeriesFundsValueWinCuotaNameAux;
extern NSMutableArray *arraySeriesFundsValueWinCuotaValueAux;

extern NSMutableArray *arraySeriesFundsValueLoserCuotaNameAux;
extern NSMutableArray *arraySeriesFundsValueLoserCuotaValueAux;

//Array Inversiones netas

extern NSMutableArray *arraySeriesFundsInvestmentsName;
extern NSMutableArray *arraySeriesFundsInvestmentsValue;
extern NSMutableArray *arraySeriesFundsInvestmentsPatrimony;
extern NSMutableArray *arraySeriesFundsInvestmentsTipe;
extern NSMutableArray *arraySeriesFundsInvestmentsTime;

// //Array Inversiones netas

extern NSMutableArray *arraySeriesFundsInvestmentsWinNameAux;
extern NSMutableArray *arraySeriesFundsInvestmentsWinValueAux;
extern NSMutableArray *arraySeriesFundsInvestmentsWinPatrimonyAux;

extern NSMutableArray *arraySeriesFundsInvestmentsLoserNameAux;
extern NSMutableArray *arraySeriesFundsInvestmentsLoserValueAux;
extern NSMutableArray *arraySeriesFundsInvestmentsLoserPatrimonyAux;

//Array Series Cuotas

extern NSMutableArray *arraySeriesFundsSeriesCuotaName;
extern NSMutableArray *arraySeriesFundsSeriesCuotaValue;
extern NSMutableArray *arraySeriesFundsSeriesCuotaTipe;
extern NSMutableArray *arraySeriesFundsSeriesCuotaTime;
extern NSMutableArray *arraySeriesFundsSeriesCuotaPatrimony;

// Array Auxiliares Series Cuotas

extern NSMutableArray *arraySeriesFundsSeriesWinCuotaNameAux;
extern NSMutableArray *arraySeriesFundsSeriesWinCuotaValueAux;
extern NSMutableArray *arraySeriesFundsSeriesWinCuotaPatrimonyAux;

extern NSMutableArray *arraySeriesFundsSeriesLoserCuotaNameAux;
extern NSMutableArray *arraySeriesFundsSeriesLoserCuotaValueAux;
extern NSMutableArray *arraySeriesFundsSeriesLoserCuotaPatrimonyAux;

extern NSMutableArray * arrayCorredoraId;
extern NSMutableArray * arrayCorredoraNombre;

extern NSMutableArray * arrayEmpresaId;
extern NSMutableArray * arrayEmpresaNombre;

//end Array

@end
