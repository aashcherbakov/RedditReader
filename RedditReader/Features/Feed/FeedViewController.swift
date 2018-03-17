//
//  FeedViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation
import UIKit

public class FeedViewController: BaseViewController {

    private struct Constants {
        static let rowHeight = 60 as CGFloat
    }

    var viewModel: FeedViewModel!
    var tableDataSource: FeedTableDataSource?

    @IBOutlet weak var tableView: UITableView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
        viewModel.onStateChange = onStateChange
        viewModel.loadFeed()
    }

    private func onStateChange(state: FeedViewModel.State) {
        switch state {
        case .complete:
            tableView.reloadData()
        default:
            return
        }
    }

    private func setupDesign() {
        tableDataSource = FeedTableDataSource(viewModel: viewModel)
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.dataSource = tableDataSource
    }
}

extension FeedViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectDisplay(at: indexPath.row)
    }

}
