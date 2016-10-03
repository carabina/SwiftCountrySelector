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
    
    /** Did Layout Subviews */
    private var didLayoutSubviews: Bool = false
    
    /** Picker View */
    var pickerView: UIPickerView?
    var createPickerView: UIPickerView {
        return SCSPickerView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    }
    
    override func layoutSubviews() {
        if !didLayoutSubviews {
            self.didLayoutSubviews = true
            self.addSubview(createPickerView)
        }
    }
}
