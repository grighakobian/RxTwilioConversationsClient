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
import TwilioConversationsClient

public enum RxTwilioError: Error {
    case unknown
}

public extension Reactive where Base: TCHConversation {
    
    /// Set this conversation's attributes.
    /// - Parameter attributes: The new developer-defined extensible attributes for this conversation.
    /// (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
    func setAttributes(_ attributes: TCHJsonAttributes?) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.setAttributes(attributes) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Set this conversation's friendly name.
    /// - Parameter friendlyName: The new friendly name for this conversation.
    func setFriendlyName(_ friendlyName: String) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.setFriendlyName(friendlyName) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Set this conversation's unique name.
    /// - Parameter uniqueName: The new unique name for this conversation.
    func setUniqueName(_ uniqueName: String) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.setUniqueName(uniqueName) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Set the user's notification level for the conversation.  This property determines whether the
    /// user will receive push notifications for activity on this conversation.
    /// - Parameter notificationLevel: The new notification level for the current user on this conversation.
    func setNotificationLevel(_ notificationLevel: TCHConversationNotificationLevel) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.setNotificationLevel(notificationLevel) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Join the current user to this conversation.
    func join() -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.join() { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Leave the current conversation.
    func leave() -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.leave() { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Destroy the current conversation, removing all of its participants.
    func destroy() -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.destroy() { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Removes the specified message from the conversation.
    /// - Parameter message: The message to remove.
    func remove(_ message: TCHMessage) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.remove(message) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Fetches the most recent `count` messages.
    /// This will return locally cached messages if they are all available or may require a load from the server.
    /// - Parameter count: The number of most recent messages to return.
    func getLastMessagesWithCount(_ count: UInt) -> Single<[TCHMessage]> {
        return Single<[TCHMessage]>.create { (single) -> Disposable in
            base.getLastMessages(withCount: count) { (result, messages) in
                if result.isSuccessful, let messages = messages {
                    single(.success((messages)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
        
    /// Fetches at most `count` messages including and prior to the specified `index`.
    /// This will return locally cached messages if they are all available or may require a load from the server.
    /// - Parameters:
    ///   - index: The starting point for the request.
    ///   - count: The number of preceeding messages to return.
    func getMessagesBefore(index: UInt, with count: UInt) -> Single<[TCHMessage]> {
        return Single<[TCHMessage]>.create { (single) -> Disposable in
            base.getMessagesBefore(index, withCount: count) { (result, messages) in
                if result.isSuccessful, let messages = messages {
                    single(.success((messages)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
  
    /// Fetches at most `count` messages including and subsequent to the specified `index`.
    /// This will return locally cached messages if they are all available or may require a load from the server.
    /// - Parameters:
    ///   - index: The starting point for the request.
    ///   - count: The number of succeeding messages to return.
    func getMessagesAfter(index: UInt, with count: UInt) -> Single<[TCHMessage]> {
        return Single<[TCHMessage]>.create { (single) -> Disposable in
            base.getMessagesAfter(index, withCount: count) { (result, messages) in
                if result.isSuccessful, let messages = messages {
                    single(.success((messages)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Returns the message with the specified index.
    /// - Parameter index: The index of the message.
    func message(with index: NSNumber)-> Single<TCHMessage> {
        return Single<TCHMessage>.create { (single) -> Disposable in
            base.message(withIndex: index) { (result, message) in
                if result.isSuccessful, let message = message {
                    single(.success((message)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }

    /// Returns the oldest message starting at index.
    /// If the message at index does not exist, the next message will be returned.
    /// - Parameter index: The index of the last message reported as read (may refer to a deleted message).
    func message(forReadIndex index: NSNumber)-> Single<TCHMessage> {
        return Single<TCHMessage>.create { (single) -> Disposable in
            base.message(forReadIndex: index) { (result, message) in
                if result.isSuccessful, let message = message {
                    single(.success((message)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Set the last read index for this Participant and Conversation.
    /// Allows you to set any value, including smaller than the current index.
    /// - Parameter index: The new index.
    func setLastReadMessageIndex(index: NSNumber) -> Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.setLastReadMessageIndex(index) { (result, count) in
                if result.isSuccessful {
                    single(.success((count)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Update the last read index for this Participant and Conversation.
    /// Only update the index if the value specified is larger than the previous value.
    /// - Parameter index: The new index.
    func advanceLastConsumedMessageIndex(index: NSNumber) -> Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.advanceLastReadMessageIndex(index) { (result, count) in
                if result.isSuccessful {
                    single(.success((count)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }

    /// Update the last read index for this Participant and
    /// Conversation to the max message currently on this device.
    func setAllMessagesConsumed() -> Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.setAllMessagesReadWithCompletion() { (result, count) in
                if result.isSuccessful {
                    single(.success((count)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Reset the last read index for this Participant and Conversation to no messages read.
    func setAllMessagesUnread() -> Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.setAllMessagesUnreadWithCompletion() { result, number in
                if result.isSuccessful, let count = number?.uintValue  {
                    single(.success((count)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Fetch the number of unread messages on this conversation for the current user.
    ///
    ///  Use this method to obtain number of unread messages together with
    ///  [TCHConversation setLastReadMessageIndex:completion:] instead of relying on
    ///  TCHMessage indices which may have gaps. See [TCHMessage index] for details.
    ///
    ///  Available even if the conversation is not yet synchronized.
    ///
    ///  Note: if the last read index has not been yet set for current user as the participant of this conversation
    ///  then unread messages count is considered uninitialized. In this case nil is returned.
    ///  See [TCHConversation setLastReadMessageIndex:completion:].
    ///
    ///  This method is semi-realtime. This means that this data will be eventually correct,
    ///  but will also possibly be incorrect for a few seconds. The Conversations system does not
    ///  provide real time events for counter values changes.
    ///
    ///  So this is quite useful for any “unread messages count” badges, but is not recommended
    ///  to build any core application logic based on these counters being accurate in real time.
    ///  This function performs an async call to service to obtain up-to-date message count.
    ///
    ///  The retrieved value is then cached for 5 seconds so there is no reason to call this
    ///  function more often than once in 5 seconds.
    func getUnreadMessagesCount() -> Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.getUnreadMessagesCount(completion: { (result, number) in
                if result.isSuccessful, let count = number?.uintValue  {
                    single(.success((count)))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            })
            return Disposables.create {}
        }
    }
    
    /// Fetch the number of messages on this conversation.
    ///
    /// Available even if the conversation is not yet synchronized.
    ///
    /// This method is semi-realtime. This means that this data will be eventually correct,
    /// but will also possibly be incorrect for a few seconds. The Conversations system does not
    /// provide real time events for counter values changes.
    ///
    /// So this is quite useful for any UI badges, but is not recommended
    /// to build any core application logic based on these counters being accurate in real time.
    /// This function performs an async call to service to obtain up-to-date message count.
    ///
    /// The retrieved value is then cached for 5 seconds so there is no reason to call this
    /// function more often than once in 5 seconds.
    func getMessagesCount()->Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.getMessagesCount { (result, count) in
                if result.isSuccessful {
                    single(.success(count))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Fetch the number of participants on this conversation.
    ///
    /// Available even if the conversation is not yet synchronized.
    ///
    /// This method is semi-realtime. This means that this data will be eventually correct,
    /// but will also possibly be incorrect for a few seconds. The Conversations system does not
    /// provide real time events for counter values changes.
    ///
    /// So this is quite useful for any UI badges, but is not recommended
    /// to build any core application logic based on these counters being accurate in real time.
    /// This function performs an async call to service to obtain up-to-date message count.
    ///
    /// The retrieved value is then cached for 5 seconds so there is no reason to call this
    /// function more often than once in 5 seconds.
    func getParticipantsCount()->Single<UInt> {
        return Single<UInt>.create { (single) -> Disposable in
            base.getParticipantsCount { (result, count) in
                if result.isSuccessful {
                    single(.success(count))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Add specified username to this conversation.
    /// - Parameters:
    ///   - identity: The username to add to this conversation.
    ///   - attributes: The developer-defined extensible attributes for participant or nil to use default empty                         attributes. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
    func addParticipant(by identity: String, attributes: TCHJsonAttributes?) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.addParticipant(byIdentity: identity, attributes: attributes) { result in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Add specified non chat participant to this conversation, i.e. sms, whatsapp participants etc.
    /// - Parameters:
    ///   - address: The participant address to add to this conversation (phone number for sms and whatsapp participants)
    ///   - proxyAddress: Proxy address (Twilio phone number for sms and whatsapp participants).
    ///                   See conversations quickstart for more info: https://www.twilio.com/docs/conversations/quickstart
    ///   - attributes: The developer-defined extensible attributes for participant or nil to use default empty                        attributes. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
    func addParticipant(by address: String, proxyAddress: String, attributes: TCHJsonAttributes?) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.addParticipant(byAddress: address, proxyAddress: proxyAddress, attributes: attributes) { result in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Remove specified participant from this conversation.
    /// - Parameter participant: The participant to remove from this conversation.
    func removeParticipant(_ participant: TCHParticipant) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.removeParticipant(participant) { result in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Remove specified username from this conversation.
    /// - Parameter identity: The username to remove from this conversation.
    func removeParticipant(by identity: String) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.removeParticipant(byIdentity: identity) { result in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
}
