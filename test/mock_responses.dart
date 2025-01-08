import 'dart:convert';

double mockedExchangeRate = 65.005;

dynamic mockedRequestResponse = jsonEncode({
  "data": {
    "byPrice": {
      "offerId": "1845eb11-08aa-4103-9277-abcfc30306e9",
      "user": {
        "id": "a8d3d448-0fd1-483e-ac7e-362a95d29608",
        "username": "balatrader"
      },
      "offerStatus": 1,
      "offerType": 0,
      "createdAt": "2025-01-05T22:48:35.670Z",
      "description": "Activo",
      "cryptoCurrencyId": "TATUM-TRON-USDT",
      "fiatCurrencyId": "VES",
      "maxLimit": "65544",
      "minLimit": "650",
      "marketSize": "103200",
      "availableSize": "65544.42083185364887612645",
      "limits": {
        "crypto": {
          "maxLimit": "1012.2240073840473809707",
          "minLimit": "10.48923082839781555265",
          "marketSize": "1593.76171063764325821091",
          "availableSize": "1012.23050647023887557486"
        },
        "fiat": {
          "maxLimit": "65544",
          "minLimit": "650",
          "marketSize": "103200",
          "availableSize": "65544.42083185364887612645"
        }
      },
      "isDepleted": false,
      "fiatToCryptoExchangeRate": mockedExchangeRate.toString(),
      "offerMakerStats": {
        "userId": "a8d3d448-0fd1-483e-ac7e-362a95d29608",
        "rating": 5,
        "userRating": 5,
        "releaseTime": 0.91305,
        "payTime": 1.05545,
        "responseTime": 1.00565,
        "totalOffersCount": 66,
        "totalTransactionCount": 1417,
        "marketMakerTransactionCount": 585,
        "marketTakerTransactionCount": 832,
        "mmScore": {"score": 0.7496512269860933, "version": "v1"}
      },
      "paymentMethods": ["bank_venezuela"],
      "usdRate": "1",
      "paused": false,
      "user_status": "OFFLINE",
      "user_lastSeen": "47",
      "display": true,
      "visibility": "PUBLIC",
      "paymentMethodFilter": [],
      "orderRequestEnabled": true
    },
    "bySpeed": {
      "offerId": "199bc73c-d22c-4c18-b0e6-549dd6ad2f35",
      "user": {
        "id": "ff812f6e-bbcf-4ea4-b6a7-529c75f5f588",
        "username": "tikicdo"
      },
      "offerStatus": 1,
      "offerType": 0,
      "createdAt": "2025-01-06T00:12:55.550Z",
      "description": " sí estoy en línea pago de inmediato",
      "cryptoCurrencyId": "TATUM-TRON-USDT",
      "fiatCurrencyId": "VES",
      "maxLimit": "28624.4887879087227106591",
      "minLimit": "2000",
      "marketSize": "43400",
      "availableSize": "28624.4887879087227106591",
      "limits": {
        "crypto": {
          "maxLimit": "446.45360968199257244007",
          "minLimit": "31.37803088803088803089",
          "marketSize": "676.90594594594594594595",
          "availableSize": "446.45360968199257244007"
        },
        "fiat": {
          "maxLimit": "28624.4887879087227106591",
          "minLimit": "2000",
          "marketSize": "43400",
          "availableSize": "28624.4887879087227106591"
        }
      },
      "isDepleted": false,
      "fiatToCryptoExchangeRate": "64.75",
      "offerMakerStats": {
        "userId": "ff812f6e-bbcf-4ea4-b6a7-529c75f5f588",
        "rating": 5,
        "userRating": 5,
        "releaseTime": 0.21731666666666666,
        "payTime": 0.8500333333333333,
        "responseTime": 0.74545,
        "totalOffersCount": 290,
        "totalTransactionCount": 759,
        "marketMakerTransactionCount": 734,
        "marketTakerTransactionCount": 25,
        "mmScore": {"score": 0.749882995618478, "version": "v1"}
      },
      "paymentMethods": ["app_pago_movil", "bank_venezuela"],
      "usdRate": "1",
      "paused": false,
      "user_status": "ONLINE",
      "user_lastSeen": "6",
      "display": true,
      "visibility": "PUBLIC",
      "paymentMethodFilter": [],
      "orderRequestEnabled": true
    },
    "byReputation": {
      "offerId": "e67486d8-0ccd-4424-84c2-8ea7e521ec47",
      "user": {
        "id": "1cff240f-b710-4927-bc6d-75ca91ff7d07",
        "username": "kelvin22e"
      },
      "offerStatus": 1,
      "offerType": 0,
      "createdAt": "2025-01-05T14:49:47.963Z",
      "description": "Mantengase en linea transfiero rapido",
      "cryptoCurrencyId": "TATUM-TRON-USDT",
      "fiatCurrencyId": "VES",
      "maxLimit": "59602.45513207304809717312",
      "minLimit": "2500",
      "marketSize": "390000",
      "availableSize": "59602.45513207304809717312",
      "limits": {
        "crypto": {
          "maxLimit": "933.21735562605536857884",
          "minLimit": "39.24968992248062015504",
          "marketSize": "6070.09302325581395348838",
          "availableSize": "933.21735562605536857884"
        },
        "fiat": {
          "maxLimit": "59602.45513207304809717312",
          "minLimit": "2500",
          "marketSize": "390000",
          "availableSize": "59602.45513207304809717312"
        }
      },
      "isDepleted": false,
      "fiatToCryptoExchangeRate": "64.5",
      "offerMakerStats": {
        "userId": "1cff240f-b710-4927-bc6d-75ca91ff7d07",
        "rating": 5,
        "userRating": 5,
        "releaseTime": 1.4547916666666667,
        "payTime": 2.421375,
        "responseTime": 2.011216666666667,
        "totalOffersCount": 3343,
        "totalTransactionCount": 17252,
        "marketMakerTransactionCount": 17032,
        "marketTakerTransactionCount": 220,
        "mmScore": {"score": 0.9717816286711749, "version": "v1"}
      },
      "paymentMethods": [
        "app_pago_movil",
        "bank_bancamiga",
        "bank_bancaribe",
        "bank_banesco",
        "bank_bnc",
        "bank_mercantil",
        "bank_provincial",
        "bank_tx_ve",
        "bank_venezuela"
      ],
      "usdRate": "1",
      "paused": false,
      "user_status": "AWAY",
      "user_lastSeen": "11",
      "display": true,
      "visibility": "PUBLIC",
      "paymentMethodFilter": [],
      "orderRequestEnabled": false
    }
  }
});
