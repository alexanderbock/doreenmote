//
//  WorkspaceTableViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "WorkspaceTableViewController.h"
#import "common.h"
#import "NSLogAddition.h"

@implementation WorkspaceTableViewController

@synthesize workspaceList;
@synthesize masterVC;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.workspaceList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellIdentifier = @"WorkspaceTableCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.workspaceList objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* workspace = [self.workspaceList objectAtIndex:indexPath.row];
    DLog(@"Selected workspace '%@'", workspace);
    [[NSNotificationCenter defaultCenter] postNotificationName:SelectedNewWorkspaceNotification object:workspace];
}

@end
