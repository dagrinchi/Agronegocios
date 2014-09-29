//
//  Webservice.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#ifndef Agronegocios_Webservice_h
#define Agronegocios_Webservice_h

#define BASE_URL @"http://placita.azurewebsites.net/"

#define GRANT_TYPE @"password"

#define REGISTER_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Account/Register"]

#define TOKEN_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"Token"]

#define PRODUCTS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Products"]

#define UNITS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Units"]

#define PLACES_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Places"]

#define PRICES_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Prices"]

#define NEWSFEEDS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/NewsFeeds"]

#define STOCKS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Stocks"]

#define MYSTOCKS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/MyStocks"]

#define ORDERS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Orders"]

#define MYORDERS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/MyOrders"]

#define MYPURCHASES_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/MyPurchases"]

#endif
