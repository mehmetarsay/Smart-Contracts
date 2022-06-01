pragma solidity ^0.5.0;

// lvl 3: equity plan
contract DeferredEquityPlan {
    address human_resources;

    address payable employee; 
    bool active = true; 


    uint total_shares = 1000; //toplam hisse
    uint annual_distribution = 250; //4 yıl için 1000 hisse 
    
    uint fakenow = now;//test için

    uint start_time = fakenow;

    uint unlock_time = start_time + 365 days;

    uint public distributed_shares; 

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }
    function fastforward() public {
        fakenow += 366 days;
    }

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

    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "Bu contractı sonlandırma yetkiniz yok");
        active = false;
    }

    function() external payable {
        revert("Bu sözleşme ether ile çalışmaz");
    }
}