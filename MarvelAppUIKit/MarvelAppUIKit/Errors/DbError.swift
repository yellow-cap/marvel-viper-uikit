struct DbError: IError {
    let message: String
    let error: Error?
}