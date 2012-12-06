//
//  SushiTableItemCell.h
//  Sushi Journal
//
//  Created by Raymond on 17/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SushiTableItemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabelEnglish;
@property (weak, nonatomic) IBOutlet UILabel *nameLabelJapanese;


@property (weak, nonatomic) UITableView *tableView;



@end
