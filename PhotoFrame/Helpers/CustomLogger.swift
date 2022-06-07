
import UIKit

// MARK: - Custom Logger

public enum Log {
     public static func debug(
        _ data: @autoclosure () -> Any?,
        file: String = #file,
        line: Int = #line
    ) {
        print("\n📗 [DEBUG START]: \n📗👉 \(String(describing: data() ?? "nil")) \n📗 [FILE: \(extractFileName(from: file))] [LINE: \(line)] \n📗 [END]\n")
    }

    public static func error(
        _ data: @autoclosure () -> Any?,
        file: String = #file,
        line: Int = #line
    ) {
        print("\n📕 [ERROR START]: \n📕☝️\(String(describing: data() ?? "nil")) \n📕 [FILE: \(extractFileName(from: file))] [LINE: \(line)] \n📕 [END]\n")
    }

    private static func extractFileName(from path: String) -> String {
        return path.components(separatedBy: "/").last ?? ""
    }
}
