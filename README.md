# TouchIDExample

[ING] - パスコードロックを利用した画面保護機能のあるアプリサンプル(機能としてTouchIDやFaceIDを利用)

### 実装機能一覧

お金やあまり他人に見られたくない情報を持つようなアプリで、画面のパスコードロック機能を実装したUIサンプルになります。また機能の一部としてTouchIDやFaceIDを利用してパスコードロックを解除できるような形にしています。

### 本サンプルの画面設計図

__1. サンプルのキャプチャ画像__

◉ その1:

![capture1.png](https://qiita-image-store.s3.amazonaws.com/0/17400/31ba315d-c354-8fe1-9a3b-1329660873ae.png)

◉ その2:

![capture2.png](https://qiita-image-store.s3.amazonaws.com/0/17400/f5cd0c43-5a65-0592-0fd9-0802e322564e.png)

__2. ユーザーの入力と連動して変化するView部品に関する設定:__

![passcode_ten_key.png](https://qiita-image-store.s3.amazonaws.com/0/17400/b8b52b35-b95e-1004-745e-e4e8fc2d786a.png)

![passcode_input_display.png](https://qiita-image-store.s3.amazonaws.com/0/17400/e8d90378-72bd-4b7a-879e-46e00feb3f78.png)

### 利用しているアーキテクチャと処理の関連性

このサンプル実装におけるアーキテクチャを絡めた処理のポイントとなる部分については、下図の示している部分になります。

__1. パスコードロック画面処理におけるView ⇄ Presenter ⇄ Modelの関連:__

![passcode_architecture.png](https://qiita-image-store.s3.amazonaws.com/0/17400/88ef71bb-5deb-de84-d196-227b6e1adc56.png)

__2. 画面機能を提供するViewControllerにおいて各種定義したProtocolと連動する処理に関する図解:__

![passcode_viewcontroller.png](https://qiita-image-store.s3.amazonaws.com/0/17400/f32a6bc5-c552-49e2-128e-1459550caf36.png)

__3. パスコードロック画面を表示する処理の概要図解:__

![passcode_lock_explain.png](https://qiita-image-store.s3.amazonaws.com/0/17400/edd62d71-c45d-da90-02f1-0fe21fe0389a.png)

### 補足として考慮しておくと良さそうな機能に関する考察

ここでは、実際のアプリ開発の際に機能として盛り込んでおくと更に良いものの例として、ユーザーがパスコードを忘れてしまった際の考慮に関するアイデアの一例を示しています。

![passcode_appendix.png](https://qiita-image-store.s3.amazonaws.com/0/17400/f9a8931c-6bda-5cd0-126d-034457390ac5.png)

### その他

このサンプル全体の詳細解説とポイントをまとめたものは下記に掲載しております。

(Qiita) https://qiita.com/fumiyasac@github/items/6124f9b272f5ee6ebb40

