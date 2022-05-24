# Smart-Contracts
Smart Contracts, alıcı ve satıcı arasındaki sözleşmenin şartlarının doğrudan kod satırlarına yazıldığı, kendi kendini yürüten bir sözleşmedir. Kod ve içerdiği anlaşmalar, dağıtılmış, merkezi olmayan bir blok zinciri ağında bulunur. Kod, yürütmesi kontrol edilebilir, işlemler izlenebilir ve geri alınamaz..

#### İlk Smart-Contracts yazalım

1-) [Remix Ide'ye](https://remix.ethereum.org/) gidin ve [AssociateProfitSplitter.sol](linkgir.org) kodunu kullanarak yeni bir sözleşme oluşturuyoruz.

![alt text](/assets/1.png "1. adım")

2-) Sözleşmemizin testlerini yapmak için, [Ganache](https://www.trufflesuite.com/ganache) kullanacağız. Kurulumu yaptıktan sonra karşımıza aşağıdaki gibi bir ekran gelecektir.

![alt text](/assets/2.png "Ganache açılış ekranı")

QUICKSTART diyerek başlayabiliriz...

Daha sonra sol üstten ayarlar -> server diyerek port ayarımızı 8545 olarak düzenliyoruz. Geri gelerek yapılan işlemleri kaydediyoruz. 

![alt text](/assets/3.png "Port değiştirme")

Ganache işlemlerini yaptıktan sonra bu hesabımızı metamask üzerine aktarmamız gerekiyor.

<img src="/assets/4.png" width="150" height="250">
<img src="/assets/5.png" width="150" height="250">
<img src="/assets/6.png" width="150" height="250"> 

Metamask işlemleri yukarıda gösterilen fotoğraflardaki gibidir. Öncelikle localhosttaki ağ seçilir daha sonra hesap içe aktarılır.

<img src="/assets/7.png" width="600" height="250">
<img src="/assets/8.png" width="600" height="250">

Hesabı içe aktarmak için yukarıda kullanılan private key kullanılmalıdır.

<img src="/assets/9.png" width="150" height="250">
<img src="/assets/10.png" width="150" height="250">

Kopyalanan private key ile hesap içeri aktarılmalıdır.

3-) Proje compile edilme aşamasına geldik. Soldaki menüden yazılan ilk contracts compile edilmelidir. Bu işlemde kodda hata olup olmadığı işlemi yapılır. Deploy işlemleri bir sonraki aşamada yapılacaktır.

<img src="/assets/11.png" width="600" height="250">

4-) Deploy için ENVIRONMENT kısmı aşağıdaki gibi yapılmalıdır. Metamask bağlanmak için web3 kullanmamız gerekmektedir. Bunun için Injected web3 seçiyoruz. Hesabımız otomatik olarak account kısmına eklenecektir.


<img src="/assets/12.png" width="300" height="250">


5-) Deploy edilecek hesaplar Ganache üzerinden alınarak buraya public adresleri yapıştırılmalıdır. Daha sonra transact işlemi gerçekleştirilebilir.

<img src="/assets/13.png" width="600" height="250">

6-) Transact işlemi onaylanınca yazılan contract deploy aşaması tamamlanmıştır. Artık sözleşme blockchain zincirine eklendi. Bu işlem artık geri alınamaz ve sonuçları sadece izin verilen kullanıcılara gösterilir.

Sonuç: Contract artık oluşturuldu. Deposit yaparak girilen value değeri public adresi girilen kullanıcılara bölüştürülür ve gönderilir. Gönderme sırasında kullanılan enerji ve maliyet kesintileri de olmaktadır.

<img src="/assets/15.png" width="500" height="250">
