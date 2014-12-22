//
//  ServerSelectorViewController.m
//  Doreemote
//
//  Created by Alexander Bock on 10/5/12.
//
//

#import "ServerSelectorViewController.h"
#import "common.h"

@interface ServerSelectorViewController ()

@property (retain, nonatomic) IBOutlet UITextField* ipAddress;

- (IBAction)alphaSelected;
- (IBAction)betaSelected;
- (IBAction)thetaSelected;
- (IBAction)otherSelected;

@end

@implementation ServerSelectorViewController

- (IBAction)alphaSelected {
    NSString* selectedIPAddress = @"172.19.1.10";
    [[NSNotificationCenter defaultCenter] postNotificationName:ServerSelectedNotification object:selectedIPAddress];
}

- (IBAction)betaSelected {
    NSString* selectedIPAddress = @"172.19.2.10";
    [[NSNotificationCenter defaultCenter] postNotificationName:ServerSelectedNotification object:selectedIPAddress];
}

- (IBAction)thetaSelected {
    NSString* selectedIPAddress = @"172.19.8.10";
    [[NSNotificationCenter defaultCenter] postNotificationName:ServerSelectedNotification object:selectedIPAddress];
}

- (IBAction)otherSelected {
    NSString* selectedIPAddress = self.ipAddress.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:ServerSelectedNotification object:selectedIPAddress];
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
}

@end
