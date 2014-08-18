//
//  C4CStockNewTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 7/14/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CStockNewTableViewController.h"

#define titleKey @"title"
#define valueKey @"value"

static NSString *_unitCellID = @"unitCell";
static NSString *_unitPickerCellID = @"unitPickerCell";

@interface C4CStockNewTableViewController ()

@property (nonatomic, strong) NSMutableArray *unitPickerData;
@property (assign) NSInteger unitPickerCellRowHeight;

@end

@implementation C4CStockNewTableViewController

-(IBAction)unwindProductList:(UIStoryboardSegue *)segue {
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableViewCell *unitPickerCell = [self.tableView dequeueReusableCellWithIdentifier:_unitPickerCellID];
    self.unitPickerCellRowHeight = CGRectGetHeight(unitPickerCell.frame);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (int) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _unitPickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _unitPickerData[row];
}

- (void) displayInlineUnitPickerForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView beginUpdates];
//    
//    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
//    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    
//    [self.tableView endUpdates];
}

//- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = nil;
//    
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier  isEqual: _unitCellID]) {
        [self displayInlineUnitPickerForRowAtIndexPath:indexPath];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
