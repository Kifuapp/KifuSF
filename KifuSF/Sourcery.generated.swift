// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// MARK: DonationOption SwitchlessCases
extension DonationOption {
    enum Errors: Error {
        case invokedMethodWithWrongCase
    }

    var isShowingPendingRequests: Bool {
        switch self {
        case .pendingRequests:
            return true
        default:
            return false
        }
    }

    func pendingRequests() throws -> [Donation] {
        switch self {
        case .pendingRequests(let value):
            return value
        default:
            throw Errors.invokedMethodWithWrongCase
        }
    }

    var isShowingCurrentDelivery: Bool {
        switch self {
        case .deliveringDonation:
            return true
        default:
            return false
        }
    }

    func deliveringDonation() throws -> Donation {
        switch self {
        case .deliveringDonation(let value):
            return value
        default:
            throw Errors.invokedMethodWithWrongCase
        }
    }

}


// MARK: Report KeyedProperties
extension Report {
    enum Keys {
        static let uid = "uid"
        static let donation = "donation"
        static let user = "user"
        static let flag = "flag"
        static let message = "message"
        static let author = "author"
        static let creatationDate = "creatation-date"
    }
}
