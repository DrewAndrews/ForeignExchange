//
//  MarginLabel.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 24.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit

class MarginLabel: UILabel {

    var topInset:       CGFloat = 0
    var rightInset:     CGFloat = 10
    var bottomInset:    CGFloat = 0
    var leftInset:      CGFloat = 0

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawText(in: rect.inset(by: insets))
    }
}
