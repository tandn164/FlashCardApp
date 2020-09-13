// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// MARK: - Strings

internal enum Localizable {
  /// ホーム
  internal static let tabHome = Localizable.tr("Localizable", "tabHome")
  /// ラーニング
  internal static let tabLearn = Localizable.tr("Localizable", "tabLearn")
  /// ユーザー
  internal static let tabUser = Localizable.tr("Localizable", "tabUser")
}

// MARK: - Implementation Details

extension Localizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle.main, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}


