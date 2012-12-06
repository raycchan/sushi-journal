//
//  SushiJournalAppDelegate.m
//  SushiJournal
//
//  Created by Raymond on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiJournalAppDelegate.h"
#import "HomeViewController.h"
#import "SushiStore.h"

@implementation SushiJournalAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIView *bgView = [[UIView alloc]initWithFrame:_window.frame];
    
    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [_window addSubview:bgView];
    
    HomeViewController *hvc = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hvc];

    [[self window] setRootViewController:navController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    

}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    BOOL success = [[SushiStore sharedStore] saveChanges]; 
    
    if (success) {
        NSLog(@"Saved all Sushi Items"); } 
    else {
            NSLog(@"Could not save any Sushi Items"); }
    
    [[NSUserDefaults standardUserDefaults] setBool:[[SushiStore sharedStore] galleryViewChosen] forKey:@"galleryViewChosen"];
    [[NSUserDefaults standardUserDefaults] setBool:[[SushiStore sharedStore] showJapaneseName] forKey:@"showJapaneseName"];    
    [[NSUserDefaults standardUserDefaults] setBool:[[SushiStore sharedStore] englishChosen] forKey:@"englishChosen"];
     
}


@end
