//
//  C4CStockNewTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 7/14/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C4CStockNewTableViewController : UITableViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *unitPicker;
- (IBAction)unwindProductList:(UIStoryboardSegue *)segue;

@end
