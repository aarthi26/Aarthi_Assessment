//
//  ProductDetailsViewController.h
//  Assessment
//
//  Created by Aarthi Gaddam on 3/22/16.
//  Copyright © 2016 Aarthi Gaddam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface ProductDetailsViewController : UIViewController
{
    NSNumber *str_price;
    NSString *str_brand;
    NSString *str_category;
    NSString *str_productType;
    NSNumber *str_productId;
    
}
@property (strong,nonatomic)IBOutlet UILabel *lbl_productId;
@property (strong, nonatomic)IBOutlet UILabel *lbl_price;
@property (strong, nonatomic)IBOutlet UILabel *lbl_category;
@property (strong, nonatomic)IBOutlet UILabel *lbl_productType;
@property (strong, nonatomic)IBOutlet UILabel *lbl_brand;


@end
