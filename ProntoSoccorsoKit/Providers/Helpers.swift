
import Foundation

// MARK: Mapping Error
struct MappingLocation {
    let file: String
    let function: String
    let line: Int
    let column: Int
}

enum MappingError: Error {
    case notAnInt(where: MappingLocation, string: String)
    case invalidDate(where: MappingLocation, string: String)
    case invalidElementIndex(where: MappingLocation, index: Int)
}

// MARK: - Collection + Subscript
extension Collection where Index == Int {

    @inline(__always)
    func at(_ index: Index,
            file: String = #file,
            function: String = #function,
            line: Int = #line,
            column: Int = #column
            ) throws -> Element {
        if self.indices.contains(index) {
            return self[index]
        } else {
            let location = MappingLocation(file: file, function: function, line: line, column: column)
            throw MappingError.invalidElementIndex(where: location, index: index)
        }
    }

}

// MARK: Int + Mapping Utilities
extension Int {

    @inline(__always)
    init(fromString: String,
         file: String = #file,
         function: String = #function,
         line: Int = #line,
         column: Int = #column) throws {
        if let i = Int(fromString) {
            self = i
            return
        }
        let location = MappingLocation(file: file, function: function, line: line, column: column)
        throw MappingError.notAnInt(where: location, string: fromString)
    }

}

// MARK: DateFormatter + Mapping Utilities
extension DateFormatter {

    @inline(__always)
    func date(fromString: String,
              file: String = #file,
              function: String = #function,
              line: Int = #line,
              column: Int = #column
    ) throws -> Date {
        if let d = date(from: fromString) {
            return d
        }
        let location = MappingLocation(file: file, function: function, line: line, column: column)
        throw MappingError.invalidDate(where: location, string: fromString)
    }

}
