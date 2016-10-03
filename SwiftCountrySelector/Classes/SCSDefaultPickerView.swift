//
//  SCSDefaultPickerView.swift
//  Pods
//
//  Created by Gregg Luskin on 10/3/16.
//
//

import Foundation
import UIKit

class SCSDefaultPickerView: UIView {
    
    /** The font to be displayed */
    var font: UIFont?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(country: Country) {
        
        /** The Country Name Label */
        let offset: CGFloat = 100.0
        let nameLabel = UILabel(frame: CGRect(x: offset - 25, y: 0, width: self.frame.width - offset, height: self.frame.height))
        nameLabel.text = country.name
        nameLabel.font = font
        nameLabel.numberOfLines = 0
        nameLabel.minimumScaleFactor = 0.5
        self.clipsToBounds = true
        self.addSubview(nameLabel)
        
        /** The Flag Indicator */
        let flagImageView = UIImageView(frame: CGRect(x: 30, y: 0, width: 30, height: self.frame.height))
        
        let frameworkBundle = Bundle(for: SwiftCountrySelector.self)
        let flagImage = UIImage(named: country.code.lowercased(), in: frameworkBundle, compatibleWith: nil)
        flagImageView.image = flagImage
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.layer.cornerRadius = 1.5
        flagImageView.layer.masksToBounds = true
        self.addSubview(flagImageView)
        
        /** The Phone Code Label */
        let codeLabel = UILabel(frame: CGRect(x: self.frame.width - offset, y: 0, width: offset - 25, height: self.frame.height))
        codeLabel.text = "+".appending(country.phoneCode)
        codeLabel.font = font
        codeLabel.textAlignment = .right
        self.clipsToBounds = true
        self.addSubview(codeLabel)
    }
}
