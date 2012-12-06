//
//  SushiTableViewController.h
//  SushiJournal
//
//  Created by Raymond on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SushiTableViewController : UITableViewController <UIActionSheetDelegate, UIAlertViewDelegate>

-(void) resetToDefault;
-(void) addSushiItem;
-(void) actionButton;


@end
