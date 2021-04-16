protocol IError: Error {
    var message: String { get }
    var error: Error? { get }
}
