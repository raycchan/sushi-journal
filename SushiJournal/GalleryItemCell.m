//
//  GalleryItemCell.m
//  SushiJournal
//
//  Created by Raymond on 28/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryItemCell.h"
#import <QuartzCore/QuartzCore.h>

#import "SushiItem.h"

@implementation GalleryItemCell
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize gallery1;
@synthesize gallery2;
@synthesize gallery3;
@synthesize indexPathRow;

@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:NO];

}

- (IBAction)button1:(id)sender {
    [delegate buttonPressed:1 forIndexPathRow:indexPathRow];
}

- (IBAction)button2:(id)sender {
    [delegate buttonPressed:2 forIndexPathRow:indexPathRow];
}

- (IBAction)button3:(id)sender {
    [delegate buttonPressed:3 forIndexPathRow:indexPathRow];
}

-(void) roundEdges
{
    NSArray *array = [[NSArray alloc] initWithObjects: gallery1, gallery2, gallery3, nil];
    
    for (UIImageView *view in array){
            CALayer *l = [view layer];
            
            [l setMasksToBounds:YES];
            [l setCornerRadius:5.0];
    }
    
    if ([label3 text] == @"")
            {
    CALayer *l = [gallery3 layer];
           [l setBorderColor:[[UIColor clearColor] CGColor]];    
            }

    if ([label2 text] == @"")
    {
        CALayer *l = [gallery2 layer];
        [l setBorderColor:[[UIColor clearColor] CGColor]];    
    }
    
}

-(void) clearCell
{
    
    [gallery1 setImage:nil];
    [gallery2 setImage:nil];
    [gallery3 setImage:nil];
    [label1 setText:@""];
    [label2 setText:@""];
    [label3 setText:@""];
    
}


@end
