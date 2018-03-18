//
//  FeedTableViewCell.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class FeedTableViewCell: UITableViewCell {

    private struct Constants {
        static let defaultImageWidth: CGFloat = 83.5
    }

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!

    public override func awakeFromNib() {
        super.awakeFromNib()

        resetValues()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        resetValues()
    }

    func layout(with display: FeedTableCellDisplay) {
        nameLabel.text = display.author
        titleLabel.text = display.title
        dateLabel.text = display.entryDate
        commentsLabel.text = display.comments

        if let url = display.thumbnailUrl {
            postImageView.loadImageFrom(url: url)
        } else {
            imageViewWidthConstraint.constant = 0
        }
    }

    private func resetValues() {
        nameLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        commentsLabel.text = nil
        postImageView.image = nil
        imageViewWidthConstraint.constant = Constants.defaultImageWidth
    }

}
