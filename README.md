# Smart-Contracts
Smart Contracts, alıcı ve satıcı arasındaki sözleşmenin şartlarının doğrudan kod satırlarına yazıldığı, kendi kendini yürüten bir sözleşmedir. Kod ve içerdiği anlaşmalar, dağıtılmış, merkezi olmayan bir blok zinciri ağında bulunur. Kod, yürütmesi kontrol edilebilir, işlemler izlenebilir ve geri alınamaz..

#### SEVİYE-1 İlk Smart-Contracts yazalım

1-) [Remix Ide'ye](https://remix.ethereum.org/) gidin ve [AssociateProfitSplitter.sol](https://github.com/mehmetarsay/Smart-Contracts/blob/main/AssociateProfitSplitter.sol) kodunu kullanarak yeni bir sözleşme oluşturuyoruz. Oluşturacağımız bu sözleşme 3 ortak arasında ücretin eşit bir şekilde dağıtılmasını içerecek.

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

<img src="/assets/7.png" width="800" height="400">
<img src="/assets/8.png" width="800" height="400">

Hesabı içe aktarmak için yukarıda kullanılan private key kullanılmalıdır.

<img src="/assets/9.png" width="150" height="250">
<img src="/assets/10.png" width="150" height="250">

Kopyalanan private key ile hesap içeri aktarılmalıdır.

3-) Proje compile edilme aşamasına geldik. Soldaki menüden yazılan ilk contracts compile edilmelidir. Bu işlemde kodda hata olup olmadığı işlemi yapılır. Deploy işlemleri bir sonraki aşamada yapılacaktır.

<img src="/assets/11.png" width="600" height="250">

4-) Deploy için ENVIRONMENT kısmı aşağıdaki gibi yapılmalıdır. Metamask bağlanmak için web3 kullanmamız gerekmektedir. Bunun için Injected web3 seçiyoruz. Hesabımız otomatik olarak account kısmına eklenecektir.


<img src="/assets/12.png" width="300" height="250">


5-) Deploy edilecek hesaplar Ganache üzerinden alınarak buraya public adresleri yapıştırılmalıdır. Daha sonra transact işlemi gerçekleştirilebilir.

<img src="/assets/13.png" width="800" height="450">

6-) Transact işlemi onaylanınca yazılan contract deploy aşaması tamamlanmıştır. Artık sözleşme blockchain zincirine eklendi. Bu işlem artık geri alınamaz ve sonuçları sadece izin verilen kullanıcılara gösterilir.

Sonuç: Contract artık oluşturuldu. Deposit yaparak girilen value değeri public adresi girilen kullanıcılara bölüştürülür ve gönderilir. Gönderme sırasında kullanılan enerji ve maliyet kesintileri de olmaktadır.

<img src="/assets/15.png" width="500" height="250">


#### SEVİYE-2 Smart Contract Geliştirelim

Bu aşamada yapacağımız şey ilk kısımda gösterilen kodu biraz değiştirerek hesaplara farklı miktarlarda ücretler göndermek olacak.

[AssociateProfitSplitter.sol](https://github.com/mehmetarsay/Smart-Contracts/blob/main/AssociateProfitSplitter.sol) kodumuzda toplam tutar üçe bölünmüştü yeni yazacağımız deposit fonksiyonunda bu oran kişilere göre farklılık gösterecek.

Fonksiyonumuzu yazmaya başlayalım.

```
function deposit() public payable {
        uint points = msg.value / 100; 
        uint total;
        uint amount;

       amount = points * 50;
       total += amount;
       employee_one.transfer(amount);

       amount = points * 40;
       total += amount;
       employee_two.transfer(amount);


       amount = points * 10;
       total += amount;
       employee_three.transfer(amount);
       
       employee_one.transfer(msg.value - total);
    
    }
```

Fonksiyonumuzda görüldüğü üzere toplam tutar önce 100'e bölündü daha sonra alacakların yüzdelerine göre dağıtım işlemi gerçekleştirildi.

Örnek:
50 ETH 3 kişi arasında %50, %40 ve %10 oranlara dağıtılma işlemi aşağıda gerçekleştirilmiştir.

<img src="/assets/16.png" width="500" height="250">

<img src="/assets/17.png" width="500" height="250">

kodun detayına [TieredProfitSplitter.sol](/TieredProfitSplitter.sol) dosyasından bakabilirsiniz.

.


#### SEVİYE-3 Smart Contract Geliştirelim




Bu kısımda şirketler tarafından yıllara göre paylaşılmış hisse senetlerinin contract haline getirilip işlenmesini inceleyeceğiz. 

Kodlarımız [DeferredEquityPlan](/DeferredEquityPlan.sol) içinde bulunuyor buradan inceleyebilirsiniz.

Bu koddaki amacımız elimizdeki 1000 hisseyi her sene  250 olacak şekilde 4 yıl içinde dağıtmak. Başlangıç tarihini bu gün olarak belirliyoruz.

-> Test etmek için fastforwarf() fonksiyonununu zamanı hızlandırmak için kullanacağız. 

```

    function fastforward() public {
        fakenow += 366 days;
    }

```


-> Hisseleri dağıtma işlemi için distribute() fonksiyonunu çalıştıracağız.

```
...
    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "Bu contractı çalıştırma yetkiniz yok");
        require(active == true, "Contract not active.");

        require(unlock_time <=fakenow, "Hisseler daha kazanılmamış");

        require(distributed_shares < total_shares, "Tüm hisseler dağıtıldı.");

        unlock_time += 365 days;

        //Dağıtılan payları hesaplama
        distributed_shares = ((fakenow - start_time) / 365 days * annual_distribution);

        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }
    
    ...
    
```

-> distributed_shares ile anlık hisse değerimizi göreceğiz.

```
 uint public distributed_shares; 


```

İlk önce kodumuzu compile ediyoruz ve daha sonra metamask hesabını bağlıyoruz.Employe kısmına key giriyoruz.

<img src="/assets/18.png" width="500" height="250">

İlk baktığımızda hisselerimizn 0 olduğunu görürüz.

<img src="/assets/19.png" width="300" height="300">

Süre dolmadan distribute yaptığımızda hata vericektir. Çünkü hisseleri kazanmak için yeterli kadar çalışmadık.


<img src="/assets/20.png" width="500" height="250">

Bu işlemi hızlandırmak için fakenow yapıyoruz. Tekrar distribute çalıştırdığımızda ilk hisselerimizi almış olacağız.

<img src="/assets/21.png" width="300" height="300">

Fakenow 4 defa üst üste çalıştırınca 4 yıl yapacağından artık bütün hisseleri alabiliriz.

<img src="/assets/22.png" width="300" height="300">




Not: Bu yazının bazı kısımları [Corey-Recai](https://github.com/Corey-Recai/smart-contracts-with-solidity-homework) hesabından alınmıştır.
