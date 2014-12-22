//
//  MasterViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController {
    NSArray* _workspaceList;
    NSArray* _processorList;
    __weak UIPopoverController* _workspaceListPopoverController;
}

- (void)receivedProcessorList:(NSNotification*)notification;
- (void)receivedWorkspaceList:(NSNotification*)notification;
- (void)dismissWorkspacePopover:(NSNotification*)notification;

- (IBAction)showWorkspaceList:(id)sender;

@property (nonatomic, retain) NSArray* workspaceList;
@property (nonatomic, retain) NSArray* processorList;
@property (nonatomic) BOOL hasServer;

@end
