# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false              |
| nickname           | string | null: false              |
| last_name        | string | null: false              |
| first_name          | string | null: false              |
| last_name_kana   | string | null: false              |
| first_name_kana     | string | null: false              |
| birthday           | date   | null: false              |

### Association

- has_many :items
- has_many :purchases
- has_many :comments

## items テーブル

| column             | Type        | Options                   |  
|--------------------|-------------|---------------------------|
| title              | string      | null: false               |  
| detail             | text        | null: false               |  
| category_id        | integer     | null: false               |
| condition_id       | integer     | null: false               |
| shipping_charge_id | integer     | null: false               |
| prefecture_id      | integer     | null: false               |
| shipping_day_id   | integer     | null: false               |
| price              | integer     | null: false               |
| user               | references  | null: false, foreign_key  |

### Association

- belongs_to :user
- has_one :purchase
- has_many :comments


## purchases テーブル

| column             | Type        | Options                   |  
|--------------------|-------------|---------------------------|
| item               | references  | null: false, foreign_key  |  
| user               | references  | null: false, foreign_key  |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

| column             | Type        | Options                   |  
|--------------------|-------------|---------------------------|
| zipcode            | string      | null: false               |  
| prefecture_id      | integer     | null: false               |
| city               | string      | null: false               |
| street_number      | string      | null: false               |
| building           | string      |                           |
| tel                | string      | null: false               |
| purchase           | references  | null: false, foreign_key  |  

### Association

- belongs_to :purchase


## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
