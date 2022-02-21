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

// MARK: - TwilioConversationsClient + Rx

public extension Reactive where Base: TwilioConversationsClient {

    /// Initialize a new conversations client instance.
    /// - Parameters:
    ///   - token: The client access token to use when communicating with Twilio.
    ///   - properties: The properties to initialize the client with, if this is nil defaults will be used.
    static func chatClient(with token: String, properties: TwilioConversationsClientProperties?, delegate: TwilioConversationsClientDelegate? = nil) -> Single<TwilioConversationsClient> {
        return Single<TwilioConversationsClient>.create { (single) -> Disposable in
            TwilioConversationsClient.conversationsClient(withToken: token, properties: properties, delegate: delegate) { (result, conversationsClient) in
                if let conversationsClient = conversationsClient, result.isSuccessful {
                    single(.success(conversationsClient))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Updates the access token currently being used by the client.
    /// - Parameter token: The updated client access token to use when communicating with Twilio.
    func updateToken(_ token: String) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.updateToken(token) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }

    /// Create a new conversation with the specified options.
    /// - Parameter options:  Conversation options for new conversation whose keys are TCHConversationOption* constants. (optional - may be empty or nil)
    ///
    /// `TCHConversationOptionFriendlyName` - String friendly name (optional)
    /// `TCHConversationOptionUniqueName` - String unique name (optional)
    /// `TCHConversationOptionAttributes` - Expected value is an valid json object, see also TCHConversation
    func createConversation(with options: [String : Any]?) -> Single<TCHConversation> {
        return Single<TCHConversation>.create { (single) -> Disposable in
            base.createConversation(options: options) { result, conversation in
                if let conversation = conversation, result.isSuccessful {
                    single(.success(conversation))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }

    /// Obtains a conversation with the specified id or unique name.
    /// - Parameter sidOrUniqueName: Identifier or unique name for the conversation.
    func conversationWithSidOrUniqueName(sidOrUniqueName: String) -> Single<TCHConversation> {
        return Single<TCHConversation>.create { (single) -> Disposable in
            base.conversation(withSidOrUniqueName: sidOrUniqueName) { result, conversation in
                if let conversation = conversation, result.isSuccessful {
                    single(.success(conversation))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Obtain a subscribed user object for the given identity.
    /// If no current subscription exists for this user, this will fetch the user and subscribe them.
    /// The least recently subscribed user object will be unsubscribed if you reach your instance's  user subscription limit.
    /// - Parameter identity: The identity of the user to obtain.
    func subscribedUser(with identity: String) -> Single<TCHUser> {
        return Single<TCHUser>.create { (single) -> Disposable in
            base.subscribedUser(withIdentity: identity) { result, user in
                if let user = user, result.isSuccessful {
                    single(.success(user))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {}
        }
    }
    
 
    /// Register APNS token for push notification updates.
    /// - Parameter token: The APNS token which usually comes from
    ///                    `didRegisterForRemoteNotificationsWithDeviceToken`.
    func register(with notificationToken: Data) -> Completable {
        return Completable.create { (completable) -> Disposable in
            self.base.register(withNotificationToken: notificationToken) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }

    /// De-register from push notification updates.
    /// - Parameter notificationToken: The APNS token which usually comes from
    ///                                `didRegisterForRemoteNotificationsWithDeviceToken`.
    func deregister(with notificationToken: Data) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.deregister(withNotificationToken: notificationToken) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }

    /// Queue the incoming notification with the messaging library
    /// for processing - notifications usually arrive from `didReceiveRemoteNotification`.
    /// - Parameter notification: The incomming notification.
    func handleNotification(_ notification: [AnyHashable: Any]) -> Completable {
        return Completable.create { (completable) -> Disposable in
            base.handleNotification(notification) { (result) in
                if let error = result.error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    /// Get content URLs for all media attachments in the given set using a single network request.
    /// - Parameter media: The set of media objects to query for content URLs.
    func getTemporaryContentUrls(for media: Set<Media>) -> Single<[String: URL]> {
        return Single<[String : URL]>.create { (single) -> Disposable in
            let cancellableToken = base.getTemporaryContentUrlsFor(media: media) { result, temporaryContentUrls in
                if let temporaryContentUrls = temporaryContentUrls, result.isSuccessful {
                    single(.success(temporaryContentUrls))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
    /// Get content URLs for all media attachments in the given set using a single network request.
    /// - Parameter mediaSids: The set of sids of media sids to query for content URLs.
    func getTemporaryContentUrls(for mediaSids: Set<String>) -> Single<[String: URL]> {
        return Single<[String : URL]>.create { (single) -> Disposable in
            let cancellableToken = base.getTemporaryContentUrlsFor(mediaSids: mediaSids) { result, temporaryContentUrls in
                if let temporaryContentUrls = temporaryContentUrls, result.isSuccessful {
                    single(.success(temporaryContentUrls))
                } else {
                    single(.failure(result.error ?? RxTwilioError.unknown))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}

