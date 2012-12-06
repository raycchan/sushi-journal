//
//  CollectionEditViewController.h
//  SushiJournal
//
//  Created by Raymond on 27/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SushiCollection;

@interface CollectionEditViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)takePicture:(id)sender;
- (IBAction)chooseFromGallery:(id)sender;

- (IBAction)backgroundTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) SushiCollection *collectionItem;

@property (weak, nonatomic) IBOutlet UILabel *dateTakenLabel;

@end
