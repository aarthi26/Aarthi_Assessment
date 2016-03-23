//
//  ImageViewController.m
//  Assessment
//
//  Created by Aarthi Gaddam on 3/21/16.
//  Copyright © 2016 Aarthi Gaddam. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"chosenImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    self.imgView.image = image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
