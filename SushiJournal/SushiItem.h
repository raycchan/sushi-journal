//
//  SushiItem.h
//  SushiJournal
//
//  Created by Raymond on 20/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SushiItem : NSObject <NSCoding>

{
    NSMutableArray *collection; //eventually have an array of sushicollection items
}

@property (copy, nonatomic) NSString *nameEng;
@property (copy, nonatomic) NSString *nameJap;

@property (assign) int collectionNumber;

@property (copy, nonatomic) NSString *defaultImageName;

-(id) initWithNameEng: (NSString*) e nameJap: (NSString*) j defaultImageName: (NSString*) i;
-(NSMutableArray *) collection;
-(id) initWithEnglish: (NSString *) s;

@end
