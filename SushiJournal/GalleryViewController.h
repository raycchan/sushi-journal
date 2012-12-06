//
//  GalleryViewController.h
//  SushiJournal
//
//  Created by Raymond on 28/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryItemCell.h"

@interface GalleryViewController : UITableViewController <GalleryItemCellDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

-(void) addSushiItem;
-(void) actionButton;

@end
