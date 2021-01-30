// https://github.com/Quick/Quick

import Quick
import Nimble
import PinwheelSDK
import WebKit

class PinwheelVCDelegate: PinwheelDelegate {
    public var actionEvent: PinwheelActionEvent?
    public var exitEvent: PinwheelExitEvent?
    public var successEvent: PinwheelSuccessEvent?
    
    func onEvent(_ event: PinwheelActionEvent) {
        self.actionEvent = event
    }
    
    func onExit(_ event: PinwheelExitEvent) {
        self.exitEvent = event
    }
    
    func onSuccess(_ event: PinwheelSuccessEvent) {
        self.successEvent = event
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
            it("Exit event is called") {
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let message = TestMessage("linkMessageHandlerExit", body: "{\"type\":\"PINWHEEL_MODAL_CLOSE\"}")
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.exitEvent?.type).to(equal("PINWHEEL_MODAL_CLOSE"))
            }
            
            it("receives events") {
                let bodyString = """
                {
                    "type": "PINWHEEL_EVENT",
                    "name": "Intro",
                    "payload": {
                        "job": "direct_deposit_switch"
                    },
                }
                """
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let message = TestMessage("linkMessageHandlerAction", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.actionEvent?.type).to(equal("PINWHEEL_EVENT"))
            }
            
            it("receives the success callback") {
                let bodyString = """
                {
                    "type": "PINWHEEL_SUCCESS",
                    "result": {
                        "tokenId": "abc-123"
                    }
                }
                """
                let delegate = PinwheelVCDelegate()
                let userContentController = WKUserContentController()
                let message = TestMessage("linkMessageHandlerSuccess", body: bodyString)
                let pinwheelVC = PinwheelViewController(token: linkToken, delegate: delegate)
                pinwheelVC.userContentController(userContentController, didReceive: message)
                expect(delegate.successEvent?.type).to(equal("PINWHEEL_SUCCESS"))
            }
            
        }
    }
}
