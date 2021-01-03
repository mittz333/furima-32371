# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| email            | string | null: false |
| password         | string | null: false |
| nickname         | string | null: false |
| family_name      | string | null: false |
| last_name        | string | null: false |
| family_name_kana | string | null: false |
| last_name_kana   | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :purchases
- has_many :comments

## items テーブル

| column             | Type        | Options                   |  
|--------------------|-------------|---------------------------|
| title              | string      | null: false               |  
| detail             | text        | null: false               |  
| category           | integer     | null: false               |
| condition          | integer     | null: false               |
| shipping_charge    | integer     | null: false               |
| shipping_from_pref | integer     | null: false               |
| shipping_days      | integer     | null: false               |
| price              | decimal     | null: false               |
| commision          | decimal     | null: false               |
| profit             | decimal     | null: false               |
| user               | references  | null: false, foreign_key  |
| sold_flag          | boolean     |                           |

### Association

- belongs_to :user
- has_one :purchase
- has_many :comments

## purchases テーブル

| column             | Type        | Options                   |  
|--------------------|-------------|---------------------------|
| item               | references  | null: false, foreign_key  |  
| zipcode            | string      | null: false               |  
| prefecture         | integer     | null: false               |
| city               | string      | null: false               |
| street_number      | string      | null: false               |
| building           | string      |                           |
| tel                | string      | null: false               |
| user               | references  | null: false, foreign_key  |


### Association

- belongs_to :user
- belongs_to :item


## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
