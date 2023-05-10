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
    public var onLoginAttemptPayload: PinwheelLoginAttemptPayload?
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
    
    func onLoginAttempt(_ result: PinwheelLoginAttemptPayload) {
        onLoginAttemptPayload = result
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
                        "platformId": "20023e4b-b505-451d-808e-12b47c46ee15"
                    ]
                ]
                let message = TestMessage("loginEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("login"))
                let payload = delegate.onEventPayload as? PinwheelLoginPayload
                expect(payload?.accountId).to(equal("314159"))
                expect(payload?.platformId).to(equal("20023e4b-b505-451d-808e-12b47c46ee15"))
            }
            
            it("onEvent is called for login_attempt") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "login_attempt",
                    "payload": [
                        "platformId": "20023e4b-b505-451d-808e-12b47c46ee15"
                    ]
                ]
                let message = TestMessage("loginAttemptEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("login_attempt"))
                let payload = delegate.onEventPayload as? PinwheelLoginAttemptPayload
                expect(payload?.platformId).to(equal("20023e4b-b505-451d-808e-12b47c46ee15"))
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
            
            it("onEvent is called for input_required") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "input_required"
                ]
                let message = TestMessage("inputRequiredEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onEventName?.rawValue).to(equal("input_required"))
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
                            "message": "Uh oh",
                            "pendingRetry": true,
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
                expect(payload?.pendingRetry).to(beTrue())
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
                        "platformId": "abcd-1234",
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
                expect(payload?.platformId).to(equal("abcd-1234"))
                expect(payload?.job).to(equal("direct_deposit_switch"))
                expect(payload?.params?.amount?.unit).to(equal("$"))
                expect(payload?.params?.amount?.value).to(equal(3.14159))
            }
            
            it("onEvent is called for success with null values") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "success",
                    "payload": [
                        "accountId": "314159",
                        "platformId": "abcd-1234",
                        "job": "direct_deposit_switch",
                        "params": nil
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("successEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                let payload = delegate.onEventPayload as? PinwheelSuccessPayload
                expect(payload?.accountId).to(equal("314159"))
                expect(payload?.platformId).to(equal("abcd-1234"))
                expect(payload?.params).to(beNil())
                expect(payload?.job).to(equal("direct_deposit_switch"))
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
                        "message": "Uh oh",
                        "pendingRetry": false,
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
                expect(payload?.pendingRetry).to(beFalse())
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
                            "message": "Uh oh",
                            "pendingRetry": true,
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
                expect(delegate.onExitPayload?.pendingRetry).to(beTrue())
            }
            
            it("onSuccess is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "success",
                    "payload": [
                        "accountId": "314159",
                        "platformId": "abcd-1234",
                        "job": "direct_deposit_switch",
                        "params": [
                            "amount": [
                                "unit": "$",
                                "value": 3.14159
                            ]
                        ],
                        
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("successEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onSuccessPayload?.accountId).to(equal("314159"))
                expect(delegate.onSuccessPayload?.platformId).to(equal("abcd-1234"))
                expect(delegate.onSuccessPayload?.job).to(equal("direct_deposit_switch"))
                expect(delegate.onSuccessPayload?.params?.amount?.unit).to(equal("$"))
                expect(delegate.onSuccessPayload?.params?.amount?.value).to(equal(3.14159))
            }
            
            it("onLogin is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "login",
                    "payload": [
                        "accountId": "314159",
                        "platformId": "20023e4b-b505-451d-808e-12b47c46ee15"
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("loginEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onLoginPayload?.accountId).to(equal("314159"))
                expect(delegate.onLoginPayload?.platformId).to(equal("20023e4b-b505-451d-808e-12b47c46ee15"))
            }
            
            it("onLoginAttempt is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "login_attempt",
                    "payload": [
                        "platformId": "20023e4b-b505-451d-808e-12b47c46ee15"
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("loginAttemptEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onLoginAttemptPayload?.platformId).to(equal("20023e4b-b505-451d-808e-12b47c46ee15"))
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
                        "message": "Uh oh",
                        "pendingRetry": true,
                    ]
                ]
                let bodyString = asString(jsonDictionary: body)
                let message = TestMessage("errorEventHandler", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.onErrorPayload?.type).to(equal("invalidUserInput"))
                expect(delegate.onErrorPayload?.code).to(equal("invalidCredentials"))
                expect(delegate.onErrorPayload?.message).to(equal("Uh oh"))
                expect(delegate.onErrorPayload?.pendingRetry).to(beTrue())
            }

            it("onEvent is called for screen_transition") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let body: JSONDictionary = [
                    "type": "PINWHEEL_EVENT",
                    "eventName": "screen_transition",
                    "payload": [
                        "screenName" : "SEARCH_DEFAULT",
                        "selectedPlatformId": nil,
                        "selectedPlatformName": nil
                    ]
                ]
                let message = TestMessage("screenTransitionEventHandler", body: asString(jsonDictionary: body))
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                let payload = delegate.onEventPayload as? PinwheelScreenTransitionPayload
                expect(payload?.screenName).to(equal("SEARCH_DEFAULT"))
                expect(payload?.selectedPlatformId).to(beNil())
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
