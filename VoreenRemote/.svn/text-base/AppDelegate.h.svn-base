//
//  AppDelegate.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCPHelper.h"

enum CommandPrefix {
    CommandPrefixUndefined = -1,
    CommandPrefixPython = 0,
    CommandPrefixRequestWorkspaceList = 1,
    CommandPrefixLoadWorkspaceFile = 2,
    CommandPrefixRequestCurrentWorkspace = 3
};

@interface AppDelegate : UIResponder <UIApplicationDelegate, TCPHelperDelegate> {
    NSUInteger _currentMessageLength;
    NSInteger _currentMessageIdentifer;
    
    TCPHelper* _tcpHelper;
    NSMutableData* _data;
    
    void (^_followUpRequest)(void);
}

- (void)processWorkspaceList:(NSString*)list;
- (void)processWorkspaceSource:(NSString*)source;
- (void)selectedNewWorkspace:(NSNotification*)notification;
- (void)propertyValueChanged:(NSNotification*)notification;

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) NSArray* processors;

@end
