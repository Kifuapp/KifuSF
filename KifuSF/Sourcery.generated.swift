// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// MARK: DeliveryDonationState CasableVars
extension DeliveryDonationState {

    var isDonationIsNotAlreadyRequested: Bool {
        switch self {
        case .donationIsNotAlreadyRequested:
            return true
        default:
            return false
        }
    }

    var isUserAlreadyHasAnOpenDelivery: Bool {
        switch self {
        case .userAlreadyHasAnOpenDelivery:
            return true
        default:
            return false
        }
    }

}
