//
//  C4CLoginForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CPasswordCell.h"

@interface C4CLoginForm : NSObject <FXForm, FXModelValidation>

@property (nonatomic, copy) NSString *identification;
@property (nonatomic, copy) NSString *password;

- (NSDictionary *)getField :(NSString *) key;

@end
