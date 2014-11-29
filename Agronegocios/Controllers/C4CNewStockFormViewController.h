//
//  C4CNewStockFormViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "FXForms.h"
#import "C4CStockForm.h"
#import "Token.h"
#import "GeoCode.h"
#import "AddressComponent.h"
#import "NewStock.h"
#import "INTULocationManager.h"

@interface C4CNewStockFormViewController : FXFormViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSArray *geoCodes;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) C4CStockForm *stockForm;

@end
