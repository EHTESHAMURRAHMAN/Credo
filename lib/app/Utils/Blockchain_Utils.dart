String normalizeCurrencySymbol(String currencySymbol) {
  if (currencySymbol == "USDC-BEP20") return "USDC";
  if (currencySymbol == "SHIB-BEP20") return "SHIB";
  if (currencySymbol == "PEPE-BEP20") return "PEPE";
  if (currencySymbol == "ENA-ERC20") return "ENA";
  if (currencySymbol == "XRP-BEP20") return "XRP";
  if (currencySymbol == "UNI-ERC20") return "UNI";
  if (currencySymbol == "DOGE-BEP20") return "DOGE";
  return currencySymbol;
}

final Map<String, String> contractAddresses = {
  "PEPE-BEP20": "0x25d887ce7a35172c62febfd67a1856f20faebb00",
  "USDC-BEP20": "0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d",
  "USDT-BEP20": "0x55d398326f99059ff775485246999027b3197955",
  "SHIB-BEP20": "0x285a1773c05bf4e5e0c2a1db222b35cd4ec71723",
  "DOGE-BEP20": "0xbA2aE424d960c26247Dd6c32edC70B295c744C43",
  "XRP-BEP20": "0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe",
  "ENA-ERC20": "0x57e114b691db790c35207b2e685d4a43181e6061",
  "UNI-ERC20": "0x1f9840a85d5af5bf1d1762f925bdaddc4201f984",
};

String getUrl(String currency) {
  switch (currency) {
    case "USDC-BEP20":
    case "USDT-BEP20":
    case "PEPE-BEP20":
    case "SHIB-BEP20":
    case "XRP-BEP20":
    case "DOGE-BEP20":
    case "BNB":
      return "https://bsc-dataseed1.binance.org:443";
    // return "https://bnb-mainnet.g.alchemy.com/v2/IurHULBkUc5ZL3l9dP_0c_99L9jScxVZ";
    case "ETH":
    case "ENA-ERC20":
    case "UNI-ERC20":
      return "https://eth-mainnet.g.alchemy.com/v2/8eCTFCFvF5YxdGmBo-qsQWqr--6w_mej";
    case "POL":
      return "https://polygon-amoy.drpc.org";
    //return "https://polygon-mainnet.g.alchemy.com/v2/RubNa_JtX5ItM_wdGB_pk5UK4AEU47Yv";
    case "RONIN":
      return "https://api.roninchain.com/rpc";
    default:
      return "";
  }
}
