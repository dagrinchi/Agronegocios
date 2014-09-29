//
//  C4CRootForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CLoginForm.h"
#import "C4CRegistrationForm.h"

@interface C4CRootForm : NSObject <FXForm>

@property (nonatomic, strong) C4CLoginForm * login;
@property (nonatomic, strong) C4CRegistrationForm * registration;

@end
