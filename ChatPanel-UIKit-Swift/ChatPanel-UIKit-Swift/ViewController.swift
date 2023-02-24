//
//  ViewController.swift
//  ChatPanel-UIKit-Swift
//
//  Created by Rodrigo Sieiro on 2022-10-21.
//

import UIKit
import AircoreChatPanel

class ViewController: UIViewController {
    var client: Client?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        let label = UILabel(frame: view.bounds)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .white
        label.text = "AircoreChatPanel version \(Client.frameworkVersion)"
        view.addSubview(label)

        //For information and best practices on creating and using a Publishable API Key, please refer to docs (https://docs.aircore.io/key-concepts#apps-and-api-keys).
        guard let publishableKey = Bundle.main.object(forInfoDictionaryKey: "PublishableAPIKey") as? String
            else { fatalError("publishableKey not found") }
        //An unique id that represents you user
        let userID = UUID.init().uuidString
        //A name that represents you user that is visible on the ChatPanel
        let userName = "User " + userID.prefix(5)
        //A profile picture that represents you user that is visible on the ChatPanel
        let userAvatarURL = URL(string: "https://i.pravatar.cc/300?u=" + userID)
        //An unique id that represents your channel for the other users to join
        let channelID = "sample-app"
        let panelTitle = "Swift Panel"

        // Option 1 : Use a Publishable API Key directly from the developer console
        let client = Client.create(publishableKey: publishableKey, userID: userID)

        // Option 2 :Use a session auth token provided by your server by communication with the Aircores provisioning service using the Secret API key
        // let client = Client.create(authToken: authToken, userID: userID)

        // Choose a name and profile picture that will be used to show the user on the ChatPanel
        client.userDisplayName = userName
        client.userAvatarURL = userAvatarURL

        // Register event handlers for various events that are of interest for your host app
        client.on(.sessionAuthTokenInvalid) { channelID, userID in
            // Request a new token from the server
        }

        // Register error handlers
        client.onError { channelID, error in
            // Handle any errors
        }

        // Last step after setting up client is to connect to your channel
        client.connect(channelID: channelID)

        self.client = client

        // Create a configuration object to configure various aspects of the ChatPanel. Refer docs
        let configuration = ChatPanelConfiguration.defaultConfiguration()
        configuration.panelTitle = panelTitle

        let panel = ChatPanel(
            client: client,
            channelID: channelID,
            configuration: configuration, // Try using customConfiguration() instead
            theme: Theme.light()
        )

        panel.present(in: self, style: .bottomBar)
    }

    // Create your own custom configuration and override the defaults provided by the SDK
    func customConfiguration() -> ChatPanelConfiguration {
        let strings = ChatPanelConfiguration.Strings(
            joinButton: "Enter",
            joiningButton: "Loading...",
            joinButtonTooltip: "Tap to enter the conversation",
            leaveButton: "Exit",
            retryButton: "Retry",
            emptyChatTitle: "No one is here",
            emptyChatJoinedSubtitle: "Write below to be the first",
            emptyChatNotJoinedSubtitle: "Tap below to be the first",
            genericErrorLabel: "Unknown Error",
            composerPlaceholder: "Write here"
        )

        let collapsedOptions = ChatPanelConfiguration.CollapsedStateOptions(
            panelTitle: "Collapsed Title",
            panelSubtitle: "Collapsed Subtitle"
        )

        let expandedOptions = ChatPanelConfiguration.ExpandedStateOptions(
            panelTitle: "Expanded Title",
            panelSubtitle: "Expanded Subtitle",
            incomingMessage: .init(
                leftAligned: false,
                showAvatar: true,
                showUserName: true
            ),
            outgoingMessage: .init(
                leftAligned: true,
                showAvatar: true,
                showUserName: true
            )
        )
        
        return ChatPanelConfiguration(
            panelTitle: "My Panel Title",
            panelSubtitle: "My Panel Subtitle",
            maxCharactersLimit: 100,
            strings: strings,
            collapsedStateOptions: collapsedOptions,
            expandedStateOptions: expandedOptions
        )
    }

    // Create your own custom theme and override the defaults provided by the SDK
    func customTheme() -> Theme {
        Theme(
            backgroundColor: .yellow,
            primaryColor: .blue,
            dangerColor: .red,
            borderRadius: 24,
            borderWidth: 2,
            borderColor: .green,
            fontFamily: UIFont(name: "Courier", size: 20),
            textColor: .red,
            subtextColor: .green,
            primaryContrastColor: .darkGray,
            dangerContrastColor: .purple,
            avatar: .init(background: .cyan, borderShape: .rounded(10), spacing: 10),
            icons: .init()
        )
    }


}

