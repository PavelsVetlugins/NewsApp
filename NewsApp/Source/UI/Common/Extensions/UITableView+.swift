//
//  UITableView+.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 10/11/2021.
//

import Foundation
import UIKit

extension UITableView {

    public func registerNib(_ type: UITableViewCell.Type) {
        register(UINib(nibName: type.identifier, bundle: nil), forCellReuseIdentifier: type.identifier)
    }

    public func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }

    public func dequeueCell<CellType: UITableViewCell>(type: CellType.Type) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
}

extension UIView {
    open class var identifier: String {
        return String(describing: self)
    }
}
