//
//  PasscodeViewController.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/16.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import UIKit
import AudioToolbox

class PasscodeViewController: UIViewController {

    // 画面遷移前に引き渡す変数
    private var inputPasscodeType: InputPasscodeType!
    private var presenter: PasscodePresenter!

    private var userInputPasscode: String = ""

    @IBOutlet weak private var inputPasscodeDisplayView: InputPasscodeDisplayView!
    @IBOutlet weak private var inputPasscodeKeyboardView: InputPasscodeKeyboardView!
    @IBOutlet weak private var inputPasscodeMessageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
        setupUserInterface()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        hideTabBarItems()
    }

    // MARK: - Function

    func setTargetPresenter(_ presenter: PasscodePresenter) {
        self.presenter = presenter
    }

    func setTargetInputPasscodeType(_ inputPasscodeType: InputPasscodeType) {
        self.inputPasscodeType = inputPasscodeType
    }

    // MARK: - Private Function

    private func setupUserInterface() {
        setupNavigationItems()
        setupInputPasscodeMessageLabel()
        setupPasscodeNumberKeyboardView()
    }

    private func setupNavigationItems() {
        setupNavigationBarTitle(inputPasscodeType.getTitle())
        removeBackButtonText()
    }

    private func setupInputPasscodeMessageLabel() {
        inputPasscodeMessageLabel.text = inputPasscodeType.getMessage()
    }

    private func setupPasscodeNumberKeyboardView() {
        inputPasscodeKeyboardView.delegate = self

        // MEMO: 利用している端末のFaceIDやTouchIDの状況やどの画面で利用しているか見てボタン状態を判断する
        var isEnabledLocalAuthenticationButton: Bool = false
        if inputPasscodeType == .displayPasscodeLock {
            isEnabledLocalAuthenticationButton = LocalAuthenticationManager.getDeviceOwnerLocalAuthenticationType() != .authWithManual
        }
        inputPasscodeKeyboardView.shouldEnabledLocalAuthenticationButton(isEnabledLocalAuthenticationButton)
    }

    private func hideTabBarItems() {
        if let tabBarVC = self.tabBarController {
            tabBarVC.tabBar.isHidden = true
        }
    }

    private func acceptUserInteraction() {
        self.view.isUserInteractionEnabled = true
    }

    private func refuseUserInteraction() {
        self.view.isUserInteractionEnabled = false
    }

    // 最初の処理Aを実行 → 指定秒数後に次の処理Bを実行するためのラッパー
    // MEMO: 早すぎる入力を行なった際に意図しない画面遷移を実行される現象の対応策として実行している
    private func executeSeriesAction(firstAction: (() -> ())? = nil, deleyedAction: @escaping (() -> ())) {
        // 最初は該当画面のUserInteractionを受け付けない
        self.refuseUserInteraction()
        firstAction?()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            // 指定秒数経過後は該当画面のUserInteractionを受け付ける
            self.acceptUserInteraction()
            deleyedAction()
        }
    }
}

// MARK: - PasscodeNumberKeyboardDelegate

extension PasscodeViewController: InputPasscodeKeyboardDelegate {

    func inputPasscodeNumber(_ numberOfString: String) {

        // パスコードが0から3文字の場合はキーボードの押下された数値の文字列を末尾に追加する
        if 0...3 ~= userInputPasscode.count {
            userInputPasscode = userInputPasscode + numberOfString
            inputPasscodeDisplayView.incrementDisplayImagesBy(passcodeStringCount: userInputPasscode.count)
        }

        // パスコードが4文字の場合は入力完了処理を実行する
        if userInputPasscode.count == AppConstant.PASSCODE_LENGTH {
            presenter.inputCompleted(userInputPasscode, inputPasscodeType: inputPasscodeType)
        }
    }

    func deletePasscodeNumber() {

        // パスコードが1から3文字の場合は数値の文字列の末尾を削除する
        if 1...3 ~= userInputPasscode.count {
            userInputPasscode = String(userInputPasscode.prefix(userInputPasscode.count - 1))
            inputPasscodeDisplayView.decrementDisplayImagesBy(passcodeStringCount: userInputPasscode.count)
        }
    }

    func executeLocalAuthentication() {
        guard inputPasscodeType == .displayPasscodeLock else {
            return
        }

        LocalAuthenticationManager.evaluateDeviceOwnerLocalAuthentication(successHandler: {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }, errorHandler: {
            
        })
    }
}

// MARK: - PasscodePresenterProtocol

extension PasscodeViewController: PasscodePresenterDelegate {

    func goNext() {
        executeSeriesAction(
            firstAction: {},
            deleyedAction: {
                // Enum経由で次のアクションで設定すべきEnumの値を取得する
                guard let nextInputPasscodeType = self.inputPasscodeType.getNextInputPasscodeType() else {
                    return
                }
                // 遷移先のViewControllerに関する設定をする
                let sb = UIStoryboard(name: "Passcode", bundle: nil)
                let vc = sb.instantiateInitialViewController() as! PasscodeViewController
                vc.setTargetInputPasscodeType(nextInputPasscodeType)
                vc.setTargetPresenter(PasscodePresenter(previousPasscode: self.userInputPasscode))
                self.navigationController?.pushViewController(vc, animated: true)

                
                self.userInputPasscode.removeAll()
                self.inputPasscodeDisplayView.decrementDisplayImagesBy()
            }
        )
    }

    func dismissPasscodeLock() {
        executeSeriesAction(
            firstAction: {},
            deleyedAction: {
                self.dismiss(animated: true, completion: nil)
            }
        )
    }

    func savePasscode() {
        executeSeriesAction(
            firstAction: {},
            deleyedAction: {
                self.navigationController?.popToRootViewController(animated: true)
            }
        )
    }

    func showError() {
        executeSeriesAction(
            // 実行直後はエラーメッセージを表示する & バイブレーションを適用する
            firstAction: {
                self.inputPasscodeMessageLabel.text = "パスコードが一致しませんでした"
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            },
            // 秒数経過後にユーザーが入力したメッセージを空にする & パスコードのハート表示をリセットする
            deleyedAction: {
                self.userInputPasscode.removeAll()
                self.inputPasscodeDisplayView.decrementDisplayImagesBy()
            }
        )
    }
}
