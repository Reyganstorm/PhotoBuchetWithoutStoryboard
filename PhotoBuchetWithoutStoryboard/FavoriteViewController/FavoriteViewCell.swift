//
//  FavoriteViewCell.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 08.06.2022.
//

import UIKit



class FavoriteViewCell: UITableViewCell {

    static let identifierID = "customTableCell"
    
    private lazy var image: PhotoImage = {
        let image = PhotoImage()
        image.layer.cornerRadius = 10
        image.backgroundColor = .gray
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Author Name"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        
        nameLabel.frame = CGRect(x: 20 + image.frame.width, y: 0, width: contentView.frame.width - image.frame.width - 20, height: contentView.frame.height - 20)
    }
    
    func configuration(photoElement: RealmObject) {
        image.fetch(from: photoElement.url)
        nameLabel.text = photoElement.name
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
    }
}



