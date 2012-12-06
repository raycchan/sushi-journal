//
//  SushiCollectionItemCell.m
//  SushiJournal
//
//  Created by Raymond on 26/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiCollectionItemCell.h"



@implementation SushiCollectionItemCell
@synthesize restaurantLabel;
@synthesize dateLabel;
@synthesize collectionThumbnail;
@synthesize selectedLabel;

@synthesize delegate;
@synthesize indexPathRow;


- (IBAction)goToDetails:(id)sender {
    [delegate buttonPressedforIndexPathRow:indexPathRow];
}
@end
