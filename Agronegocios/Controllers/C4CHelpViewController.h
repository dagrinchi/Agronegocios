//
//  C4CHelpViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/30/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4CHelpContentViewController.h"

@interface C4CHelpViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageImages;

@end
