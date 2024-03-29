env NEAR_ENV=testnet

[[ -z "$1" ]] && echo "Expected syntax: $0 YOUR_TESTNET_ACCOUNT_ID" >&2 && exit 1

TIME=`date +%s`
END_TIME=`expr $TIME`
BEGIN_TIME=`expr $END_TIME - 300`
SOURCES="[{ \"source_path\": \"0.close\", \"end_point\": \"https://api.coinpaprika.com/v1/coins/btc-bitcoin/ohlcv/historical?start=$BEGIN_TIME&end=$TIME\" }, { \"end_point\": \"https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=usd&from=$BEGIN_TIME&to=$TIME\", \"source_path\": \"prices[\$\$last][1]\" }]"
JSON="{\"sources\": $SOURCES,\"tags\":[\"1\"],\"description\":\"What is the price of BTC?\",\"challenge_period\":\"120000000000\",\"settlement_time\":\"1\",\"data_type\":{\"Number\":\"10000000000\"},\"creator\":\"your_account_id.flux-dev\"}"
env NEAR_ENV=testnet near call $1 create_data_request "{\"amount\": \"1000000000000000000000000\", \"payload\": $JSON}" --accountId $1 --amount 0.000000000000000000000001 --gas=300000000000000