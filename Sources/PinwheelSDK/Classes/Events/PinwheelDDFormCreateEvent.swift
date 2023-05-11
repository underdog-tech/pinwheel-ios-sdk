import Foundation

public struct PinwheelDDFormCreateEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelDDFormCreatePayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }

    public let type: String
    public let eventName: String
    public let payload: PinwheelDDFormCreatePayload
}
