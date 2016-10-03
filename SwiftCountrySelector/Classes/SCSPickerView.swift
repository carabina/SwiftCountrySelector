//
//  SCSPickerView.swift
//  Pods
//
//  Created by Gregg Luskin on 10/3/16.
//
//

import Foundation
import UIKit

public class SCSPickerView: UIPickerView {
    
    /** The country code dictionary */
    var countryCodes: Dictionary<String,String> = Dictionary<String,String>()
    
    /** All Countries */
    var countries: [Country] = []
    
    /** The font to be displayed */
    var font: UIFont?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /** Connects up the delegate and data source */
    private func connect() {
        
        /** Set the datasource & delegate */
        self.delegate = self
        self.dataSource = self
    }
    
    public func setup() {
        
        /** Ensure that we can cread the plist file */
        let frameworkBundle = Bundle(for: SwiftCountrySelector.self)
        guard let plistPath = frameworkBundle.path(forResource: "DialingCodes", ofType: "plist") else {
            print("[SwiftCountrySelector]: ERROR - Couldn't locate DialingCodes plist")
            //throw SwiftyCountryPickerError.missingDialingCodes
            return
        }
        
        /** Ensure that we can parse into xml */
        guard let plistXML = FileManager.default.contents(atPath: plistPath) else {
            print("[SwiftCountrySelector]: ERROR - Couldn't xml parse DialingCodes plist")
            //throw SwiftyCountryPickerError.missingDialingCodes
            return
        }
        
        do {
            var format = PropertyListSerialization.PropertyListFormat.xml
            guard let plistData = try PropertyListSerialization.propertyList(from: plistXML, options: PropertyListSerialization.ReadOptions.mutableContainersAndLeaves, format: &format) as? [String:String] else {
                //throw SwiftyCountryPickerError.missingDialingCodes
                print("[SwiftCountrySelector]: ERROR - Couldn't get data from xml parsed DialingCodes plist")
                return
            }
            
            /** Store the country codes */
            self.countryCodes = plistData
            self.connect()
            self.createData()
        } catch {
            print("[SwiftCountrySelector]: ERROR - Couldn't get data from xml parsed DialingCodes plist")
            //throw SwiftyCountryPickerError.missingDialingCodes
            return
        }
    }
    
    /** Generate the data */
    private func createData() {
        for code in Locale.isoRegionCodes {
            guard let countryName = (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: code) else { continue }
            guard let phoneCode: String = self.countryCodes[code.lowercased()] else { continue }
            self.countries.append(Country(name: countryName, code: code, phoneCode: phoneCode))
        }
        self.countries.sort(by: { $0.name.characters.first ?? "A" < $1.name.characters.first ?? "Z" })
        self.reloadAllComponents()
    }
}

extension SCSPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countries[row].name
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return standardPickerView(reuseView: view, country: self.countries[row])
    }
    
    /** Standard Country View */
    private func standardPickerView(reuseView: UIView?, country: Country) -> UIView {
        var view: SCSDefaultPickerView!
        if reuseView == nil {
            view = SCSDefaultPickerView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 20))
        }
        view.setup(country: country)
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        return view
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //countryPicker.countryPickerDelegate?.swiftCountryPicker(didSelectCountry: self.countryPicker.countries[row])
    }
}

extension SCSPickerView: UIPickerViewDataSource {

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countries.count
    }
}
