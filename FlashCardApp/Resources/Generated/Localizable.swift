// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// MARK: - Strings

internal enum Localizable {
  /// Check your email to reset password
  internal static let checkResetPassword = Localizable.tr("Localizable", "Check reset password")
  /// Please check your email to verify your account
  internal static let checkVerifyMail = Localizable.tr("Localizable", "Check verify mail")
  /// Email existed
  internal static let emailExisted = Localizable.tr("Localizable", "Email existed")
  /// ホーム
  internal static let tabHome = Localizable.tr("Localizable", "tabHome")
  /// ユーザー
  internal static let tabUser = Localizable.tr("Localizable", "tabUser")
  /// User canceled
  internal static let userCanceled = Localizable.tr("Localizable", "User canceled")
  /// Please enter your email
  internal static let warningEmail = Localizable.tr("Localizable", "Warning email")
  /// Please enter your password
  internal static let warningPassword = Localizable.tr("Localizable", "Warning password")
  /// Confirm password wrong
  internal static let wrongConfirmPassword = Localizable.tr("Localizable", "Wrong confirm password")
}

// MARK: - Implementation Details

extension Localizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle.main, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}


