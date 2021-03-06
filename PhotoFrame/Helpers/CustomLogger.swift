
import UIKit

// MARK: - Custom Logger

public enum Log {
     public static func debug(
        _ data: @autoclosure () -> Any?,
        file: String = #file,
        line: Int = #line
    ) {
        print("\nš [DEBUG START]: \nšš \(String(describing: data() ?? "nil")) \nš [FILE: \(extractFileName(from: file))] [LINE: \(line)] \nš [END]\n")
    }

    public static func error(
        _ data: @autoclosure () -> Any?,
        file: String = #file,
        line: Int = #line
    ) {
        print("\nš [ERROR START]: \nšāļø\(String(describing: data() ?? "nil")) \nš [FILE: \(extractFileName(from: file))] [LINE: \(line)] \nš [END]\n")
    }

    private static func extractFileName(from path: String) -> String {
        return path.components(separatedBy: "/").last ?? ""
    }
}
