//
//  C4COrderForm.h
//  Agronegocios
//
//  Created by David Almeciga on 11/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CSubmitButtonCell.h"

@interface C4COrderForm : NSObject <FXForm>

@property (nonatomic, strong) NSString * fullName;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSNumber * qty;

@end
