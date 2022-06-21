//
//  Extensions.swift
//  UI Elements
//
//  Created by arun-13930 on 20/06/22.
//

import UIKit

extension UIView
{
    convenience init(_ forAutoLayout: Bool)
    {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = !forAutoLayout
    }
    
    func enableAutoLayout()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIColor
{
    func getRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat)
    {
        var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red, green, blue)
    }
}
