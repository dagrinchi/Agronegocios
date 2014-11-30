//
//  C4CNewOrderFormViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "FXForms.h"
#import "C4COrderForm.h"
#import "Token.h"
#import "GeoCode.h"
#import "AddressComponent.h"
#import "MyPurchases.h"
#import "NewOrder.h"
#import "INTULocationManager.h"
#import "Stock.h"

@interface C4CNewOrderFormViewController : FXFormViewController

@property (nonatomic, strong) C4COrderForm *orderForm;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSArray *geoCodes;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) Stock *stock;

@end
