//
//  Pinwheel.swift
//  Pods
//
//  Created by Robby Abaya on 11/17/20.
//

import Foundation

import UIKit
import WebKit
import SwiftUI

public protocol PinwheelDelegate {
    func onEvent(_ event: PinwheelActionEvent)
    func onExit(_ event: PinwheelExitEvent)
    func onSuccess(_ event: PinwheelSuccessEvent)
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
        
        if message.name == "linkMessageHandlerExit" || message.name == "linkMessageHandlerClose" {
            
            if let bodyString = message.body as? String,
               let bodyData = bodyString.data(using: .utf8),
               let event = try? JSONDecoder().decode(PinwheelExitEvent.self, from: bodyData) {
                
                self.delegate.onExit(event)
            }
        } else if message.name == "linkMessageHandlerSuccess" {
            
            if let bodyString = message.body as? String,
               let bodyData = bodyString.data(using: .utf8),
               let event = try? JSONDecoder().decode(PinwheelSuccessEvent.self, from: bodyData) {
                
                self.delegate.onSuccess(event)
            }
        } else  {
            
            if let bodyString = message.body as? String,
               let bodyData = bodyString.data(using: .utf8),
               let event = try? JSONDecoder().decode(PinwheelActionEvent.self, from: bodyData) {
                
                self.delegate.onEvent(event)
            }
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
        contentController.add(self, name: "linkMessageHandler")
        contentController.add(self, name: "linkMessageHandlerExit")
        contentController.add(self, name: "linkMessageHandlerClose")
        contentController.add(self, name: "linkMessageHandlerSuccess")
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://cdn.getpinwheel.com/link-v2.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        let wv = WKWebView(frame: view.bounds, configuration: configuration)
        wv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wv.uiDelegate = self
        view = wv
        return wv
    }
}

private func getScript(token: String, initializationTime: Int64) -> String {
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
                if (event.data.type === "PINWHEEL_EXIT" && window.webkit.messageHandlers.linkMessageHandlerExit) {
                    window.webkit.messageHandlers.linkMessageHandlerExit.postMessage(JSON.stringify(event.data));
                } else if (event.data.type === "PINWHEEL_MODAL_CLOSE" && window.webkit.messageHandlers.linkMessageHandlerClose) {
                    window.webkit.messageHandlers.linkMessageHandlerClose.postMessage(JSON.stringify(event.data));
                } else if (event.data.type === "PINWHEEL_SUCCESS" && window.webkit.messageHandlers.linkMessageHandlerSuccess) {
                    window.webkit.messageHandlers.linkMessageHandlerSuccess.postMessage(JSON.stringify(event.data));
                } else if (window.webkit.messageHandlers.linkMessageHandler) {
                    window.webkit.messageHandlers.linkMessageHandler.postMessage(JSON.stringify(event.data));
                }
            }
        });

        window.postMessage(
          {
            type: 'PINWHEEL_INIT',
            payload: {
              sdk: "ios",
              fullScreen: true,
              linkToken: "\(token)",
              uniqueUserId: uuid,
              initializationTimestamp: \(initializationTime)
            }
          }
        );
        } catch (err) {
            console.error(err);
        }
        true;
        """
}
