#import "JJMainWindow.h"

@implementation JJMainWindow

+(void)openMacAppStore:(nullable id)sender {
	NSURL* url = [NSURL URLWithString:@"macappstore://itunes.apple.com/app/stopthemadness/id1376402589"];
	if (url != nil)
		[[NSWorkspace sharedWorkspace] openURL:url];
	else
		NSLog(@"MAS URL nil!");
	[[sender window] close];
}

+(nonnull NSWindow*)window {
	NSWindowStyleMask style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable;
	NSWindow* window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0.0, 0.0, 480.0, 300.0) styleMask:style backing:NSBackingStoreBuffered defer:YES];
	[window setExcludedFromWindowsMenu:YES];
	[window setReleasedWhenClosed:NO]; // Necessary under ARC to avoid a crash.
	[window setTabbingMode:NSWindowTabbingModeDisallowed];
	[window setTitle:JJApplicationName];
	NSView* contentView = [window contentView];
	
	NSString* intro = [NSString stringWithFormat:@"%@ stops \"Open in the Twitter app\" from appearing at the top of twitter.com web pages in Safari.\n\nYou don't need to keep %@ open. Just keep the app in the Applications folder.\n\nWhen the official Twitter app is not open, %@ receives push notifications from Twitter, but %@ can't handle notification actions. If you do anything other than close the notification, then %@ opens the official Twitter app.\n\n%@ is free and open source. To support the developer, please consider buying the Safari extension StopTheMadness in the Mac App Store. Thanks!", JJApplicationName, JJApplicationName, JJApplicationName, JJApplicationName, JJApplicationName, JJApplicationName];
	NSTextField* label = [NSTextField wrappingLabelWithString:intro];
	[label setTranslatesAutoresizingMaskIntoConstraints:NO];
	[contentView addSubview:label];
	
	NSButton* buyButton = [[NSButton alloc] init];
	[buyButton setAction:@selector(openMacAppStore:)];
	[buyButton setButtonType:NSButtonTypeMomentaryLight];
	[buyButton setBezelStyle:NSBezelStyleRounded];
	[buyButton setTarget:self];
	[buyButton setTitle:NSLocalizedString(@"Mac App Store", nil)];
	[buyButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[contentView addSubview:buyButton];
	[window setDefaultButtonCell:[buyButton cell]];
	[window setInitialFirstResponder:buyButton];
	
	[NSLayoutConstraint activateConstraints:@[
											  [[label topAnchor] constraintEqualToAnchor:[contentView topAnchor] constant:15.0],
											  [[label leadingAnchor] constraintEqualToAnchor:[contentView leadingAnchor] constant:15.0],
											  [[label trailingAnchor] constraintEqualToAnchor:[contentView trailingAnchor] constant:-15.0],
											  [[label widthAnchor] constraintEqualToConstant:450.0],
											  [[buyButton topAnchor] constraintEqualToAnchor:[label bottomAnchor] constant:15.0],
											  [[buyButton bottomAnchor] constraintEqualToAnchor:[contentView bottomAnchor] constant:-15.0],
											  [[buyButton trailingAnchor] constraintEqualToAnchor:[contentView trailingAnchor] constant:-15.0]
										  ]];
	
	[window makeKeyAndOrderFront:nil];
	[window center]; // Wait until after makeKeyAndOrderFront so the window sizes properly first
	
	return window;
}

@end
