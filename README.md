# アプリケーション概要
### Solidusを利用したECサイトへの機能追加

## 本番環境のURL
[トップページ](https://potepanec-20220320141934.herokuapp.com/potepan)  
[商品詳細ページ](https://potepanec-20220320141934.herokuapp.com/potepan/products/1)  
[カテゴリー別商品一覧ページ](https://potepanec-20220320141934.herokuapp.com/potepan/categories/1)  

## 実装内容
・テンプレート（views/potepan/sample）を元に、商品詳細ページとカテゴリー別商品一覧ページを実装  
・実装したページの共通化、部品化、動的表示化  
・商品詳細ページの関連商品表示機能  
・カテゴリー別商品一覧ページの商品カテゴリーサイドバー動的表示とリンク  

## ポイント
・Docker環境下での開発  
・リンターにRubocopを使用  
・Rspecを利用したテストの実装  
・CircleCIでRubocopとRspecをチェックし、Herokuへ自動デプロイ  
・N＋1問題への対応  
