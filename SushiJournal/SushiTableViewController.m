//
//  SushiTableViewController.m
//  SushiJournal
//
//  Created by Raymond on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiTableViewController.h"
#import "SushiTableItemCell.h"
#import "SushiStore.h"
#import "SushiItem.h"
#import "SushiEditDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SushiCollection.h"
#import "SushiImageStore.h"
#import "GalleryViewController.h"
#import "HomeViewController.h"

@interface SushiTableViewController ()

@end

@implementation SushiTableViewController


-(id) initWithStyle:(UITableViewStyle)style
{
    self=[super initWithStyle:UITableViewStyleGrouped];

    if ([[[SushiStore sharedStore] sushiDictionary] count] < 1)
        [[SushiStore sharedStore] populateWithDefault];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"SushiTableItemCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"SushiTableItemCell"];
    
    [[self navigationItem] setTitle:@"My Sushi"];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButton)];
    
    UIBarButtonItem *bbi2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSushiItem)];

    NSArray *buttons = [[NSArray alloc] initWithObjects:bbi, bbi2, nil];
    [[self navigationItem] setRightBarButtonItems:buttons];   
    
    [[self tableView] setBackgroundColor:[UIColor clearColor]];
}

-(void) resetToDefault
{
    [[SushiStore sharedStore] populateWithDefault];
    [[self tableView] reloadData];
}

-(void) actionButton
{
    NSString *string = [[NSString alloc] init];
    if ([[SushiStore sharedStore] showJapaneseName])
        string = @"Hide Other Name";
    else {
        string = @"Show Other Name";
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Change to Gallery View", string, @"Reset to Default", @"Sort Alphabetical", nil];
    
    [actionSheet showInView:[self view]];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: //show list view
        { [[SushiStore sharedStore] setGalleryViewChosen: ![[SushiStore sharedStore] galleryViewChosen]];
            
                HomeViewController *hvc = [[HomeViewController alloc] init];
                GalleryViewController *newVC = [[GalleryViewController alloc] init];
                
                NSArray *array = [[NSArray alloc] initWithObjects: hvc, newVC, nil];
                
                [[self navigationController] setViewControllers:array animated:YES];
        }
            break;
        case 1: //remove other names
            [[SushiStore sharedStore] setShowJapaneseName:![[SushiStore sharedStore] showJapaneseName]];
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
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nameEng" ascending:YES];
            
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
[[SushiStore sharedStore] populateWithDefault];
[[self navigationController] popViewControllerAnimated:YES];
}

-(void) addSushiItem
{
    SushiItem *newItem = [[SushiItem alloc] initWithEnglish:@"Add your own!"];
    [[[SushiStore sharedStore] sushiDictionary] addObject:newItem];
    [[self tableView] reloadData];
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:([[[SushiStore sharedStore] sushiDictionary] count]-1) inSection:0];
    [[self tableView] scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    

}

-(void) viewWillAppear:(BOOL)animated
{
    
    NSLog(@"check count: %d", [[[SushiStore sharedStore] sushiDictionary] count]);

    [[self tableView] reloadData];
    
    for (SushiItem *item in [[SushiStore sharedStore] sushiDictionary])
         if ([[item collection] count] <=0)
         {
             SushiCollection *newCollectionItem = [[SushiCollection alloc] init];
             
             [[item collection] addObject: newCollectionItem];
             
             [item setCollectionNumber:0];
         }

}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[SushiStore sharedStore] sushiDictionary] count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SushiTableItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SushiTableItemCell"];
    return cell.bounds.size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        SushiTableItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SushiTableItemCell"];
    
        SushiItem *item = [[[SushiStore sharedStore] sushiDictionary]objectAtIndex:indexPath.row];
        
        [[cell nameLabelEnglish] setText:[item nameEng]];

    if([[SushiStore sharedStore] showJapaneseName])
    {[[cell nameLabelJapanese] setText:[item nameJap]];}
    
        SushiCollection *selectedCollection = [[item collection] objectAtIndex:[item collectionNumber]];
        NSString *imageKey = [selectedCollection imageKey];
    
    if(imageKey) {
        UIImage *imagetoDisplay = [[SushiImageStore sharedStore] imageForKey:imageKey];
        [[cell thumbnailView] setImage:imagetoDisplay];
    } else {
        [[cell thumbnailView] setImage:nil];
    }
    
        CALayer *l = [[cell thumbnailView] layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:5.0];
    
        [l setBorderWidth:1.0];
        [l setBorderColor:[[UIColor blackColor] CGColor]];
    
    return cell;
     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SushiEditDetailsViewController *sedvc = [[SushiEditDetailsViewController alloc] init];

    SushiItem *item = [[[SushiStore sharedStore] sushiDictionary] objectAtIndex:indexPath.row];
    
    [sedvc setItem: item];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Save" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];
 
    [[self navigationController] pushViewController:sedvc animated:YES];


 }


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[[SushiStore sharedStore] sushiDictionary] removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    }
}





@end
