//
//  SushiCollection.h
//  SushiJournal
//
//  Created by Raymond on 26/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SushiCollection : NSObject <NSCoding>

@property (copy, nonatomic) NSString *dateTaken;
@property (copy, nonatomic) NSString *restaurantTaken;
@property (assign) BOOL isDefault;
@property (strong, nonatomic) NSData *imageData;
@property (nonatomic, copy) NSString *imageKey;

-(id) setRestaurantTaken:(NSString *)r dateTaken: (NSString *) d isDefault: (BOOL) b image: (UIImage *) i;
-(id) setRestaurantTaken:(NSString *)r dateTaken: (NSString *) d isDefault: (BOOL) b;
-(void) imageSet: (UIImage *) image;


@end
