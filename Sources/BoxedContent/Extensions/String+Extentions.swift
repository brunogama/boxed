
extension String {
    var visualLength: Int {
        reduce(0) { $0 + $1.terminalWidth }
    }
}
