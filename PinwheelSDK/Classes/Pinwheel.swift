//
//  Pinwheel.swift
//  Pods
//
//  Created by Robby Abaya on 11/17/20.
//

import Foundation

import UIKit
import WebKit

public protocol PinwheelDelegate {
    func onEvent(name: PinwheelEventType, event: PinwheelEventPayload?)
    func onExit(_ error: PinwheelError?)
    func onSuccess(_ result: PinwheelSuccessPayload)
    func onLogin(_ result: PinwheelLoginPayload)
    func onError(_ error: PinwheelError)
}

// These empty implementations are to make them optional to implement
public extension PinwheelDelegate {
    func onEvent(name: PinwheelEventType, event: PinwheelEventPayload?) {}
    func onExit(_ error: PinwheelError?) {}
    func onSuccess(_ result: PinwheelSuccessPayload) {}
    func onLogin(_ result: PinwheelLoginPayload) {}
    func onError(_ error: PinwheelError) {}
}

public class PinwheelViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    var webView: WKWebView!
    var delegate: PinwheelDelegate
    private var token: String
    
    public init(token: String, delegate: PinwheelDelegate) {
        self.delegate = delegate
        self.token = token
        super.init(nibName: nil, bundle: nil)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        switch message.name {
        case PinwheelEventHandler.openEventHandler.rawValue:
            self.delegate.onEvent(name: .open, event: nil)
        case PinwheelEventHandler.selectEmployerEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelSelectedEmployerEvent.self, from: bodyData) {
                
                self.delegate.onEvent(name: .selectEmployer, event: event.payload)
            }
        case PinwheelEventHandler.selectPlatformEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelSelectedPlatformEvent.self, from: bodyData) {
                
                self.delegate.onEvent(name: .selectPlatform, event: event.payload)
            }
        case PinwheelEventHandler.incorrectPlatformGivenHandler.rawValue:
            self.delegate.onEvent(name: .incorrectPlatformGiven, event: nil)
        case PinwheelEventHandler.loginEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelLoginEvent.self, from: bodyData) {
                
                self.delegate.onEvent(name: .login, event: event.payload)
                self.delegate.onLogin(event.payload)
            }
        case PinwheelEventHandler.inputAmountEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelInputAmountEvent.self, from: bodyData) {
                
                self.delegate.onEvent(name: .inputAmount, event: event.payload)
            }
        case PinwheelEventHandler.exitEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelExitEvent.self, from: bodyData) {
                
                self.delegate.onEvent(name: .exit, event: event.payload?.error)
                self.delegate.onExit(event.payload?.error)
            }
        case PinwheelEventHandler.successEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelSuccessEvent.self, from: bodyData) {

                self.delegate.onEvent(name: .success, event: event.payload)
                self.delegate.onSuccess(event.payload)
            }
        case PinwheelEventHandler.errorEventHandler.rawValue:
            if let bodyData = bodyDataFromMessage(message),
               let event = try? JSONDecoder().decode(PinwheelErrorEvent.self, from: bodyData) {
                
                self.delegate.onEvent(name: .error, event: event.payload)
                self.delegate.onError(event.payload)
            }
        default:
            print("Unhandled message: \(message.name)")
        }
    }
    
    public override func loadView() {
        let now = Int64(Date().timeIntervalSince1970 * 1000)
        let script = getScript(token: self.token, initializationTime: now)
        let wkScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController.addUserScript(wkScript)
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: PinwheelEventHandler.openEventHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.selectEmployerEventHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.incorrectPlatformGivenHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.loginEventHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.inputAmountEventHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.exitEventHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.successEventHandler.rawValue)
        contentController.add(self, name: PinwheelEventHandler.errorEventHandler.rawValue)
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://cdn.getpinwheel.com/link-v3.2.0.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if let url = navigationAction.request.url {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
        return nil
    }
    
    private func bodyDataFromMessage(_ message: WKScriptMessage) -> Data? {
        if let bodyString = message.body as? String,
           let bodyData = bodyString.data(using: .utf8) {

            return bodyData
        }
        return nil
    }
}

private enum PinwheelEventHandler: String {
    case openEventHandler
    case selectEmployerEventHandler
    case selectPlatformEventHandler
    case incorrectPlatformGivenHandler
    case loginEventHandler
    case inputAmountEventHandler
    case exitEventHandler
    case successEventHandler
    case errorEventHandler
}

private func getScript(token: String, initializationTime: Int64) -> String {
    var versionString = "2.2.0"
    if let bundleVersion = Bundle(identifier: "org.cocoapods.PinwheelSDK")?.infoDictionary?["CFBundleShortVersionString"] as? String {
        print(bundleVersion)
        versionString = bundleVersion
    }
    let version = versionString.split(separator: ".")
    
    return """
        const uuidKey = 'pinwheel-uuid';
        const localStorage = window.localStorage;
        let uuid = localStorage.getItem(uuidKey);
        if(!uuid) {
            uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
          var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
          return v.toString(16);
        });
        localStorage.setItem(uuidKey, uuid);
        }
        try {
        window.addEventListener('message', event => {
            if (window.webkit && window.webkit.messageHandlers) {
                if (event.data.type === "PINWHEEL_EVENT") {
                    switch (event.data.eventName) {
                        case "\(PinwheelEventType.open.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.openEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.openEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.selectEmployer.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.selectEmployerEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.selectEmployerEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.selectPlatform.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.selectPlatformEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.selectPlatformEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.incorrectPlatformGiven.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.incorrectPlatformGivenHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.incorrectPlatformGivenHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.login.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.loginEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.loginEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.inputAmount.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.inputAmountEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.inputAmountEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;

                        case "\(PinwheelEventType.exit.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.exitEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.exitEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.success.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.successEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.successEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                        case "\(PinwheelEventType.error.rawValue)":
                            if (window.webkit.messageHandlers.\(PinwheelEventHandler.errorEventHandler.rawValue)) {
                                window.webkit.messageHandlers.\(PinwheelEventHandler.errorEventHandler.rawValue).postMessage(JSON.stringify(event.data));
                            }
                            break;
                    }
                }
            }
        });
        window.postMessage(
          {
            type: 'PINWHEEL_INIT',
            payload: {
                sdk: "ios",
                linkToken: "\(token)",
                uniqueUserId: uuid,
                initializationTimestamp: \(initializationTime),
                version: {
                    major: \(version[0]),
                    minor: \(version.count > 1 ? version[1] : "0"),
                    patch: \(version.count > 2 ? version[2] : "0")
                }
            }
          }
        );
        } catch (err) {
            console.error(err);
        }
        true;
        """
}
