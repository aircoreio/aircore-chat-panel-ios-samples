//
//  ViewController.m
//  ChatPanel-UIKit-ObjC
//
//  Created by Rodrigo Sieiro on 2022-10-10.
//

@import AircoreChatPanel;
#import "ViewController.h"

NSString *const kChannelID = @"sample-app";
NSString *const kPanelTitle = @"Objective-C Panel";

@interface ViewController ()

@property (nonatomic) AIRChatClient *client;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"AircoreChatPanel version %@", AIRChatClient.frameworkVersion];
    [self.view addSubview:label];

    NSString *userID = [NSUUID UUID].UUIDString;
    NSString *userName = [NSString stringWithFormat:@"User %@", [userID substringToIndex:5]];
    NSString *avatarUrl = [NSString stringWithFormat:@"https://i.pravatar.cc/300?u=%@", userID];

    // For information and best practices on creating and using a Publishable API Key, please refer to docs (https://docs.aircore.io/key-concepts#apps-and-api-keys).
    NSString *publishableKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"PublishableAPIKey"];

    // Option 1 : Use a Publishable API Key directly from the developer console
    self.client = [AIRChatClient createWithPublishableKey:publishableKey userID:userID];

    // Option 2 :Use a session auth token provided by your server by communication with the Aircores provisioning service using the Secret API key
    // self.client = [AIRClient createWithAuthToken:authToken userID:userID];

    // Choose a name and profile picture that will be used to show the user on the ChatPanel
    self.client.userDisplayName = userName;
    self.client.userAvatarURL = [NSURL URLWithString:avatarUrl];

    // Register event handlers for various events that are of interest for your host app
    [self.client on:AIRChatClientEventSessionAuthTokenInvalid handler:^(NSString * _Nonnull channelID, NSString * _Nonnull userID) {
        // Request a new token from the server
    }];

    // Register error handlers
    [self.client onErrorWithHandler:^(NSString * _Nullable channelID, NSError * _Nonnull error) {
        // Handle any errors
    }];

    // Last step after setting up client is to connect to your channel
    [self.client connectToChannelID:kChannelID];

    // Create a configuration object to configure various aspects of the ChatPanel. Refer docs
    AIRChatPanelConfiguration *configuration = [AIRChatPanelConfiguration defaultConfiguration];
    configuration.panelTitle = kPanelTitle;

    AIRChatPanel *panel = [[AIRChatPanel alloc] initWithClient:self.client
                                                       channelID:kChannelID
                                                   configuration:configuration // Try using [self customConfiguration] instead
                                                           theme: [AIRChatTheme light]];  // Try using [self customTheme] instead

    [panel presentIn:self style:AIRChatPanelStyleBottomBar];
}

// Create your own custom configuration and override the defaults provided by the SDK
- (AIRChatPanelConfiguration *)customConfiguration {
    AIRChatPanelStrings *strings = [[AIRChatPanelStrings alloc] initWithJoinButton:@"Enter"
                                                                     joiningButton:@"Loading..."
                                                                 joinButtonTooltip:@"Tap to enter the conversation"
                                                                       leaveButton:@"Exit"
                                                                       retryButton:@"Retry"
                                                                    emptyChatTitle:@"No one is here"
                                                           emptyChatJoinedSubtitle:@"No one is here"
                                                        emptyChatNotJoinedSubtitle:@"No one is here"
                                                                 genericErrorLabel:@"Unknown Error"
                                                               composerPlaceholder:@"Write here"
    ];

    AIRChatPanelCollapsedStateOptions *collapsedOptions = [[AIRChatPanelCollapsedStateOptions alloc]
                                                           initWithPanelTitle:@"Collapsed Title"
                                                           panelSubtitle:@"Collapsed Subtitle"
                                                           joinButton:@"Enter"
                                                           joiningButton:@"Entering..."
                                                           leaveButton:@"Leave"];

    AIRChatPanelExpandedStateOptions *expandedOptions = [[AIRChatPanelExpandedStateOptions alloc] initWithPanelTitle:@"Expanded Title" panelSubtitle:@"Expanded Subtitle" joinButton:@"Join" joiningButton:@"Joining..." leaveButton:@"Leave" reversed:NO incomingMessage: [[AIRChatPanelMessageOptions alloc] initWithLeftAligned:NO showAvatar:YES showUserName:YES] outgoingMessage: [[AIRChatPanelMessageOptions alloc] initWithLeftAligned:YES showAvatar:YES showUserName:YES]];

    return [[AIRChatPanelConfiguration alloc] initWithPanelTitle:@"Panel Title" panelSubtitle:@"Subtitle Title" previewBeforeJoin:NO showActiveUsers:YES canSendMessage:YES maxCharactersLimit:100 enableAutoScroll:YES autoScrollOffset:1 strings:strings collapsedStateOptions:collapsedOptions expandedStateOptions:expandedOptions];
}

//Create your own custom theme and override the defaults provided by the SDK
- (AIRChatTheme *)customTheme {
    return [[AIRChatTheme alloc] initWithBackgroundColor:[UIColor yellowColor] primaryColor:[UIColor blueColor] dangerColor:[UIColor redColor] borderRadius:24.0 borderWidth:2.0 borderColor:[UIColor greenColor] fontFamily:[UIFont fontWithName:@"Courier" size:20] textColor:[UIColor redColor] subtextColor:[UIColor greenColor] primaryContrastColor:[UIColor darkGrayColor] dangerContrastColor:[UIColor purpleColor] avatar:[[AIRAvatar alloc] initWithBackground:[UIColor cyanColor] borderShape:[AIRChatBorderShape rounded:10] spacing:10] icons:[[AIRChatIcons alloc] initWithCollapseIcon:[UIImage new] infoIcon:[UIImage new] leaveChatIcon:[UIImage new]] incomingBubble:[[AIRChatBubbleTheme alloc] initWithBackgroundColor:[UIColor grayColor] backgroundContrastColor:[UIColor whiteColor] borderColor:[UIColor greenColor] userNameColor:[UIColor redColor]] outgoingBubble:[[AIRChatBubbleTheme alloc] initWithBackgroundColor:[UIColor purpleColor] backgroundContrastColor:[UIColor whiteColor] borderColor:[UIColor greenColor] userNameColor:[UIColor redColor]]];
}

@end
