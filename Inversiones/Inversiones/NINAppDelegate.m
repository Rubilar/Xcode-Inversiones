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
NSString  *styleNews            =@".herramientas-nota { height: 16px; border-top: 1px solid #CCC; border-bottom: 1px solid #CCC; font-family: Arial, Helvetica, sans-serif; font-size: 11px; margin:0 0 15px; padding: 6px 0; float:left; width:100%; } fecha_nota { font-size: 12px; color: #666; font-family:Arial, Helvetica, sans-serif; } h1.titulo_nota { color: #333; font-family:Georgia, \"Times New Roman\", Times, serif; font-size:30px; font-weight:normal; line-height:32px; margin-bottom:10px; }";

NSString *css = @"<head><link rel='stylesheet' type='text/css' href='//ct1.addthis.com/static/r07/widget110.css' media='all'><meta charset='utf-8'><!-- Page title --><meta name='description' content='El Mercurio.com - Inversiones - El periódico líder de noticias en Chile'><style>.herramientas-nota { height: 16px; border-top: 1px solid #CCC; border-bottom: 1px solid #CCC; font-family: Arial, Helvetica, sans-serif; font-size: 11px; margin:0 0 15px; padding: 6px 0; float:left; width:100%; } fecha_nota { font-size: 12px; color: #666; font-family:Arial, Helvetica, sans-serif; } h1.titulo_nota { color: #333; font-family:Georgia, \"Times New Roman\", Times, serif; font-size:30px; font-weight:normal; line-height:32px; margin-bottom:10px; }.a_menos{width:29px; float:right; height:16px;} .a_mas{width:24px; float:right; height:16px;}content_info_nota {	float: right; width: 100%;}  .contenedor_txt_despliegue {float: left; width: 100%; } .contenedor_txt_despliegue p{ font-size: 13px; font-family: Arial, Helvetica, sans-serif; line-height: 20px; font-weight: normal; color: #666; margin-bottom:18px; }.contenedor_txt_despliegue p a{ color:#9B0808; } .contenedor_txt_despliegue p a:hover{ text-decoration:underline; }.contenedor_txt_despliegue p img{ width:643px;height:auto; } </style><!-- CSS --><link rel='stylesheet' type='text/css' href='http://static.elmercurio.com/js/inversiones/libs/lightbox/shadowbox.css'><link rel='stylesheet' href='http://static.elmercurio.com/js/inversiones/libs/gallery/global.css' type='text/css' media='screen'><link rel='stylesheet' href='http://static.elmercurio.com/css/inversiones/tablas/estilo.css'><!-- MENÚ --><script src='https://apis.google.com/_/scs/apps-static/_/js/k=oz.gapi.es.ZWHbpHIVnjY.O/m=plusone/rt=j/sv=1/d=1/ed=1/am=QQ/rs=AItRSTP5hMg2GD70mNkcnuRrcWQr3oRlBw/cb=gapi.loaded_0' async='></script><script type='text/javascript' async=' src='http://www.google-analytics.com/ga.js'></script><script type='text/javascript' async=' src='https://apis.google.com/js/plusone.js' gapi_processed='true'></script><script type='text/javascript' src='http://static.elmercurio.com/js/inversiones/libs/menu/jquery.min.js'></script><script type='text/javascript' src='http://static.elmercurio.com/js/inversiones/libs/menu/funciones_ajax_lp.js'></script><script type='text/javascript' src='http://static.elmercurio.com/js/inversiones/ModificarEstilo.js'></script><script type='text/javascript' src='http://s7.addthis.com/js/250/addthis_widget.js#pub=tucuzoa'></script><div style='visibility: hidden; height: 1px; width: 1px; position: absolute; z-index: 100000; ' id='_atssh'><iframe id='_atssh153' title='AddThis utility frame' style='height: 1px; width: 1px; position: absolute; z-index: 100000; border: 0px; left: 0px; top: 0px; '></iframe></div><script type='text/javascript' src='http://ct1.addthis.com/static/r07/core069.js'></script><!-- LIGHTBOX --><script type='text/javascript' src='http://static.elmercurio.com/js/inversiones/libs/lightbox/shadowbox.js'></script><script type='text/javascript'>Shadowbox.init();</script><!-- GALLERY --><script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js'></script><script type='text/javascript' src='http://gsgd.co.uk/sandbox/jquery/easing/jquery.easing.1.3.js'></script><script type='text/javascript' src='http://static.elmercurio.com/js/inversiones/libs/gallery/slides.min.jquery.js'></script><script type='text/javascript'>$(function() {$('#slides').slides({preload: true,preloadImage: 'img/loading.gif',play: 5000,pause: 2500,hoverPause: true});});</script><script type='text/javascript'>var addthis_config = {ui_language: 'es'}function Shared() {var Url = 'http://www.elmercurio.com/Inversiones/Noticias/Redes/Detallenoticia.aspx?id=903876';var title = 'El nuevo piso del IPSA';Url = encodeURIComponent(Url);eval('svcs = { url: '' + Url + '', title: '' + title + '' }');document.getElementById('fb_share').href = 'http://www.facebook.com/sharer.php?u=' + Url + '&t=' + title;addthis.toolbox('#newface', {}, svcs);document.getElementById('tw_share').href = 'http://twitter.com/share?url=' + Url + '&text=' + title + '&via=EM_Inversiones';addthis.toolbox('#newtwitter', {}, svcs);}function imprimir() {var isIE = (window.navigator.userAgent.indexOf('MSIE') > 0);if (isIE) {//iedocument.frameprint.focus();document.frameprint.print();}else {//otrowindow.frames['frameprint'].focus();window.frames['frameprint'].print();}}</script><!-- Menú mobile --><script type='text/javascript' src='http://static.elmercurio.com/js/inversiones/jquery-latest.js'></script><script type='text/javascript'>$(document).ready(function() {$('.btn_list_menu').click(function() {if ($('.list_menu:first').is(':hidden')) {$('.list_menu').slideDown('slow');} else {$('.list_menu').slideUp();}});});</script><script type='text/javascript'>function showhide(divid, state) {document.getElementById(divid).style.display = state}</script><!-- Fin Menú mobile --><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/jquery.js'></script><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/jquery.flot.js'></script><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/funciones_graficos.js'></script><!-- Tablas --><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/tablas/jquery.co.js'></script><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/tablas/jquery.colu_m.js'></script><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/tablas/jquery.tab_so_f.js'></script><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/tablas/jquery.tips.js'></script><script language='javascript' type='text/javascript' src='http://static.elmercurio.com/js/inversiones/tablas/tabl_01.js'></script><script async=' type='text/javascript' src='http://elmercurioinversiones.disqus.com/count.js'></script><script type='text/javascript' async=' src='http://elmercurioinversiones.disqus.com/embed.js'></script><script src='http://elmercurioinversiones.disqus.com/thread.js?url=http%3A%2F%2Fwww.elmercurio.com%2FInversiones%2FNoticias%2FAcciones%2F2013%2F03%2F26%2FEl-nuevo-piso-del-IPSA.aspx&amp;title=El%20nuevo%20piso%20del%20IPSA&amp;sort=&amp;per_page&amp;category_id=&amp;developer=1&amp;identifier=http%3A%2F%2Fwww.elmercurio.com%2FInversiones%2FNoticias%2FAcciones%2F2013%2F03%2F26%2FEl-nuevo-piso-del-IPSA.aspx&amp;remote_auth_s3=eyJpZCI6ICIxNzMxNDg3NTAwMCIsICJ1c2VybmFtZSIgOiAiTmljb2xhcyBSdWJpbGFyIiAsICJlbWFpbCIgOiAicnViaWxhci5uQGdtYWlsLmNvbSIsICJhdmF0YXIiIDogImh0dHA6Ly9zdGF0aWMuZWxtZXJjdXJpby5jb20vaW1nL2xlZ2FsL25vYXZhdGFyOTIucG5nIn0%3D%202775D399C0FD6F94F3A6AE2F2E3EA23945CB7757%201364827584&amp;api_key=9TPNwpQtGX1XAG2urOfldFHbKsyhxBc7Kr0XNndSZgguIWpUiS0BhWmrhUqwtKao&amp;disqus_version=1364589881&amp;1364827635909' async=' charset='UTF-8'></script><link rel='stylesheet' type='text/css' href='http://mediacdn.disqus.com/1364589881/build/system//defaults.css'><script src='http://mediacdn.disqus.com/1364589881/build/system/disqus.js?' async=' charset='UTF-8'></script><link rel='stylesheet' type='text/css' href='http://mediacdn.disqus.com/1364589881/uploads/themes/7b41bfa5085806dfa24b8c9de0ce567f/theme.css?1'><script src='http://mediacdn.disqus.com/1364589881/uploads/themes/7b41bfa5085806dfa24b8c9de0ce567f/theme.js?1' async=' charset='UTF-8'></script><script src='http://mediacdn.disqus.com/1364589881/build/lang/es_ES.js?' async=' charset='UTF-8'></script><script src='http://juggler.services.disqus.com/event.js?thread_slug=el_nuevo_piso_del_ipsa&amp;user_type=sso&amp;referrer=http%3A%2F%2Fwww.elmercurio.com%2Finversiones%2Facciones%2Findex.aspx&amp;active_switches=%5B%22next_discard_low_rep%22%2C%22disqus_trends%22%2C%22next_comments_truncation_enabled%22%2C%22discovery_next%3Atop_placement%22%2C%22use_rs_paginator_30m%22%2C%22juggler_enabled%22%2C%22upload_media%22%2C%22next_realtime_indicators%22%2C%22discovery_next%3Atruncate%22%2C%22shardpost%3Aindex%22%2C%22community_icon%22%2C%22use_rs_paginator_5m%22%2C%22firehose_push%22%2C%22enable_link_affiliation%22%2C%22limit_textdigger%22%2C%22textdigger_crawler%22%2C%22static_styles%22%2C%22new_sort_paginator%22%2C%22stats%22%2C%22website_addons%22%2C%22firehose_gnip_http%22%2C%22discovery_next%22%2C%22next_dragdrop_nag%22%2C%22firehose_gnip%22%2C%22firehose_pubsub%22%2C%22mentions%22%2C%22use_rs_paginator_60m%22%2C%22discovery_analytics%22%2C%22shardpost%22%2C%22dark_jester%22%2C%22limit_get_posts_days_30d%22%2C%22juggler_thread_onReady%22%5D&amp;theme=Legal&amp;event=init_embed&amp;thread=1166730865&amp;forum=elmercurioinversiones&amp;forum_id=1576780&amp;user_id=40096824&amp;imp=1364827635907793371&amp;prev_imp=1364825915370222468' async=' charset='UTF-8'></script><script> var min=16; var max=25; function increaseFontSize() {  var p = document.getElementsByTagName('op');  for(i=0;i<p.length;i++) {  if(p[i].style.fontSize) { var s = parseInt(p[i].style.fontSize.replace(\"px\",\"\"));  } else { var s = 16; } if(s!=max) {s += 1; } p[i].style.fontSize = s+\"px\"   }  } function decreaseFontSize() { var p = document.getElementsByTagName('op');  for(i=0;i<p.length;i++) { if(p[i].style.fontSize) { var s = parseInt(p[i].style.fontSize.replace(\"px\",\"\")); } else { var s = 16;  } if(s!=min) { s -= 1;   } p[i].style.fontSize = s+\"px\" }  }</script><style> img { max-width:650px; }</style></head>";
                                                                                                                                                                                                                 
                                                                                                                                                                                                                 
NSString *font =@"<div class='herramientas-nota'><div class='med-sup-nota-comentarios'><div id='cuDetalleNoticia_divComentarios' class='content-comments fl'></div></div><div class='med-sup-nota-imprsup'><div class='a_mas'><a href=\"javascript:increaseFontSize();\"><img src='http://static.elmercurio.com/img/inversiones/img-mas.gif'></a></div><div class='a_menos'><a href=\"javascript:decreaseFontSize();\"><img src='http://static.elmercurio.com/img/inversiones/img-menos.gif'></a></div></div></div>";

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
