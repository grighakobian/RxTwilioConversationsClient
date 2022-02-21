//    Copyright (c) 2022 Grigor Hakobyan <grighakobian@gmail.com>
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.


import RxSwift
import RxCocoa
import TwilioConversationsClient


// MARK: - Reactive + DelegateProxy

public extension Reactive where Base: TwilioConversationsClient {
    
    var delegate: TwilioConversationsClientDelegateProxy {
        return TwilioConversationsClientDelegateProxy.proxy(for: base)
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:connectionStateUpdated:)`.
    var connectionStateUpdated: Observable<TCHClientConnectionState> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:connectionStateUpdated:)))
            .map {( TCHClientConnectionState(rawValue: try castOrThrow(Int.self, $0[1]))! )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClientTokenExpired(_:)`.
    var tokenExpired: Observable<Void> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClientTokenExpired(_:)))
            .map { _ in }
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClientTokenWillExpire(_:)`.
    var tokenWillExpire: Observable<Void> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClientTokenWillExpire(_:)))
            .map { _ in }
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:synchronizationStatusUpdated:)`.
    var synchronizationStatusUpdated: Observable<TCHClientSynchronizationStatus> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:synchronizationStatusUpdated:)))
            .map { TCHClientSynchronizationStatus(rawValue: try castOrThrow(Int.self, $0[1]))! }
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversationAdded:)`.
    var conversationAdded: Observable<TCHConversation> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversationAdded:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:updated:)`.
    var conversationUpdated: Observable<(TCHConversation, TCHConversationUpdate)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:updated:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    TCHConversationUpdate(rawValue: try castOrThrow(Int.self, $0[2]))! )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:synchronizationStatusUpdated:)`.
    var conversationSynchronizationStatusUpdated: Observable<(TCHConversation, TCHConversationSynchronizationStatus)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:synchronizationStatusUpdated:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    TCHConversationSynchronizationStatus(rawValue: try castOrThrow(Int.self, $0[2]))! )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversationDeleted:)`.
    var conversationDeleted: Observable<TCHConversation> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversationDeleted:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participantJoined:)`.
    var participantJoined: Observable<(TCHConversation, TCHParticipant)> {
        return delegate
                    .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:participantJoined:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHParticipant.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participant:updated:)`.
    var participantUpdated: Observable<(TCHConversation, TCHParticipant, TCHParticipantUpdate)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:participant:updated:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHParticipant.self, $0[2]),
                    TCHParticipantUpdate(rawValue: try castOrThrow(Int.self, $0[3]))! )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participantLeft:)`.
    var participantLeft: Observable<(TCHConversation, TCHParticipant)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:participantLeft:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHParticipant.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:messageAdded:)`.
    var messageAdded: Observable<(TCHConversation, TCHMessage)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:messageAdded:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHMessage.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:message:updated:)`.
    var messageUpdated: Observable<(TCHConversation, TCHMessage, TCHMessageUpdate)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:message:updated:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHMessage.self, $0[2]),
                    TCHMessageUpdate(rawValue: try castOrThrow(Int.self, $0[3]))! )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:messageDeleted:)`.
    var messageDeleted: Observable<(TCHConversation, TCHMessage)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:conversation:messageDeleted:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHMessage.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:errorReceived:)`.
    var errorReceived: Observable<TCHError> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:errorReceived:)))
            .map {( try castOrThrow(TCHError.self, $0[1]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:typingStartedOn:participant:)`.
    var typingStartedOn: Observable<(TCHConversation, TCHParticipant)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:typingStartedOn:participant:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHParticipant.self, $0[2]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:typingEndedOn:participant:)`.
    var typingEndedOn: Observable<(TCHConversation, TCHParticipant)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:typingEndedOn:participant:)))
            .map {( try castOrThrow(TCHConversation.self, $0[1]),
                    try castOrThrow(TCHParticipant.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:notificationNewMessageReceivedForConversationSid:messageIndex:)`.
    var notificationNewMessageReceivedForConversation: Observable<(String, UInt)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:notificationNewMessageReceivedForConversationSid:messageIndex:)))
            .map {( try castOrThrow(String.self, $0[1]),
                    try castOrThrow(UInt.self, $0[2]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:notificationAddedToConversationWithSid:)`.
    var notificationAddedToConversation: Observable<String> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:notificationAddedToConversationWithSid:)))
            .map {( try castOrThrow(String.self, $0[1]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:notificationRemovedFromConversationWithSid:)`.
    var notificationRemovedFromConversation: Observable<String> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:notificationRemovedFromConversationWithSid:)))
            .map {( try castOrThrow(String.self, $0[1]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:notificationUpdatedBadgeCount:)`.
    var notificationUpdatedBadgeCount: Observable<UInt> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:notificationUpdatedBadgeCount:)))
            .map {( try castOrThrow(UInt.self, $0[1]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:user:updated:)`.
    var userUpdated: Observable<(TCHUser, TCHUserUpdate)> {
        return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:user:updated:)))
            .map {( try castOrThrow(TCHUser.self, $0[1]),
                    TCHUserUpdate(rawValue: try castOrThrow(Int.self, $0[2]))! )}
      }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:userSubscribed:)`.
    var userSubscribed: Observable<TCHUser> {
         return delegate
            .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:userSubscribed:)))
             .map {( try castOrThrow(TCHUser.self, $0[1]) )}
     }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:userUnsubscribed:)`.
    var userUnsubscribed: Observable<TCHUser> {
         return delegate
             .methodInvoked(#selector(TwilioConversationsClientDelegate.conversationsClient(_:userUnsubscribed:)))
             .map {( try castOrThrow(TCHUser.self, $0[1]) )}
     }
}

