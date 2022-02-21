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

public extension Reactive where Base: TCHConversation {
    
    var delegate: TCHConversationDelegateProxy {
        return TCHConversationDelegateProxy.proxy(for: base)
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:updated:)`.
    var conversationUpdated: Observable<TCHConversationUpdate> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:updated:)))
            .map {( TCHConversationUpdate(rawValue: try castOrThrow(Int.self, $0[2]))! )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:channelDeleted:)`.
    var conversationDeleted: Observable<Void> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversationDeleted:)))
            .map { _ in }
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:synchronizationStatusUpdated:)`.
    var synchronizationStatusUpdated: Observable<TCHConversationSynchronizationStatus> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:synchronizationStatusUpdated:)))
            .map {( TCHConversationSynchronizationStatus(rawValue: try castOrThrow(Int.self, $0[2]))! )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participantJoined:)`.
    var participantJoined: Observable<TCHParticipant> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:participantJoined:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participant:updated:)`.
    var participantUpdated: Observable<(TCHParticipant, TCHParticipantUpdate)> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:participant:updated:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]),
                    TCHParticipantUpdate(rawValue: try castOrThrow(Int.self, $0[3]))! )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participantLeft:)`.
    var participantLeft: Observable<TCHParticipant> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:participantLeft:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:messageAdded:)`.
    var messageAdded: Observable<TCHMessage> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:messageAdded:)))
            .map {( try castOrThrow(TCHMessage.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:message:updated:)`.
    var messageUpdated: Observable<(TCHMessage, TCHMessageUpdate)> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:message:updated:)))
            .map {( try castOrThrow(TCHMessage.self, $0[2]),
                    TCHMessageUpdate(rawValue: try castOrThrow(Int.self, $0[3]))! )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:messageDeleted:)`.
    var messageDeleted: Observable<TCHMessage> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:messageDeleted:)))
            .map {( try castOrThrow(TCHMessage.self, $0[2]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:typingStartedOn:participant:)`.
    var typingStartedOn: Observable<TCHParticipant> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:typingStartedOn:participant:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:typingEndedOn:participant:)`.
    var typingEndedOn: Observable<TCHParticipant> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:typingEndedOn:participant:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]) )}
    }
    
    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participant:user:updated:)`.
    var userUpdated: Observable<(TCHParticipant, TCHUser, TCHUserUpdate)> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:participant:user:updated:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]),
                    try castOrThrow(TCHUser.self, $0[3]),
                    try castOrThrow(TCHUserUpdate.self, $0[4]))}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participant:userSubscribed:)`.
    var userSubscribed: Observable<(TCHParticipant, TCHUser)> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:participant:userSubscribed:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]),
                    try castOrThrow(TCHUser.self, $0[3]) )}
    }

    /// Reactive wrapper for `delegate` message `conversationsClient(_:conversation:participant:userUnsubscribed:)`.
    var userUnsubscribed: Observable<(TCHParticipant, TCHUser)> {
        return delegate
            .methodInvoked(#selector(TCHConversationDelegate.conversationsClient(_:conversation:participant:userUnsubscribed:)))
            .map {( try castOrThrow(TCHParticipant.self, $0[2]),
                    try castOrThrow(TCHUser.self, $0[3]) )}
    }
}
