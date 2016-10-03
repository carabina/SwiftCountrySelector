//
//  SwiftCountrySelector.swift
//  Pods
//
//  Created by Gregg Luskin on 10/3/16.
//
//

import Foundation
import UIKit

@IBDesignable class SwiftCountrySelector: UIView {
    @IBInspectable var countryFontName: String = UIFont.systemFont(ofSize: 12.0).fontName
    @IBInspectable var countryTextColor: UIColor = UIColor.black
    @IBInspectable var phoneFontName: String = UIFont.systemFont(ofSize: 12.0).fontName
    @IBInspectable var phoneTextColor: UIColor = UIColor.lightGray
}
