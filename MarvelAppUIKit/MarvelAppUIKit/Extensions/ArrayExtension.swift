import Foundation

extension Array {
    func range(fromIndex: Int, toIndex: Int) -> Array {
        guard count > 0  else {
            return []
        }

        guard fromIndex >= 0,
              toIndex > 0,
              fromIndex < count,
              toIndex <= count,
              fromIndex < toIndex else {

            return []
        }

        return Array(self[fromIndex..<toIndex])
    }
}
