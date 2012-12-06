//
//  SushiStore.h
//  SushiJournal
//
//  Created by Raymond on 20/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SushiStore : NSObject
{
    NSMutableArray *sushiDictionary;
}

+(SushiStore *) sharedStore;
-(void) populateWithDefault;
-(NSString *) itemArchivePath;
-(BOOL)saveChanges;
-(NSMutableArray *) sushiDictionary;


-(void) setSushiDictionaryUsing: (NSArray *) array;

@property BOOL englishChosen;
@property BOOL galleryViewChosen;
@property BOOL showJapaneseName;

@end
