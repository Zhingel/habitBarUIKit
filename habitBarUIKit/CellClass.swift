//
//  CellClassCollectionViewCell.swift
//  habitBarUIKit
//
//  Created by Стас Жингель on 22.08.2021.
//

import UIKit

class CellClass: UICollectionViewCell {
    weak var textLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate ([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        textLabel = label
        textLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FirstCell: UICollectionViewCell {
    
}
