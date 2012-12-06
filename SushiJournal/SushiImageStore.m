//
//  SushiImageStore.m
//  Homepwner
//
//  Created by Raymond on 16/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiImageStore.h"

@implementation SushiImageStore

+(SushiImageStore *) sharedStore
{
    static SushiImageStore *sharedStore=nil;
    if (!sharedStore){
        sharedStore=[[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+(id) allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(id)init
{
    self=[super init];
    if(self){
        dictionary=[[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

//clear cache when memory is low
-(void) clearCache: (NSNotification *) note
{
    [dictionary removeAllObjects];
}

-(void)setImage: (UIImage *)i forKey: (NSString *)s
{
    [dictionary setObject:i forKey:s]; 
    
    NSString *imagePath = [self imagePathForKey:s];
    NSData *d=UIImageJPEGRepresentation(i, 0.5);
    [d writeToFile:imagePath atomically:YES];
}

-(UIImage *)imageForKey: (NSString *)s
{
    UIImage *result = [dictionary objectForKey:s];
    
    if (!result) {

        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];

        if (result)
            [dictionary setObject:result forKey:s];
        else
            NSLog(@"Error - unable to find %@", [self imagePathForKey:s]);      
    }
    return result;
}
-(void)deleteImageForKey: (NSString *)s
{
    if(!s)
        return;
    [dictionary removeObjectForKey:s];
    

    NSString *path=[self imagePathForKey:s];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

-(NSString *)imagePathForKey:(NSString *) key
{
    NSArray *documentDirectories=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:key];
}




@end
