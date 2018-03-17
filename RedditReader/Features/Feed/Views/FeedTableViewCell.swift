//
//  FeedTableViewCell.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    public override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        commentsLabel.text = nil
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        postImageView.image = nil
    }

    func layout(with display: FeedTableCellDisplay) {
        nameLabel.text = display.author
        titleLabel.text = display.title
        dateLabel.text = display.entryDate
        commentsLabel.text = display.comments
        postImageView.loadImageFrom(url: display.thumbnailUrl)
    }

}
