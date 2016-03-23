//
//  ShopViewController.h
//  Assessment
//
//  Created by Aarthi Gaddam on 3/21/16.
//  Copyright © 2016 Aarthi Gaddam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include "AFNetworking.h"

@interface ShopViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>
{
    NSMutableArray *arr_caption;
    NSMutableArray *arr_productId;
    NSMutableArray *arr_description;
    
    NSString *str_price;
    NSString *str_brand;
    NSString *str_category;
    NSString *str_productType;
    
}

//Properties
@property(strong, nonatomic)IBOutlet UITextField *txtField_search;

@property(strong, nonatomic)IBOutlet UITableView *tblView_results;

//Methods
-(IBAction)searchPressed:(id)sender;


@end
