import Foundation

public struct PinwheelDDFormCreateEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelDDFormCreate) {
        self.url = url
    }

    public let url: String
}
