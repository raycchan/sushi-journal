//
//  SushiItem.m
//  SushiJournal
//
//  Created by Raymond on 20/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiItem.h"
#import "SushiCollection.h"
#import "SushiImageStore.h"

@implementation SushiItem

@synthesize nameEng, nameJap, collectionNumber, defaultImageName;




-(id) initWithNameEng: (NSString*) e nameJap: (NSString*) j defaultImageName: (NSString*) i
{
    self = [super init];
    [self setNameEng:e];
    [self setNameJap:j];
    
    NSString *defaultName = [NSString stringWithFormat:@"D_%@.jpg",i];
    [self setDefaultImageName:defaultName];
    UIImage *defaultImage = [UIImage imageNamed:defaultName];
    
    collection = [[NSMutableArray alloc] init];    
    SushiCollection *newEntry=[[SushiCollection alloc] init];
    [newEntry setRestaurantTaken:@"The Sushi Journal" dateTaken:@"" isDefault:YES image:defaultImage];
    [collection addObject:newEntry];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    NSString *date = [formatter stringFromDate:[NSDate date]];

    
    NSString *defaultName2 = [NSString stringWithFormat:@"D_Default.jpg"];
    UIImage *defaultImage2 = [UIImage imageNamed:defaultName2];
    
    SushiCollection *secondEntry=[[SushiCollection alloc] init];
    [secondEntry setRestaurantTaken:@"Add Your Own!" dateTaken:date isDefault:NO image:defaultImage2];
    [collection addObject:secondEntry];
    
    [self setCollectionNumber:0];
    
    return self;
}

-(id) initWithEnglish: (NSString *) s
{
    self = [super init];
    [self setNameEng:@"New Sushi!"];
    [self setNameJap:@""];
    
    collection = [[NSMutableArray alloc] init];    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    
    NSString *defaultName2 = [NSString stringWithFormat:@"D_Default.jpg"];
    UIImage *defaultImage2 = [UIImage imageNamed:defaultName2];
    
    SushiCollection *secondEntry=[[SushiCollection alloc] init];
    [secondEntry setRestaurantTaken:s dateTaken:date isDefault:NO image:defaultImage2];
    [collection addObject:secondEntry];
    
    [self setCollectionNumber:0];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:nameEng forKey:@"nameEng"];
    [aCoder encodeObject:nameJap forKey:@"nameJap"];
    [aCoder encodeObject:defaultImageName forKey:@"defaultImageName"];

    [aCoder encodeObject:collection forKey:@"collection"];
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    
    if (self) {
        
        nameEng = [[aDecoder decodeObjectForKey:@"nameEng"] copy];
        nameJap = [[aDecoder decodeObjectForKey:@"nameJap"] copy];
        defaultImageName = [[aDecoder decodeObjectForKey:@"defaultImageName"] copy];


        collection = [aDecoder decodeObjectForKey:@"collection"];

    }
    return self;
}

-(NSMutableArray *) collection
{
    return collection;
}

@end


