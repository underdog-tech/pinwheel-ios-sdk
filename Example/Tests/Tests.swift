// https://github.com/Quick/Quick

import Quick
import Nimble
import PinwheelSDK
import WebKit

class PinwheelVCDelegate: PinwheelDelegate {
    public var onEventName: PinwheelEventType?
    public var onEventPayload: PinwheelEventPayload?
    public var onExitPayload: PinwheelError?
    public var onSuccessPayload: PinwheelSuccessPayload?
    public var onLoginPayload: PinwheelLoginPayload?
    public var onErrorPayload: PinwheelError?
    
    func onEvent(name: PinwheelEventType, event: PinwheelEventPayload?) {
        onEventName = name
        onEventPayload = event
    }
    
    func onExit(_ error: PinwheelError?) {
        onExitPayload = error
    }
    
    func onSuccess(_ result: PinwheelSuccessPayload) {
        onSuccessPayload = result
    }
    
    func onLogin(_ result: PinwheelLoginPayload) {
        onLoginPayload = result
    }
    
    func onError(_ error: PinwheelError) {
        onErrorPayload = error
    }
}

class TestMessage: WKScriptMessage {
    var messageName: String
    var bodyString: String
    
    override public var name: String {
        get {
            return messageName
        }
    }
    
    override public var body: Any {
        get {
            return bodyString
        }
    }
    
    init(_ name: String, body: String) {
        self.messageName = name
        self.bodyString = body
    }
}

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        let linkToken = "abc-123"
        
        describe("Pinwheel") {
            
            it("onEvent is called for open") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "open"
                ]
                let message = TestMessage("openEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("open"))
            }
            
            it("onEvent is called for select_employer") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "select_employer",
                    "payload": [
                        "selectedEmployerId": "GME",
                        "selectedEmployerName": "GameStop"
                    ]
                ]
                let message = TestMessage("selectEmployerEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                let payload = delegate.onEventPayload as? PinwheelSelectedEmployerPayload
                expect(payload?.selectedEmployerId).to(equal("GME"))
                expect(payload?.selectedEmployerName).to(equal("GameStop"))
                expect(delegate.onEventName?.rawValue).to(equal("select_employer"))
            }
            
            it("onEvent is called for select_platform") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "select_platform",
                    "payload": [
                        "selectedPlatformId": "GSTO",
                        "selectedPlatformName": "Gusto"
                    ]
                ]
                let message = TestMessage("selectPlatformEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                let payload = delegate.onEventPayload as? PinwheelSelectedPlatformPayload
                expect(payload?.selectedPlatformId).to(equal("GSTO"))
                expect(payload?.selectedPlatformName).to(equal("Gusto"))
                expect(delegate.onEventName?.rawValue).to(equal("select_platform"))
            }
            
            it("onEvent is called for incorrect_platform_given") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "incorrect_platform_given"
                ]
                let message = TestMessage("incorrectPlatformGivenHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("incorrect_platform_given"))
            }
            
            it("onEvent is called for login") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "login",
                    "payload": [
                        "accountId": "314159",
                    ]
                ]
                let message = TestMessage("loginEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("login"))
                let payload = delegate.onEventPayload as? PinwheelLoginPayload
                expect(payload?.accountId).to(equal("314159"))
            }
            
            it("onEvent is called for input_amount") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "input_amount",
                    "payload": [
                        "value": 3.14159,
                        "unit": "$"
                    ]
                ]
                let message = TestMessage("inputAmountEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("input_amount"))
                let payload = delegate.onEventPayload as? PinwheelAmountPayload
                expect(payload?.value).to(equal(3.14159))
                expect(payload?.unit).to(equal("$"))
            }
            
            it("onEvent is called for exit") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "exit",
                    "payload": [
                        "error": [
                            "type": "invalidUserInput",
                            "code": "invalidCredentials",
                            "message": "Uh oh"
                        ]
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("exitEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("exit"))
                let payload = delegate.onEventPayload as? PinwheelError
                expect(payload?.type).to(equal("invalidUserInput"))
                expect(payload?.code).to(equal("invalidCredentials"))
                expect(payload?.message).to(equal("Uh oh"))
            }
            
            it("onEvent is called for success") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "success",
                    "payload": [
                        "accountId": "314159",
                        "job": "direct_deposit_switch",
                        "params": [
                            "amount": [
                                "unit": "$",
                                "value": 3.14159
                            ]
                        ]
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("successEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                let payload = delegate.onEventPayload as? PinwheelSuccessPayload
                expect(payload?.accountId).to(equal("314159"))
                expect(payload?.job).to(equal("direct_deposit_switch"))
                expect(payload?.params.amount.unit).to(equal("$"))
                expect(payload?.params.amount.value).to(equal(3.14159))
            }
            
            it("onEvent is called for error") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "error",
                    "payload": [
                        "type": "invalidUserInput",
                        "code": "invalidCredentials",
                        "message": "Uh oh"
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("errorEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                let payload = delegate.onEventPayload as? PinwheelError
                expect(payload?.type).to(equal("invalidUserInput"))
                expect(payload?.code).to(equal("invalidCredentials"))
                expect(payload?.message).to(equal("Uh oh"))
            }
            
            it("onExit is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "exit",
                    "payload": [
                        "error": [
                            "type": "invalidUserInput",
                            "code": "invalidCredentials",
                            "message": "Uh oh"
                        ]
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("exitEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onExitPayload?.type).to(equal("invalidUserInput"))
                expect(delegate.onExitPayload?.code).to(equal("invalidCredentials"))
                expect(delegate.onExitPayload?.message).to(equal("Uh oh"))
            }
            
            it("onSuccess is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "success",
                    "payload": [
                        "accountId": "314159",
                        "job": "direct_deposit_switch",
                        "params": [
                            "amount": [
                                "unit": "$",
                                "value": 3.14159
                            ]
                        ]
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("successEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onSuccessPayload?.accountId).to(equal("314159"))
                expect(delegate.onSuccessPayload?.job).to(equal("direct_deposit_switch"))
                expect(delegate.onSuccessPayload?.params.amount.unit).to(equal("$"))
                expect(delegate.onSuccessPayload?.params.amount.value).to(equal(3.14159))
            }
            
            it("onLogin is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "login",
                    "payload": [
                        "accountId": "314159",
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("loginEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onLoginPayload?.accountId).to(equal("314159"))
            }
            
            it("onError is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "error",
                    "payload": [
                        "type": "invalidUserInput",
                        "code": "invalidCredentials",
                        "message": "Uh oh"
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("errorEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onErrorPayload?.type).to(equal("invalidUserInput"))
                expect(delegate.onErrorPayload?.code).to(equal("invalidCredentials"))
                expect(delegate.onErrorPayload?.message).to(equal("Uh oh"))
            }
        }
    }
}

typealias JSONDictionary = [String : Any]

func asString(jsonDictionary: JSONDictionary) -> String {
  do {
    let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
    return String(data: data, encoding: String.Encoding.utf8) ?? ""
  } catch {
    return ""
  }
}
