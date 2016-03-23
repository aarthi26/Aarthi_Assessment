//
//  ProductDetailsViewController.m
//  Assessment
//
//  Created by Aarthi Gaddam on 3/22/16.
//  Copyright © 2016 Aarthi Gaddam. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getProductDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Product Detail
-(void)getProductDetails
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    str_productId = [[NSUserDefaults standardUserDefaults]valueForKey:@"productId"];
    
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.shop.com/stores/v1/products/%@?apikey=l7xx053008934d4342f48c7f0f87da146194", str_productId]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [self hideIndicator];
            
        } else {
            //NSLog(@"%@ %@", response, responseObject);
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error:nil];
            NSLog(@"response:%@",JSON);
            
            
            NSMutableArray *arr_temp = [JSON valueForKey:@"categoryInfo"];
            //arr_description = [JSON valueForKey:@"description"];
            
            str_brand = [arr_temp valueForKey:@"brand"];
            str_category = [arr_temp valueForKey:@"category"];
            str_productType = [arr_temp valueForKey:@"productType"];
            NSNumber *str_price1 = [JSON valueForKey:@"originalPrice"];
            NSString *str_currency = [JSON valueForKey:@"currency"];
            
            //            NSMutableArray *quickView_array = [temp_array valueForKey:@"modelQuickViewDetails"];
            //            arr_caption = [quickView_array valueForKey:@"caption"];
            //            arr_productId = [quickView_array valueForKey:@"prodID"];
            //            arr_price = [quickView_array valueForKey:@"minPrice"];
            //            arr_linkURL = [quickView_array valueForKey:@"linkUrl"];
            //
            //            NSLog(@"%@",arr_caption);
            //
            //            NSLog(@"%@", quickView_array);
            //
            NSLog(@"%@", str_price);
            NSLog(@"%@", arr_temp);
           // NSLog(@"%@", arr_description);
            
            
            
            //
            //            if(temp_array.count == 0)
            //            {
            //                //[self showFailedAlert];
            //            }
            //
            //            else
            //            {
            //                NSMutableArray *temp_array1 = [temp_array objectAtIndex:0];
            //
            //               // arr_result = [temp_array1 valueForKey:@"lf"];
            //
            //                // NSLog(@"array:%@",temp_array1);
            //
            //                //NSLog(@"meaning:%@",str_meaning);
            //                //self.lbl_Meaning.text = [arr_result objectAtIndex:0];
            //               // [self showSuccessAlert];
            //
            //            }
            
        
            self.lbl_brand.text = str_brand;
            self.lbl_productId.text = [str_productId stringValue];
            self.lbl_productType.text = str_productType;
            self.lbl_category.text = str_category;
            self.lbl_price.text = [str_currency stringByAppendingString:[str_price1 stringValue]];
            
            
            [self hideIndicator];
            
        }
    }];
    
    [dataTask resume];

    
}

#pragma mark- MBProgressHUD
-(void)showIndicator
{
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading...";
}

-(void)hideIndicator
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
