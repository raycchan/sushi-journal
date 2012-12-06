//
//  CollectionEditViewController.m
//  SushiJournal
//
//  Created by Raymond on 27/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CollectionEditViewController.h"
#import "SushiCollection.h"
#import <QuartzCore/QuartzCore.h>
#import "SushiStore.h"
#import "SushiImageStore.h"

@interface CollectionEditViewController ()

@end

@implementation CollectionEditViewController
@synthesize dateTakenLabel;
@synthesize collectionImage;
@synthesize dateLabel;
@synthesize restaurantLabel;
@synthesize nameLabel, collectionItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void) viewWillAppear:(BOOL)animated
{
    if([collectionItem isDefault])
        [dateTakenLabel setHidden:YES];
    
    [dateLabel setText:[collectionItem dateTaken]];
    [restaurantLabel setText:[collectionItem restaurantTaken]];
    
    NSString *imageKey = [collectionItem imageKey];
    
    if(imageKey) {
        UIImage *imagetoDisplay = [[SushiImageStore sharedStore] imageForKey:imageKey];
        
        CALayer *imageLayer = [CALayer layer];
        imageLayer.frame = CGRectMake(0, 0, imagetoDisplay.size.width, imagetoDisplay.size.height);
        imageLayer.contents = (id) imagetoDisplay.CGImage;
        
        imageLayer.masksToBounds = YES;
        imageLayer.cornerRadius = 15;
        imageLayer.borderWidth =2.0;
        imageLayer.borderColor = [[UIColor blackColor] CGColor];
        
        UIGraphicsBeginImageContext(imagetoDisplay.size);
        [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [collectionImage setImage:roundedImage];
        
    } else {
        [collectionImage setImage:nil];
    }
    

    
    [restaurantLabel setDelegate:self];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
        
    [collectionItem setRestaurantTaken:[restaurantLabel text]];
    
    BOOL success = [[SushiStore sharedStore]saveChanges]; 
    
    if (success) {
        NSLog(@"Saved all Sushi Items"); } 
    else {
        NSLog(@"Could not save any Sushi Items"); }
    
}

- (void)viewDidUnload
{
    [self setCollectionImage:nil];
    [self setDateLabel:nil];
    [self setRestaurantLabel:nil];
    [self setNameLabel:nil];
    [self setDateTakenLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:YES];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [collectionItem imageSet:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseFromGallery:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [imagePicker setDelegate:self];    
    
        [imagePicker setAllowsEditing:YES];
    
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    [textField resignFirstResponder];
    return YES; 
}





@end
