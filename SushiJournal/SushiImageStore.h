//
//  SushiImageStore.h
//  Homepwner
//
//  Created by Raymond on 16/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SushiImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+(SushiImageStore *) sharedStore;

-(void)setImage: (UIImage *)i forKey: (NSString *)s;
-(UIImage *)imageForKey: (NSString *)s;
-(void)deleteImageForKey: (NSString *)s;
-(NSString *)imagePathForKey:(NSString *) key;

@end
