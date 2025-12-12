# コミュニティ貢献ガイド

[English](guideline.md) | [中文](guideline.cn.md)

## npm_typed の拡充にご協力ください

[DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) が npm パッケージの TypeScript 型定義を提供しているように、このプロジェクトは npm エコシステム向けの MoonBit FFI バインディングを提供することを目指しています。

コミュニティからの貢献を歓迎します！お気に入りの npm パッケージのバインディングを追加したい方も、既存のバインディングを改善したい方も、このガイドが参考になれば幸いです。

## 誰が貢献できる？

**MoonBit の深い専門知識は必要ありません！** 以下があれば貢献できます：

- JavaScript/TypeScript の基本的な知識
- コードベース内の既存パターンを参考にする能力
- [MoonBit JS FFI ガイド](https://www.moonbitlang.com/pearls/moonbit-jsffi)を読む意欲

## はじめに

テンプレートジェネレーターを使って新しいライブラリを作成できます：

```bash
./_scripts/new-library.sh <package_name> [npm_package_name]

# 例
./_scripts/new-library.sh react
./_scripts/new-library.sh client_s3 @aws-sdk/client-s3
```

これで基本的なファイル構造が作成されます。詳細なセットアップ手順は [CONTRIBUTING.md](../CONTRIBUTING.md) を参照してください。

## AI を活用しよう

バインディング作成のペアプログラマーとして **AI ツール（Claude、GPT、Copilot など）の活用を推奨**しています。このリポジトリのバインディングのほとんどは AI の支援で生成されました。

**AI 支援開発のコツ：**

1. npm パッケージのドキュメントを AI に提供する
2. このリポジトリの既存バインディングをパターンとして共有する（例：[react/react.mbt](../react/react.mbt)）
3. `.mbt` ファイル、テスト、README の生成を AI に依頼する
4. 構文リファレンスとして [MoonBit チートシート](../_examples/moonbit_cheatsheet.mbt.md)を活用する

**プロンプト例：**

```
npm パッケージ「react」の MoonBit FFI バインディングを作成したいです。
既存バインディングのパターンはこちらです：[リポジトリから例を貼り付け]
以下を生成してください：
1. react.mbt - createElement、useState、useEffect の FFI バインディング
2. react_test.mbt - テスト
3. README.mbt.md - 実行可能な例を含むドキュメント
```

## 人間によるレビューが必須

AI 生成コードはマージ前に人間がレビュー・検証する必要があります：

- すべてのテストを実行する（`moon test --target js`）
- バインディングが期待通りに動作することを確認する
- 型安全性とエッジケースをチェックする
- README の例が正確であることを確認する

**すべての PR は品質確保のためメンテナーがレビューします。**

## 新しいライブラリをリクエストする方法

1. 重複リクエストがないか**既存の Issue を確認**する
2. `library-request` ラベルで **Issue を作成**する
3. 以下を含める：
   - npm パッケージ名
   - ドキュメントへのリンク
   - 最も必要な API
   - （任意）TypeScript での使用例

## 新しいライブラリを貢献する方法

1. 既存の Issue にコメントするか、重複を避けるため新しい Issue を作成する
2. `./_scripts/new-library.sh <package_name>` を実行してテンプレートファイルを生成する
3. 既存のパターンに従ってバインディングを実装する
4. バインディングを含む PR を提出する
5. レビューフィードバックに対応する

## 品質ガイドライン

**良いバインディングの条件：**

- 最もよく使われる API をカバーしている
- README.mbt.md に明確で実行可能な例がある
- テストがバインディングの正常動作を検証している
- 型シグネチャができるだけ具体的（適切な型を定義できる場合は `@core.Any` を避ける）

**許容される範囲：**

- npm パッケージの API を 100% カバーする必要はない
- 最も有用な 20% の関数から始める
- 完全にテストされていない場合は「AI Generated」とマークする
- 他の人が将来の PR でカバレッジを拡大できる

## PR チェックリスト

PR を提出する前に確認：

- [ ] `moon test --target js` がパスする
- [ ] `moon fmt` を実行した
- [ ] README.mbt.md に動作する例がある
- [ ] テストが主なユースケースをカバーしている
- [ ] ハードコードされた秘密情報や認証情報がない

## ヘルプを得る

- **質問がある？** [Discussion](https://github.com/mizchi/npm_typed/discussions) を開く
- **バグを見つけた？** [Issue](https://github.com/mizchi/npm_typed/issues) を開く
- **MoonBit の構文？** [チートシート](../_examples/moonbit_cheatsheet.mbt.md)を参照

## リソース

- [MoonBit JS FFI ベストプラクティス](https://www.moonbitlang.com/pearls/moonbit-jsffi)
- [MoonBit ドキュメント](https://www.moonbitlang.com/docs/)
