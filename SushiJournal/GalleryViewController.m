//
//  GalleryViewController.m
//  SushiJournal
//
//  Created by Raymond on 28/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryItemCell.h"
#import "SushiStore.h"
#import "SushiItem.h"
#import "SushiCollection.h"
#import "SushiImageStore.h"
#import "SushiEditDetailsViewController.h"
#import "HomeViewController.h"
#import "SushiTableViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        if ([[[SushiStore sharedStore] sushiDictionary] count] < 1)
            [[SushiStore sharedStore] populateWithDefault];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"GalleryItemCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"GalleryItemCell"];
    
    [[self tableView] setSeparatorColor:[UIColor clearColor]];
    
    [[self navigationItem] setTitle:@"My Sushi"];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSushiItem)];
    
    UIBarButtonItem *bbi2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButton)];
    
    NSArray *array = [NSArray arrayWithObjects:bbi2, bbi, nil];
    
    [[self navigationItem] setRightBarButtonItems:array];
    
    [[self tableView] setBackgroundColor:[UIColor clearColor]];

}

-(void) addSushiItem
{
    SushiItem *newItem = [[SushiItem alloc] initWithEnglish:@"Add your own!"];
    [[[SushiStore sharedStore] sushiDictionary] addObject:newItem];
    [[self tableView] reloadData];
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:(([[[SushiStore sharedStore] sushiDictionary] count]-1)/3) inSection:0];
    [[self tableView] scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(void) actionButton
{
    NSString *string = [[NSString alloc] init];
    
    if ([[SushiStore sharedStore] englishChosen]) {
        string = @"Switch to Other Name";
    } else {
        string = @"Switch to English Name";
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Change to List View", string, @"Reset to Default", @"Sort Alphabetical", nil];;    
    
    [actionSheet showInView:[self view]];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: //show list view
        {
        [[SushiStore sharedStore] setGalleryViewChosen: ![[SushiStore sharedStore] galleryViewChosen]];
            
                HomeViewController *hvc = [[HomeViewController alloc] init];
                SushiTableViewController *newVC = [[SushiTableViewController alloc] init];
            
                NSArray *array = [[NSArray alloc] initWithObjects: hvc, newVC, nil];
                
                [[self navigationController] setViewControllers:array animated:YES];
        }
            break;
        case 1: //toggle names
            [[SushiStore sharedStore] setEnglishChosen: ![[SushiStore sharedStore] englishChosen]];
            [[self tableView] reloadData];
            break;
        case 2: //reset to default
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reset to Defaults" message:@"Are you sure? This will remove all saved names and images" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            
            [alertView show];
        }
            break;
        case 3: //sort alphabetical
        {
            NSString *language;
            if (![[SushiStore sharedStore] englishChosen]) {
                language = @"nameJap";
            } else {
                language = @"nameEng";
            }            
            
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:language ascending:YES];
            
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [[[SushiStore sharedStore] sushiDictionary] sortedArrayUsingDescriptors:sortDescriptors];
            
            [[SushiStore sharedStore] setSushiDictionaryUsing:sortedArray];
            
            [[self tableView] reloadData];

        }  
            break;
        default:
            break;
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
             [[self navigationController] popViewControllerAnimated:YES];
            
            break;
        default:
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([[[SushiStore sharedStore] sushiDictionary] count]+2)/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryItemCell"];
    [cell clearCell];
    
    
    [cell setDelegate:self];
    [cell setIndexPathRow:indexPath.row];
    
    NSArray *array = [[SushiStore sharedStore] sushiDictionary];

    for (int i = 0; i < 3; i++)
        {
            SushiItem *item = [[SushiItem alloc] init];
            
            if((3*indexPath.row + i) < [array count])
            {
                
            item = [array objectAtIndex:indexPath.row*3 + i];
            
            SushiCollection *selectedCollection = [[item collection] objectAtIndex:[item collectionNumber]];
            NSString *imageKey = [selectedCollection imageKey];
            
    if(imageKey) {
                UIImage *imagetoDisplay = [[SushiImageStore sharedStore] imageForKey:imageKey];
        NSString *string = [[NSString alloc] init];
        if (![[SushiStore sharedStore] englishChosen]) {
            string = [item nameJap];            
        } else {
            string = [item nameEng];
        }
        
        switch (i) {
            case 0:
            {
                [[cell gallery1] setImage:imagetoDisplay];
                [[cell label1] setText: string];
                
                CALayer *l = [[cell gallery1] layer];
                [l setBorderWidth:1.0];
                [l setBorderColor:[[UIColor blackColor] CGColor]];
            }
                break;
            case 1:
            {
                [[cell gallery2] setImage:imagetoDisplay];
                [[cell label2] setText:string];
                
                CALayer *m = [[cell gallery2] layer];
                [m setBorderWidth:1.0];
                [m setBorderColor:[[UIColor blackColor] CGColor]];
            }
                break;
            case 2:
            {
                [[cell gallery3] setImage:imagetoDisplay];
                [[cell label3] setText:string];  
                
                CALayer *f = [[cell gallery3] layer];
                [f setBorderWidth:1.0];
                [f setBorderColor:[[UIColor blackColor] CGColor]];
            }
                break;
            default:
                break;
        }

    }}
            [cell roundEdges];
        }
        
    return cell;
}



-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryItemCell"];
    return cell.bounds.size.height;
    
}



-(void) buttonPressed: (int) i forIndexPathRow:(int)r
{
    SushiEditDetailsViewController *sevc = [[SushiEditDetailsViewController alloc] init];
    
    int maxItems = [[[SushiStore sharedStore] sushiDictionary] count];
    int itemPressed = (r*3+i-1);
    
    if (itemPressed<maxItems){
    
    SushiItem *item = [[[SushiStore sharedStore] sushiDictionary] objectAtIndex:itemPressed];
    
    [sevc setItem:item];    
    
    [[self navigationController] pushViewController:sevc animated:YES];
    }
}


@end
