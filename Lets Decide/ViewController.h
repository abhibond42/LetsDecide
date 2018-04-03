//
//  ViewController.h
//  Lets Decide
//
//  Created by Abhishek Hiremath on 28/03/17.
//  Copyright © 2017 abhishekhiremath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView* bdwond;
@property (strong, nonatomic) NSMutableArray* coloursList;
- (IBAction)clicked:(id)sender;

@property CGAffineTransform startTransform;



@end

