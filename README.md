# SnapLearn | 線上學習平台

Snapask技術實作作業

## 主要要求功能：

- 使用者系統
- 課程CRUD ( for admin )
  - 可設定客製化url
  - 可設定有效期
  - 可設定主題，價格及幣別
  - 可設定上架/下架狀態
- 購買課程 ( BE API built with Grape & Gape Entity gem )
  - 如果使用者已經購買課程並且還有效，不讓使用者購買
  - 如果使用者欲購買已下架課程，不讓使用者購買
- 查詢已購買的課程 ( BE API built with Grape & Gape Entity gem )
- 篩選已購買的課程 by 課程主題 or 課程效期 ( BE API built with Grape & Gape Entity gem )

註：因為時間緊迫，因此沒有寫加分題：Rspec & 部署

# Implementation介紹：

## 1.使用者系統<br/>

由於開發環境與Devise Gem衝突，因此我自行開發了使用者系統，其中也包含：
- 使用者身份驗證方法（ 用來authenticate page actions access OR view template customization )
- 使用者密碼加密（ SHA1 )
- 使用者session
- 使用者API access token in cookie


![Screenshot 2022-02-16 at 17 50 23](https://user-images.githubusercontent.com/86815575/154241662-d8503414-7e0b-42a5-ab4f-f191a36908fa.png)

當使用者為admin, header有管理按鈕，提供admin去針對課程做管理 ( course creator; 註冊時勾選 )
![Screenshot 2022-02-16 at 17 50 51](https://user-images.githubusercontent.com/86815575/154241706-735406a8-5bee-4efc-912f-38ea080cb6b7.png)

當使用者為非admin, header沒有管理按鈕 ( course creator; 註冊時勾選 )
![Screenshot 2022-02-16 at 17 51 12](https://user-images.githubusercontent.com/86815575/154241727-9df8f5cd-1746-4da0-94cd-0ac8fb6236c4.png)

## 2.課程CRUD<br/>

- 課程CRUD只開放給course creator的admin身份使用者來使用，有使用前面提到的user authentication方法去防止使用者擅自access
- 針對課程“類型”的部分，前端的部分我目前只開放下拉單選選單，但考慮到scalability, 我目前是做成多對多的關聯( course > < category )，讓產品未來在時間允許下可以擴充
- 課程客製化url的部分，使用了Friendly_id套件
- 當非登入使用者access到course edit / new / management 頁面，都會先被redirect to login page

管理頁面可以一覽所有該使用者創建的課程
![Screenshot 2022-02-16 at 17 52 34](https://user-images.githubusercontent.com/86815575/154243077-10c691bc-f6d1-48fe-816e-cefa092c26a0.png)

課程編輯/創建表單頁
![Screenshot 2022-02-16 at 17 52 43](https://user-images.githubusercontent.com/86815575/154243137-71a9ede0-b2bd-4b56-a756-bfd02237c430.png)

所有公開的(上架的）課程皆會在/courses頁面被呈現給使用者（登入/登出使用者皆可access)
![Screenshot 2022-02-16 at 17 52 09](https://user-images.githubusercontent.com/86815575/154243383-306a0551-c4d5-4d84-9b57-4324aab80cac.png)

單一課程的show頁面
![Screenshot 2022-02-16 at 17 51 39](https://user-images.githubusercontent.com/86815575/154243541-b358152a-6c53-4f18-b63f-bc5aabdaa57e.png)

當使用者剛好是該課程的creator, 也會直接在單一課程頁面直接給予刪除＆更新按鈕
![Screenshot 2022-02-16 at 17 52 59](https://user-images.githubusercontent.com/86815575/154243607-815b602c-d53a-48e3-b810-adcf4b901865.png)

## 2.購買課程<br/>

- 準備了一個purchase的頁面，購買按鈕click事件會觸發calling API ( built with Grape & Gape Entity gem )
- 當非登入使用者要進入此頁時，會先被redirect to log in頁面
- Populate使用者資料到表單
- 註：這邊因為沒有接金流，因此我也沒有設定前端form驗證，就可以直接按下購買鈕
- API邏輯有防止使用者購買同一個課程（有效期內）或者已下架課程，API擋下之後回傳給client side, 然後展示錯誤提示給使用者
- 成功購買之後，會到ordersuccess頁面（這邊我沒有仔細去style the page)

購買頁面
![Screenshot 2022-02-16 at 17 51 58](https://user-images.githubusercontent.com/86815575/154244794-6ccc829c-ebc7-42ad-9797-62aea9e0aeba.png)

重複購買提示
![Screenshot 2022-02-16 at 18 20 54](https://user-images.githubusercontent.com/86815575/154244825-f4702b13-c0c3-4f7c-b377-43e2e0ccd8ef.png)

購買loader
![Screenshot 2022-02-16 at 18 21 12](https://user-images.githubusercontent.com/86815575/154244862-b409656c-de5d-4866-b485-5fe270e867a4.png)

## 3.已購買的課程查詢&篩選<br/>

- 準備了一個mycourses的頁面，當page load會自動去call API endpoint ( built with Grape & Gape Entity gem)，展示”所有“已購入課程
- 篩選按鈕click事件會觸發calling API ( built with Grape & Gape Entity gem )
- 顯示基本課程資訊＆付款資訊
- 篩選功能可以使用效期or主題來進行篩選，可擇其一使用或者兩者並用
- 如果不勾選任何篩選filter就送出表單，顯示使用者

![Screenshot 2022-02-16 at 17 51 23](https://user-images.githubusercontent.com/86815575/154246217-a9f4bd75-184f-4439-90bd-aa5add111871.png)
![Screenshot 2022-02-16 at 18 40 28](https://user-images.githubusercontent.com/86815575/154248826-e363be3d-d767-45b2-85a9-c0fb7d80e579.png)

