struct ApiError: IError {
    let message: String
    let error: Error?
}