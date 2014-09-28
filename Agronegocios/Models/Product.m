//
//  Product.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "Product.h"


@implementation Product

@dynamic code;
@dynamic name;
@dynamic id;

+ (id) productWithContext:(NSManagedObjectContext *)context {
    Product *product = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Product"
                        inManagedObjectContext:context];
    return product;
}

@end
