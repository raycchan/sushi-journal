//
//  SushiEditDetailsViewController.h
//  SushiJournal
//
//  Created by Raymond on 24/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SushiCollectionItemCell.h"

@class SushiItem;

@interface SushiEditDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate, SushiCollectionItemCellDelegate>

@property (retain, nonatomic) IBOutlet UITableView *fullTableView;
@property (weak, nonatomic) IBOutlet UITextField *nameEng;
@property (weak, nonatomic) IBOutlet UITextField *nameJap;

@property (weak, nonatomic) SushiItem *item;
- (IBAction)backgroundTapped:(id)sender;

- (IBAction)addCollectionItem:(id)sender;

-(void) actionButton;

@end
