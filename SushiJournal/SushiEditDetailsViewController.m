//
//  SushiEditDetailsViewController.m
//  SushiJournal
//
//  Created by Raymond on 24/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiEditDetailsViewController.h"
#import "SushiItem.h"
#import "SushiStore.h"
#import "SushiCollectionItemCell.h"
#import "SushiCollection.h"
#import <QuartzCore/QuartzCore.h>
#import "CollectionEditViewController.h"
#import "SushiImageStore.h"

@interface SushiEditDetailsViewController ()

@end

@implementation SushiEditDetailsViewController


@synthesize fullTableView;
@synthesize nameEng;
@synthesize nameJap;

@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        [fullTableView setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [nameEng setText:[item nameEng]];
    [nameJap setText:[item nameJap]];
    
    [nameEng setDelegate:self];
    [nameJap setDelegate:self];
    
    [fullTableView reloadData];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
   
    [item setNameEng:[nameEng text]];
    [item setNameJap:[nameJap text]];
    
    if ([[item collection] count] <=0)
    {
        SushiCollection *newCollectionItem = [[SushiCollection alloc] init];
        
        [[item collection] addObject: newCollectionItem];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd, yyyy"];
        
        NSString *date = [formatter stringFromDate:[NSDate date]];
        
        NSString *defaultName = [NSString stringWithFormat:@"D_Default.jpg"];
        UIImage *defaultImage = [UIImage imageNamed:defaultName];
        
        [newCollectionItem setRestaurantTaken:@"New Entry!" dateTaken:date isDefault:NO image:defaultImage];
        
        [item setCollectionNumber:0];
    }
    
    
    BOOL success = [[SushiStore sharedStore]saveChanges]; 
    
    if (success) {
        NSLog(@"Saved all Sushi Items"); } 
    else {
        NSLog(@"Could not save any Sushi Items"); }
}

- (IBAction)backgroundTapped:(id)sender 
{
    [[self view] endEditing:YES];
    
    [item setNameEng:[nameEng text]];
    [item setNameJap:[nameJap text]];
    
    BOOL success = [[SushiStore sharedStore]saveChanges]; 
    
    if (success) {
        NSLog(@"Saved all Sushi Items"); } 
    else {
        NSLog(@"Could not save any Sushi Items"); }
}

- (IBAction)addCollectionItem:(id)sender { 
    
    SushiCollection *newCollectionItem = [[SushiCollection alloc] init];
    
    [[item collection] addObject: newCollectionItem];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    NSString *date = [formatter stringFromDate:[NSDate date]];

    NSString *defaultName = [NSString stringWithFormat:@"D_Default.jpg"];
    UIImage *defaultImage = [UIImage imageNamed:defaultName];

    [newCollectionItem setRestaurantTaken:@"New Entry!" dateTaken:date isDefault:NO image:defaultImage];
    
    [fullTableView reloadData];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:([[item collection] count]-1) inSection:0];
    [fullTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
    {
    [textField resignFirstResponder];
        
        [item setNameEng:[nameEng text]];
        [item setNameJap:[nameJap text]];
        
        BOOL success = [[SushiStore sharedStore]saveChanges]; 
        
        if (success) {
            NSLog(@"Saved all Sushi Items"); } 
        else {
            NSLog(@"Could not save any Sushi Items"); }
        
    return YES; 
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"SushiCollectionItemCell" bundle:nil];
    [[self fullTableView] registerNib:nib forCellReuseIdentifier:@"SushiCollectionItemCell"];
    
    [[self navigationItem] setTitle:@"My Collection"];
    
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButton)];
    
    [[self navigationItem] setRightBarButtonItem:bbi];
    
}

-(void) actionButton
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete Sushi Entry", @"Add Default Picture", nil];
    
    [actionSheet showInView:[self view]];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: //delete entry
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete Sushi Entry" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            
            [alertView setTag:1];
            [alertView show]; 
            

        }
            break;
        case 1: //restore default entry
        {    
            
            if([item defaultImageName]){
            SushiCollection *newCollectionItem = [[SushiCollection alloc] init];
            
            [[item collection] addObject: newCollectionItem];
            UIImage *defaultImage = [UIImage imageNamed:[item defaultImageName]];
            
            [newCollectionItem setRestaurantTaken:@"The Sushi Journal" dateTaken:@"" isDefault:YES image:defaultImage];
            
            [fullTableView reloadData];
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:([[item collection] count]-1) inSection:0];
            [fullTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Default Picture" message:@"Could not add picture as this is not a default entry." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alertView setTag:2];
                [alertView show];
            }
            
        }
            break;
        default:
            break;
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) { //Delete sushi entry
       [[[SushiStore sharedStore] sushiDictionary] removeObjectIdenticalTo:item];
       [[self navigationController] popViewControllerAnimated:YES];   
    } 
    
}
- (void)viewDidUnload
{
    [self setNameEng:nil];
    [self setNameJap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return [[item collection] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SushiCollectionItemCell *cell = [fullTableView dequeueReusableCellWithIdentifier:@"SushiCollectionItemCell"];
    
    SushiCollection *collectionItem = [[item collection] objectAtIndex:indexPath.row];
    
    [cell setDelegate:self];
    [cell setIndexPathRow:indexPath.row];
    
    [[cell restaurantLabel] setText:[collectionItem restaurantTaken]];
    [[cell dateLabel] setText:[collectionItem dateTaken]];
    
    SushiCollection *selectedCollection = [[item collection] objectAtIndex:indexPath.row];
    NSString *imageKey = [selectedCollection imageKey];
    
    if(imageKey) {
        UIImage *imagetoDisplay = [[SushiImageStore sharedStore] imageForKey:imageKey];
        [[cell collectionThumbnail] setImage:imagetoDisplay];
    } else {
        [[cell collectionThumbnail] setImage:nil];
    }
    
    CALayer *l = [[cell collectionThumbnail] layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];
    
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor blackColor] CGColor]];

    if ([item collectionNumber] != indexPath.row) {
        [[cell selectedLabel] setHidden:TRUE];
    } else {
        [[cell selectedLabel] setHidden:FALSE];
    }

    
    
    return cell;
    

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];

    [item setCollectionNumber: indexPath.row];

    
    [tableView reloadData];

    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SushiCollectionItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SushiCollectionItemCell"];
    return cell.bounds.size.height;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[item collection] removeObjectAtIndex:indexPath.row];
        
        if([item collectionNumber] >= indexPath.row)
            {[item setCollectionNumber:([item collectionNumber] - 1)];}
        
        if(![item collectionNumber] || [item collectionNumber] < 0)
            {[item setCollectionNumber:0];}
    
        
        [tableView reloadData];
    }
}

-(void) buttonPressedforIndexPathRow:(int)r
{
    if([[item collection] count] > 0)
    {
        CollectionEditViewController *cevc = [[CollectionEditViewController alloc] init];    
        
        SushiCollection *collectionItem = [[item collection] objectAtIndex: r];
        [cevc setCollectionItem:collectionItem];
        
        NSString *string = [[NSString alloc] init];
        
        if ([[item nameEng] length] == 0 && [[item nameJap] length] == 0)
        {
            string = @"No name set..";
        } else if ([[item nameEng] length] == 0) {
            string = [item nameJap];
        } else if ([[item nameJap] length] == 0) {
            string = [item nameEng];
        } else {
            NSString *new = [[NSString alloc] initWithFormat:@"%@ | %@", [item nameEng], [item nameJap]];
            string=new;
        }
        
        [[cevc nameLabel] setText:string];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Save Info" style: UIBarButtonItemStyleBordered target: nil action: nil];
        [self.navigationItem setBackBarButtonItem: backButton];
        
        [[cevc navigationItem] setTitle:@"Edit"];        
        
        [[self navigationController] pushViewController:cevc animated:YES];
    }
}


@end
