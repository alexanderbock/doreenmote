//
//  MasterViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "WorkspaceTableViewController.h"
#import "NSLogAddition.h"
#import "common.h"
#import "Processor.h"
#import "Property.h"
#import "FloatPropertyViewController.h"

@implementation MasterViewController

@synthesize workspaceList = _workspaceList;
@synthesize processorList = _processorList;

- (void)awakeFromNib {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)dealloc {
    [_workspaceList release];
    [_processorList release];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!self.hasServer)
        [self.splitViewController performSegueWithIdentifier:@"showServer" sender:nil];
    else
        [self.tableView reloadData];
}

- (void)serverConnectionEstablished:(NSNotification*)notification {
    self.hasServer = YES;
    [self.splitViewController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasServer = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedWorkspaceList:) name:NewWorkspaceListNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissWorkspacePopover:) name:SelectedNewWorkspaceNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedProcessorList:) name:NewProcessorListNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverConnectionEstablished:) name:ServerConnectionEstablishedNotification object:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
//    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.processorList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Processor* processor = [self.processorList objectAtIndex:section];
    return [processor.properties count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.processorList objectAtIndex:section] name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessorCell"];
    
    Processor* processor = [self.processorList objectAtIndex:indexPath.section];
    Property* property = [processor.properties objectAtIndex:indexPath.row];
    cell.textLabel.text = property.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Processor* processor = [self.processorList objectAtIndex:indexPath.section];
    Property* property = [processor.properties objectAtIndex:indexPath.row];
    NSLog(@"%@", property);
    NSString* type = property.type;
    NSString* vcType = [NSString stringWithFormat:@"%@ViewController", type];
    Class vcClass = NSClassFromString(vcType);
    UIViewController* vc = [[[vcClass alloc] initWithProperty:property] autorelease];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIViewController* main = [self.splitViewController.viewControllers objectAtIndex:0];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:main, vc, nil];
    }
    else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowWorkspaceTable"]) {
        WorkspaceTableViewController* wtvc = (WorkspaceTableViewController*)[segue destinationViewController];
        wtvc.workspaceList = self.workspaceList;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            _workspaceListPopoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
    }
}
                                                                              
- (void)receivedProcessorList:(NSNotification*)notification {
    self.processorList = (NSArray*)notification.object;
    DLog(@"Received processor list with %i elements", [self.processorList count]);
    [self.tableView reloadData];
}

- (void)receivedWorkspaceList:(NSNotification*)notification {
    NSArray* list = (NSArray*)notification.object;
    DLog(@"Received workspace list with %i elements", [list count]);
    self.workspaceList = list;
}

- (IBAction)showWorkspaceList:(id)sender {
//    if (_workspaceListPopoverController != nil) {
//        [_workspaceListPopoverController dismissPopoverAnimated:YES];
//        _workspaceListPopoverController = nil;
//        
//    } else
        [self performSegueWithIdentifier:@"ShowWorkspaceTable" sender:sender];
}

- (void)dismissWorkspacePopover:(NSNotification*)notification {
    [_workspaceListPopoverController dismissPopoverAnimated:YES];
}



@end
