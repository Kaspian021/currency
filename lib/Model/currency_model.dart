



class CurrencyModel {

  String? id;
  double? athChangePercentage;
  num? currentPrice;
  String? image;

  CurrencyModel({
    required this.id,
    required this.athChangePercentage,
    required this.currentPrice,
    required this.image,
    
  });

  CurrencyModel.fromJson(Map<dynamic,dynamic>element){

    id=element['id'];
    athChangePercentage=element['price_change_percentage_24h'];
    currentPrice=element['current_price'];
    image=element['image'];
  }
  

}

  List currencyAll = [
    "algorand",
    "bitcoin",
    "ethereum",
    "binancecoin",
    "solana",
    "ripple",
    "dogecoin",
    "cardano",
    "avalanche-2",
    "shiba-inu",
    "polkadot",
    "litecoin",
    "matic-network",
    // "uniswap",
    // "chainlink",
    // "cosmos",
    // "monero",
    // "ethereum-classic",
    // "stellar",
    // "internet-computer",
    
  ];