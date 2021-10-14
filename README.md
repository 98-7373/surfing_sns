
# surfing_sns
サーファー専用SNS

## 機能

## 開発の進め方
GitHub Flowに沿って開発を行う  
参考（https://tracpath.com/bootcamp/learning_git_github_flow.html)  
[サロンの限定動画(レクチャーの方)](https://vimeo.com/showcase/7431597/video/441969458)にGitHubの使い方があるので、そちらを一度見ておくと分かりやすいと思います。  

- mainブランチからfeatureを開始する。
- ブランチの名前はfeature/#(issue番号)_わかりやすい名前
- featureブランチからmainブランチへは直接マージせず、プルリクエストを行う
- プルリクエストは誰かがレビューし、マージする

### 全体のタスク管理
[GitHub Project](https://github.com/kboyflutteruniv/couple_todo/projects/1)で管理しています。  
タスクを行う際は、Todoの中から選んで自分にassignしたのちに、Doingに移動して進めていってください  
- Hold　=> ドキュメントとして残しているissueや直近対応しないもの
- Todo => 誰も着手していないタスク
- Doing => 誰かが着手済みのタスク
- Reviewing => タスクが完了し、プルリクを出した状態で誰かがレビュー&マージするのを待っているタスク  
- Done => プルリクがマージされ完了したタスク  

一応、初心者向けのタスクには `4 : 初心者大歓迎 - good first issue`のタグをつけているので、選ぶ際の参考にしてください。  

### Issueの立て方
New Issueをクリックすると5つのテンプレートがあります(salon_appの丸パクリ)  
それぞれ使い方や例が書いてあるのでそれにならって記載してください。  
質問などもIssueで立てていただけるとありがたいです  


## 開発環境
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 2.2.3, on macOS 11.6 20G165 darwin-x64, locale ja-JP)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio (version 4.1)
[✓] Android Studio (version 4.1)
[✓] Connected device (1 available)



 [Firebaseプロジェクト](https://console.firebase.google.com/u/0/project/flutter-univ-surfing-sns/overview?hl=ja)
 [ワイヤーフレーム(デザイン)](https://www.figma.com/file/ovMlLUIaovCln5l5nT6j3A/%E3%82%B5%E3%83%BC%E3%83%95%E3%82%A1%E3%83%BC%E5%B0%82%E7%94%A8SNS?node-id=0%3A1)

