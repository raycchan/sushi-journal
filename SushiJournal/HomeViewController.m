//
//  HomeViewController.m
//  SushiJournal
//
//  Created by Raymond on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "SushiTableViewController.h"
#import "GalleryViewController.h"
#import "SushiStore.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];

}

-(void) viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];


    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"galleryViewChosen"]==YES){
        [[SushiStore sharedStore] setGalleryViewChosen: YES];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showJapaneseName"]==YES){
        [[SushiStore sharedStore] setShowJapaneseName: YES];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"englishChosen"]==YES){
        [[SushiStore sharedStore] setEnglishChosen: YES];
    }
     
    [[self view] setBackgroundColor:[UIColor clearColor]];
    
    CALayer *l = [button layer];
    
    [l setMasksToBounds:YES];
    [l setCornerRadius:20.0];
    [l setBorderWidth:2.0];
    [l setBorderColor:[[UIColor blackColor] CGColor]];
    [l setShadowOffset:CGSizeMake(5, 5)];
    [l setShadowColor:[[UIColor blackColor] CGColor]];
    [l setShadowOpacity:0.5];
    
    [button setBackgroundImage:[UIImage imageNamed:@"D_Default-Large.jpg"] forState:UIControlStateNormal];

}

- (void)viewDidUnload
{
    [self setButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)galleryButton:(id)sender {
    
    if ([[[SushiStore sharedStore] sushiDictionary] count] == 0){
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Welcome to the Sushi Journal!" message:@"Loading the default images will just be a few seconds!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [av show];
    } else {
        
    [self pushView];
        
    }
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //cancel
            break;
        case 1:
            //ok
            [[SushiStore sharedStore] populateWithDefault];
            [self pushView];
            break;
        default:
            break;
    }
}

-(void) pushView
{
    if (![[SushiStore sharedStore] galleryViewChosen]) {
        SushiTableViewController *stvc = [[SushiTableViewController alloc] init];
        [[self navigationController] pushViewController:stvc animated:YES];
    } else {
        GalleryViewController *gvc = [[GalleryViewController alloc] init];
        [[self navigationController] pushViewController:gvc animated:YES];
    }
}
@end
