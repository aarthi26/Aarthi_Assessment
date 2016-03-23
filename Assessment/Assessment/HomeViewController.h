//
//  HomeViewController.h
//  Assessment
//
//  Created by Aarthi Gaddam on 3/21/16.
//  Copyright © 2016 Aarthi Gaddam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
}

//Methods
-(IBAction)cameraPressed:(id)sender;
-(IBAction)shopPressed:(id)sender;
@end
