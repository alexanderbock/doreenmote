//
//  AppDelegate.m
//  Doreemote
//
//  Created by Alexander.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "NSLogAddition.h"
#import "common.h"
#import "Property.h"
#import "WorkspaceFileParser.h"
#import "ServerSelectorViewController.h"

#define ContainedDataTypeHeaderLength 1
#define ContainedDataLengthHeaderLength 7
#undef DLog
#define DLog(...)


enum CommandPrefix stringToPrefix(NSString* str) {
    if ([str isEqualToString:@"1"])
        return CommandPrefixRequestWorkspaceList;
    else if ([str isEqualToString:@"3"])
        return CommandPrefixRequestCurrentWorkspace;
    else {
        ALog(@"Unknown prefix string: %@", str);
        return -1;
    }
}

@implementation AppDelegate

@synthesize window = _window;
@synthesize processors = _processors;

- (void)dealloc {
    [_window release];
    [_processors release];
    [_tcpHelper release];
    [_data release];    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedNewWorkspace:) name:SelectedNewWorkspaceNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(propertyValueChanged:) name:PropertyValueChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedServer:) name:ServerSelectedNotification object:nil];
        
    return YES;
}

#pragma mark -
#pragma mark Network

- (void)tcpHelperStartedRunning:(TCPHelper *)helper {
    DLog(@"Started listening to %@ on port %@", helper.host, helper.port);
}

- (void)tcpHelperConnected:(TCPHelper *)helper {
    DLog(@"Connected to %@ on port %@", helper.host, helper.port);
    [[NSNotificationCenter defaultCenter] postNotificationName:ServerConnectionEstablishedNotification object:nil];
    [helper receiveData];
    
    DLog(@"Sending request for workspace list");
    NSString* requestWorkspaceListString = [NSString stringWithFormat:@"%i\r\n", CommandPrefixRequestWorkspaceList];
    NSData* requestWorkspaceListData = [requestWorkspaceListString dataUsingEncoding:NSASCIIStringEncoding];
    [helper sendData:requestWorkspaceListData];
    
    _followUpRequest = [^{
        DLog(@"Sending request for workspace source");
        NSString* requestWorkspaceString = [NSString stringWithFormat:@"%i\r\n", CommandPrefixRequestCurrentWorkspace];
        NSData* requestWorkspaceData = [requestWorkspaceString dataUsingEncoding:NSASCIIStringEncoding];
        [helper sendData:requestWorkspaceData];                
    } copy];
}

- (void)tcpHelperDisconnected:(TCPHelper *)helper {
    DLog(@"Disconnected");    
}

- (void)tcpHelper:(TCPHelper *)helper receivedData:(NSData *)data {
    NSString* stringData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    if ([stringData hasPrefix:@"OK\r\n"]) {
        [stringData release];
        return;
    }
    if ([stringData isEqualToString:@"Connected to SGCT!\r\n"]) {
        DLog(@"Discarding 'Connected..' message");
        [stringData release];
        return;
    }
    
    if ([stringData isEqualToString:@"Terminate!\r\n"]) {
        DLog(@"Received 'Terminate' string");
        [stringData release];
        [_tcpHelper disconnect];
        return;
    }
    
    [stringData release];
    
    
    if (_data == nil) {
        if (_currentMessageIdentifer != CommandPrefixUndefined) {
            NSString* stringData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            ALog(@"Data array was nil, but there was a current message identifier (%i).\nData: %@", _currentMessageIdentifer, stringData);
            [stringData release];
        }
        DLog("Received initial package");
        if ([data length] < (ContainedDataTypeHeaderLength + ContainedDataLengthHeaderLength)) {
            NSString* stringData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            ALog(@"Initial package too small. Expected: %i ; Actual: %i ; Data: %@", ContainedDataTypeHeaderLength + ContainedDataLengthHeaderLength, [data length], stringData);
            [stringData release];
            return;
        }
        NSData* typeHeaderData = [data subdataWithRange:NSMakeRange(0, ContainedDataTypeHeaderLength)];
        NSString* typeHeader = [[NSString alloc] initWithData:typeHeaderData encoding:NSASCIIStringEncoding];
        _currentMessageIdentifer = stringToPrefix(typeHeader);

        NSData* sizeHeaderData = [data subdataWithRange:NSMakeRange(ContainedDataTypeHeaderLength, ContainedDataLengthHeaderLength)];
        NSString* sizeHeaderString = [[NSString alloc] initWithData:sizeHeaderData encoding:NSASCIIStringEncoding];
        _currentMessageLength = [sizeHeaderString integerValue];
        
        DLog(@"Message Type: %@ ; Size: %i", typeHeader, _currentMessageLength);
        _data = [[NSMutableData alloc] initWithCapacity:_currentMessageLength];
        
        data = [data subdataWithRange:NSMakeRange(ContainedDataTypeHeaderLength + ContainedDataLengthHeaderLength, [data length] - (ContainedDataTypeHeaderLength + ContainedDataLengthHeaderLength))];
    }
    
    DLog(@"Appending data: (%i + %i) of (%i)", [_data length], [data length], _currentMessageLength);
    [_data appendData:data];
    
    if ([_data length] == (_currentMessageLength + 4)) {
        NSRange okRange = NSMakeRange([_data length] - 4, 4);
        NSString* okString = [[NSString alloc] initWithData:[_data subdataWithRange:okRange] encoding:NSASCIIStringEncoding];
        if ([okString isEqualToString:@"OK\r\n"]) {
            // SGCT sends 'OK\r\n' at the end of the message
            DLog(@"Removing SGCT 'OK' signal. Reducing message length by 4.");
            [_data setLength: [_data length] - 4];
        }
    }
    
    if ([_data length] == _currentMessageLength) {
        DLog(@"Received all data: (%i) of (%i)", [_data length], _currentMessageLength); 
        [self tcpHelperFinishedReceivingData:helper];
    }
    
    if ([_data length] > _currentMessageLength) {
        NSString* stringData = [[NSString alloc] initWithData:_data encoding:NSASCIIStringEncoding];
        ALog(@"Too much data. Expected: %i ; Actual: %i\n Data: %@", _currentMessageLength, [_data length], stringData);
        [stringData release];
    }
}

- (void)tcpHelper:(TCPHelper *)helper sentData:(NSData *)data {
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    DLog(@"Sending data of size: %i\nData: %@", [data length], dataString);
    [dataString release];    
}

- (void)tcpHelperFinishedSendingData:(TCPHelper *)helper {
    DLog(@"Finished sending data");
}

- (void)tcpHelperFinishedReceivingData:(TCPHelper *)helper {
    DLog(@"Finished receiving data of header type %i", _currentMessageIdentifer);
    
    NSString* resultString = [[[NSString alloc] initWithData:_data encoding:NSASCIIStringEncoding] autorelease];
    switch (_currentMessageIdentifer) {
        case CommandPrefixRequestWorkspaceList:
            [self processWorkspaceList:resultString];
            break;
        case CommandPrefixRequestCurrentWorkspace:
            [self processWorkspaceSource:resultString];
            break;
    }

    _currentMessageIdentifer = CommandPrefixUndefined;
    
    [_data release];
    _data = nil;

    if (_followUpRequest) {
        _followUpRequest();
        [_followUpRequest release];
        _followUpRequest = nil;
    }
}

- (void)tcpHelper:(TCPHelper *)helper errorOccurred:(NSError *)error {
    if (![_tcpHelper isConnected])
        return;
    else
        ALog(@"%@", error.description);
}

- (void)selectedServer:(NSNotification*)notification {
    _currentMessageLength = 0;
    _currentMessageIdentifer = CommandPrefixUndefined;
    
    //    self.serverHost = @"192.168.0.105";
//    self.serverHost = @"130.236.243.116";
    
    NSString* serverHost = notification.object;
    NSString* serverPort = @"20500";
    
    [_tcpHelper disconnect];
    [_tcpHelper release];
    
    _tcpHelper = [[TCPHelper alloc] initWithHost:serverHost port:serverPort];
    _tcpHelper.chunkSize = 2048 * 1024;
    _tcpHelper.ignoreIoInProgress = YES;
    _tcpHelper.delegate = self;
    [_tcpHelper connectToServer];    
}

- (void)selectedNewWorkspace:(NSNotification*)notification {
    NSString* workspace = notification.object;
    DLog(@"Sending request to load new workspace '%@'", workspace);
    
    NSString* loadWorkspaceString = [NSString stringWithFormat:@"%i%@\r\n", CommandPrefixLoadWorkspaceFile, workspace];
    NSData* loadWorkspaceData = [loadWorkspaceString dataUsingEncoding:NSASCIIStringEncoding];
    [_tcpHelper sendData:loadWorkspaceData];
}

- (void)propertyValueChanged:(NSNotification*)notification {
    Property* property = (Property*)notification.object;
    
    NSString* pythonString = [property pythonString];
    DLog(@"Sending property change string: %@", pythonString);
    NSData* pythonData = [[NSString stringWithFormat:@"%i%@", CommandPrefixPython, pythonString] dataUsingEncoding:NSASCIIStringEncoding];
    [_tcpHelper sendData:pythonData];
}

#pragma mark -
#pragma mark Processing

- (void)processWorkspaceList:(NSString*)list {
    DLog(@"Processing workspace list");
    NSArray* workspaces = [list componentsSeparatedByString:@"\r\n"];
    DLog(@"Separated list contains %i elements", [workspaces count]);    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewWorkspaceListNotification object:workspaces];
}

- (void)processWorkspaceSource:(NSString*)source {
    DLog(@"Processing workspace source");
    
    ALog(@"%@", source);
    
    WorkspaceFileParser* parser = [[WorkspaceFileParser alloc] init];
    NSError* error = nil;
    NSArray* processors = [parser parseWorkspaceFile:source error:&error];
    [[NSNotificationCenter defaultCenter] postNotificationName:NewProcessorListNotification object:processors];
}


#pragma mark -
#pragma mark Application
							
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [_tcpHelper disconnect];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
