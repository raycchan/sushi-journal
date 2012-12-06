//
//  HomeViewController.h
//  SushiJournal
//
//  Created by Raymond on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)galleryButton:(id)sender;
-(void) pushView;

@end
