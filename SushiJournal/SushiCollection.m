//
//  SushiCollection.m
//  SushiJournal
//
//  Created by Raymond on 26/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiCollection.h"
#import "SushiImageStore.h"

@implementation SushiCollection

@synthesize restaurantTaken, dateTaken, isDefault, imageData, imageKey;

-(id) setRestaurantTaken:(NSString *)r dateTaken: (NSString *) d isDefault: (BOOL) b image: (UIImage *) i
{
    
    [self setRestaurantTaken:r dateTaken:d isDefault:b];
    [self imageSet:i];

    return self;
}

-(id) setRestaurantTaken:(NSString *)r dateTaken: (NSString *) d isDefault: (BOOL) b
{
    
    [self setRestaurantTaken:r];
    [self setDateTaken:d];
    [self setIsDefault:b];
    
    return self;
}


-(void) imageSet: (UIImage *) image
{
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
    NSString *key = (__bridge NSString*)newUniqueIDString;
    [self setImageKey:key];
    
    [[SushiImageStore sharedStore] setImage:image forKey:[self imageKey]];
    
    CFRelease(newUniqueIDString); 
    CFRelease(newUniqueID);   
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:restaurantTaken forKey:@"restaurantTaken"];
    [aCoder encodeObject:dateTaken forKey:@"dateTaken"];
    [aCoder encodeObject:imageData forKey:@"imageData"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
    
    [aCoder encodeBool:isDefault forKey:@"isDefault"];
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    
    if (self) {
        restaurantTaken= [[aDecoder decodeObjectForKey:@"restaurantTaken"] copy];
        dateTaken = [[aDecoder decodeObjectForKey:@"dateTaken"] copy];
        imageData = [[aDecoder decodeObjectForKey:@"imageData"] copy];
        imageKey = [[aDecoder decodeObjectForKey:@"imageKey"] copy];
        
        isDefault = [aDecoder decodeBoolForKey:@"isDefault"];
        
    }
    return self;
}

@end
