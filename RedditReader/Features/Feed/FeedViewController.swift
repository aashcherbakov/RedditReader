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
        static let rowHeight = 100 as CGFloat
    }

    var viewModel: FeedViewModel!
    var tableDataSource: FeedTableDataSource?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var paginationControl: PaginationControl!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
        setupEvents()
        viewModel.onStateChange = onStateChange
        viewModel.loadFeed()
    }

    private func onStateChange(state: FeedViewModel.State) {
        switch state {
        case .complete(let distance): moveToCompleteState(distance: distance)
        default: return
        }
    }

    private func setupEvents() {
        paginationControl.onNextButtonTap = onNextButtonTap
        paginationControl.onPreviousButtonTap = onPreviousButtonTap
    }

    private func setupDesign() {
        setupTableView()
        setupPaginationControlsView()
    }

    private func setupTableView() {
        tableDataSource = FeedTableDataSource(viewModel: viewModel)
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.dataSource = tableDataSource
        tableView.delegate = self
    }

    private func moveToCompleteState(distance: String) {
        tableView.reloadData()
        tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        paginationControl.layout(withPreviousHidden: viewModel.shouldDisplayPreviousButton())
        navigationItem.title = distance
    }

    private func setupPaginationControlsView() {
        paginationControl.layout(withPreviousHidden: true)
    }

    private func onNextButtonTap() {
        viewModel.loadNext()
    }

    private func onPreviousButtonTap() {
        viewModel.loadPrevious()
    }
}

extension FeedViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectDisplay(at: indexPath.row)
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

}
