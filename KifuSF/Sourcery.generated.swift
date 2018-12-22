// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: SwitchlessCases

// ## Available annoations:
// //   sourcery: case_skip
// case uid
//
// //   sourcery: case_name = "url"
// case imageUrl

extension Donation.Status {

    var isOpen: Bool {
        switch self {
        case .open:
            return true
        default:
            return false
        }
    }

    var isAwaitingPickup: Bool {
        switch self {
        case .awaitingPickup:
            return true
        default:
            return false
        }
    }

    var isAwaitingDelivery: Bool {
        switch self {
        case .awaitingDelivery:
            return true
        default:
            return false
        }
    }

    var isAwaitingApproval: Bool {
        switch self {
        case .awaitingApproval:
            return true
        default:
            return false
        }
    }

}
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

// MARK: KeyedStoredProperties

// ## Available annoations:
// //   sourcery: var_skip
// var uid: String
//
// //   sourcery: key_name = "url"
// var imageUrl: URL

extension Donation {
    enum Keys {
        static let uid = "uid"
        static let title = "title"
        static let notes = "notes"
        static let imageUrl = "image-url"
        static let creationDate = "creation-date"
        static let longitude = "longitude"
        static let latitude = "latitude"
        static let pickUpAddress = "pick-up-address"
        static let donator = "donator"
        static let verificationUrl = "verification-url"
        static let flag = "flag"
        static let flaggedReportUid = "flagged-report-uid"
        static let status = "status"
        static let volunteer = "volunteer"
    }
}

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

extension User {
    enum Keys {
        static let contributionPoints = "contribution-points"
        static let uid = "uid"
        static let imageURL = "image-url"
        static let username = "username"
        static let contactNumber = "contact-number"
        static let isVerified = "is-verified"
        static let hasApprovedConditions = "has-approved-conditions"
        static let contributionPoints = "contribution-points"
        static let flag = "flag"
        static let flaggedReportUid = "flagged-report-uid"
        static let currentLocation = "current-location"
    }
}
