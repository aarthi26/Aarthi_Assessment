//
//  ShopViewController.m
//  Assessment
//
//  Created by Aarthi Gaddam on 3/21/16.
//  Copyright © 2016 Aarthi Gaddam. All rights reserved.
//

#import "ShopViewController.h"
#define CELL_CONTENT_MARGIN 10.0f
#define FONT_SIZE 15.0f

@interface ShopViewController ()

@end

@implementation ShopViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Search Pressed
-(IBAction)searchPressed:(id)sender
{
    [self getSearchResult];
}

#pragma mark - Get Results

-(void)getSearchResult
{
    [self showIndicator];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.shop.com/sites/v1/search/Term/%@?apikey=l7xx053008934d4342f48c7f0f87da146194", self.txtField_search.text]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [self hideIndicator];
            
        } else {
            //NSLog(@"%@ %@", response, responseObject);
            
            // Fetch Data
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error:nil];
            NSLog(@"response:%@",JSON);
            
            NSMutableArray *temp_array = [JSON valueForKey:@"searchItems"];
            
            NSMutableArray *quickView_array = [temp_array valueForKey:@"modelQuickViewDetails"];
            arr_caption = [quickView_array valueForKey:@"caption"];
            arr_productId = [quickView_array valueForKey:@"prodID"];
            
            NSLog(@"%@",arr_caption);
            
            NSLog(@"%@", quickView_array);
            
            NSLog(@"%@", temp_array);
            
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
            
            self.txtField_search.text = @"";
            
            [self hideIndicator];
            [self.tblView_results reloadData];
            
        }
    }];
    
    [dataTask resume];
    NSLog(@"Called First");
    
}


#pragma mark - UITableView DataSource/Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr_caption count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //cell.textLabel.text = [arr_caption objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    //Remove Subviews
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    
    //Create UILabel
    UILabel *lbl_myText = [[UILabel alloc]initWithFrame:CGRectZero];
    [lbl_myText setLineBreakMode:NSLineBreakByWordWrapping];
    lbl_myText.minimumScaleFactor = FONT_SIZE;
    [lbl_myText setNumberOfLines:0];
    lbl_myText.textAlignment = NSTextAlignmentLeft;
    [lbl_myText setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    NSString *text = [arr_caption objectAtIndex:indexPath.row];
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    CGSize constraint = CGSizeMake(screenRect.size.width - (CELL_CONTENT_MARGIN * 3.8), 20000.0f); //// Here Width = Width you want to define for the label in its frame. The height of the label will be adjusted according to this.
        
        //CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        
    CGRect textRect = [text boundingRectWithSize:constraint
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE], NSParagraphStyleAttributeName: paragraphStyle.copy}
                                             context:nil];
        
        CGSize size = textRect.size;
        
        [lbl_myText setText:text];
        [lbl_myText setFrame:CGRectMake(10, CELL_CONTENT_MARGIN, screenRect.size.width -(CELL_CONTENT_MARGIN * 3.8), MAX(size.height, 44.0f))];
    
    //lbl_myText.backgroundColor = [UIColor greenColor];
    
    [cell.contentView addSubview:lbl_myText];

    //Return cell
    return cell;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    
    NSString *cellText = [arr_caption objectAtIndex:indexPath.row];
    CGSize constraint = CGSizeMake(screenRect.size.width - (CELL_CONTENT_MARGIN * 3.8), 20000.0f);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    ////for text label
    CGRect textRect = [cellText boundingRectWithSize:constraint
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE], NSParagraphStyleAttributeName: paragraphStyle.copy}
                                             context:nil];
    
    CGSize labelsize = textRect.size;
    
    
    ///combine the height
    CGFloat height = MAX(labelsize.height + 20, 44.0f);

    return height;
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSUserDefaults standardUserDefaults]setValue:[arr_productId objectAtIndex:indexPath.row] forKey:@"productId"];
    
    [self performSegueWithIdentifier:@"details" sender:nil];
    

}
@end
