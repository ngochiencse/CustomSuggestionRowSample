//
//  SuggestionTableViewCellCustom.swift
//  SuggestionRowExemple
//
//  Created by Hien Pham on 1/19/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SnapKit
import SuggestionRow

protocol SuggestionHasCustomTableViewCell: class {
    var tableViewCellContentProvider: ViewProvider<SuggestionTableViewCellContentView>? { get set }
}

class SuggestionTableViewCellContentView: UIView {
    @IBOutlet weak var textLabel: UILabel?
}

open class SuggestionTableViewCellCustom<T: SuggestionValue>: SuggestionTableViewCell<T> {
    var bsContentView: SuggestionTableViewCellContentView?
    open override func setUp() {
        guard let row = parentCell?.baseRow as? SuggestionHasCustomTableViewCell else { return }
        bsContentView = row.tableViewCellContentProvider?.makeView()
        if let unwrapped = bsContentView {
            contentView.addSubview(unwrapped)
            unwrapped.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            textLabel?.removeFromSuperview()
        }
    }
    
    open override func setupForValue(_ value: T) {
        textLabel?.text = value.suggestionString
        textLabel?.isHidden = (bsContentView?.textLabel != nil)
        bsContentView?.textLabel?.text = value.suggestionString
    }
}
