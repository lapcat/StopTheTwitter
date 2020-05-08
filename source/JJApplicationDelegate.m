#import "JJApplicationDelegate.h"

#import "JJLicenseWindow.h"
#import "JJMainMenu.h"
#import "JJMainWindow.h"

NSString* JJApplicationName;

@implementation JJApplicationDelegate {
	NSWindow* _licenseWindow;
	NSWindow* _mainWindow;
}

-(void)quitIfNoWindowsOpen {
	NSArray<NSWindow*>* windows = [NSApp windows];
	for (NSWindow* window in windows) {
		if ([window isVisible])
			return; // Don't terminate if there are visible windows
	}
	[NSApp terminate:nil];
}

#pragma mark <UNUserNotificationCenterDelegate>

-(void)userNotificationCenter:(nonnull UNUserNotificationCenter*)notificationCenter didReceiveNotificationResponse:(nonnull UNNotificationResponse*)response withCompletionHandler:(nonnull void(^)(void))completionHandler {
	NSString* actionIdentifier = [response actionIdentifier];
	if (![actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier]) {
		// Launch the real Twitter.
		NSString* path = @"/Applications/Twitter.app";
		NSBundle* bundle = [NSBundle bundleWithPath:@"/Applications/Twitter.app"];
		if (bundle != nil) {
			NSString* bundleIdentifier = [bundle bundleIdentifier];
			if (bundleIdentifier != nil && [bundleIdentifier isEqualToString:@"maccatalyst.com.atebits.Tweetie2"]) {
				[[NSWorkspace sharedWorkspace] launchApplication:path];
			}
		}
	}
	completionHandler();
	[self quitIfNoWindowsOpen];
}

#pragma mark <NSApplicationDelegate>

-(void)applicationWillFinishLaunching:(nonnull NSNotification *)notification {
	JJApplicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
	if (JJApplicationName == nil) {
		NSLog(@"CFBundleName nil!");
		JJApplicationName = @"StopTheTwitter";
	}
	[JJMainMenu populateMainMenu];
	
	[[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
}

-(void)applicationWillTerminate:(nonnull NSNotification*)notification {
	[[UNUserNotificationCenter currentNotificationCenter] setDelegate:nil];
}

-(void)applicationDidResignActive:(nonnull NSNotification*)notification {
	[self quitIfNoWindowsOpen];
}

#pragma mark JJApplicationDelegate

-(void)windowWillClose:(nonnull NSNotification*)notification {
	id object = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:[notification name] object:object];
	if (object == _licenseWindow)
		_licenseWindow = nil;
	else if (object == _mainWindow)
		_mainWindow = nil;
}

-(void)openLicense:(nullable id)sender {
	if (_licenseWindow != nil) {
		[_licenseWindow makeKeyAndOrderFront:self];
	} else {
		_licenseWindow = [JJLicenseWindow window];
		if (_licenseWindow != nil)
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:_licenseWindow];
	}
}

-(void)openMainWindow:(nullable id)sender {
	if (_mainWindow != nil) {
		[_mainWindow makeKeyAndOrderFront:self];
	} else {
		_mainWindow = [JJMainWindow window];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:_mainWindow];
	}
}

-(void)openWebSite:(nullable id)sender {
	NSURL* url = [NSURL URLWithString:@"https://github.com/lapcat/StopTheTwitter"];
	if (url != nil)
		[[NSWorkspace sharedWorkspace] openURL:url];
	else
		NSLog(@"Support URL nil!");
}

@end
