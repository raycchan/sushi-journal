//
//  SushiCollectionItemCell.h
//  SushiJournal
//
//  Created by Raymond on 26/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SushiCollectionItemCellDelegate <NSObject>
-(void) buttonPressedforIndexPathRow: (int) r;
@end

@interface SushiCollectionItemCell : UITableViewCell
{
    id<SushiCollectionItemCellDelegate> delegate;
}

@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *collectionThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;

@property int indexPathRow;

@property (nonatomic, retain) id<SushiCollectionItemCellDelegate> delegate;


- (IBAction)goToDetails:(id)sender;



@end
