// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c173db"></span>
  /// Alpha: 100% <br/> (0xc173dbff)
  internal static let arcane = ColorName(rgbaValue: 0xc173dbff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#14b3b2"></span>
  /// Alpha: 100% <br/> (0x14b3b2ff)
  internal static let druid = ColorName(rgbaValue: 0x14b3b2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#efaf2b"></span>
  /// Alpha: 100% <br/> (0xefaf2bff)
  internal static let gold = ColorName(rgbaValue: 0xefaf2bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#858590"></span>
  /// Alpha: 100% <br/> (0x858590ff)
  internal static let iron = ColorName(rgbaValue: 0x858590ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#25272e"></span>
  /// Alpha: 100% <br/> (0x25272eff)
  internal static let necromancer = ColorName(rgbaValue: 0x25272eff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#25272e"></span>
  /// Alpha: 100% <br/> (0x25272eff)
  internal static let obsidian = ColorName(rgbaValue: 0x25272eff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5c84b"></span>
  /// Alpha: 100% <br/> (0xf5c84bff)
  internal static let paladin = ColorName(rgbaValue: 0xf5c84bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e85a5a"></span>
  /// Alpha: 100% <br/> (0xe85a5aff)
  internal static let poppy = ColorName(rgbaValue: 0xe85a5aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#dbdae1"></span>
  /// Alpha: 100% <br/> (0xdbdae1ff)
  internal static let powder = ColorName(rgbaValue: 0xdbdae1ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#454a66"></span>
  /// Alpha: 100% <br/> (0x454a66ff)
  internal static let ranger = ColorName(rgbaValue: 0x454a66ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f2f3f7"></span>
  /// Alpha: 100% <br/> (0xf2f3f7ff)
  internal static let salt = ColorName(rgbaValue: 0xf2f3f7ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#578ddd"></span>
  /// Alpha: 100% <br/> (0x578dddff)
  internal static let soldier = ColorName(rgbaValue: 0x578dddff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#37d7c8"></span>
  /// Alpha: 100% <br/> (0x37d7c8ff)
  internal static let thresh = ColorName(rgbaValue: 0x37d7c8ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let white = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#51515c"></span>
  /// Alpha: 100% <br/> (0x51515cff)
  internal static let worgen = ColorName(rgbaValue: 0x51515cff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
