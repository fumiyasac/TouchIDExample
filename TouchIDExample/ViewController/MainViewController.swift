//
//  MainViewController.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/08/29.
//  Copyright © 2018年 酒井文也. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak private var sampleCollectionView: UICollectionView!
    @IBOutlet weak private var inputDataButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUserInterface()
    }

    // MARK: - Private Function
    
    @objc private func inputDataButtonAction() {
        let sb = UIStoryboard(name: "Form", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

    private func setupUserInterface() {
        setupNavigationItems()
        setupSampleCollectionView()
        setupInputDataButton()
    }

    private func setupNavigationItems() {
        setupNavigationBarTitle("お買い物一覧")
    }

    private func setupSampleCollectionView() {
        sampleCollectionView.delegate = self
        sampleCollectionView.dataSource = self
        sampleCollectionView.registerCustomCell(SampleCollectionViewCell.self)
    }

    private func setupInputDataButton() {
        inputDataButton.addTarget(self, action: #selector(self.inputDataButtonAction), for: .touchUpInside)
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {

    // 配置するセルの個数を設定する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }

    // 配置するセルの表示内容を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: SampleCollectionViewCell.self, indexPath: indexPath)
        cell.setCellDecoration()
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SampleCollectionViewCell.getCellSize()
    }

    // セルの垂直方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SampleCollectionViewCell.cellMargin
    }

    // セルの水平方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SampleCollectionViewCell.cellMargin
    }

    // セル内のアイテム間の余白(margin)調整を行う
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin = SampleCollectionViewCell.cellMargin
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
