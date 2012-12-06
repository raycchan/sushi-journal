//
//  GalleryItemCell.h
//  SushiJournal
//
//  Created by Raymond on 28/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SushiItem;

@protocol GalleryItemCellDelegate <NSObject>
-(void) buttonPressed: (int) i forIndexPathRow: (int) r;
@end

@interface GalleryItemCell : UITableViewCell
{
    id<GalleryItemCellDelegate> delegate;
}
@property (weak, nonatomic) IBOutlet UIImageView *gallery1;
@property (weak, nonatomic) IBOutlet UIImageView *gallery2;
@property (weak, nonatomic) IBOutlet UIImageView *gallery3;
- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;



@property int indexPathRow;

@property (nonatomic, retain) id<GalleryItemCellDelegate> delegate;

-(void) roundEdges;
-(void) clearCell;
@end
