#!/bin/bash
function sillyParser() {
	sNeedle="${1}"
	echo "${HTML}" | grep -A 1 'itemprop="'"${sNeedle}"'"' | tr -d '\n' | cut -d '"' -f 4
}

printf '\e[1m%-7s %-20.20s %-10s %-8s %s\e[m\n' "Symbol" "Name" "Price" "Currency" "Exchange"
for sSymbol in $@; do
	HTML=$(wget -qO - "http://www.google.com/finance?q=${sSymbol}")
	fPrice=$(sillyParser "price")
	sName=$(sillyParser "name")
	sExchange=$(sillyParser "exchange")
	sCurrency=$(sillyParser "priceCurrency")

	#echo "The current price of ${sName} (${1}) is ${fPrice}${sCurrency} on the ${sExchange}."
	printf '%-7s %-20.20s %-10s %-8s %s\n' "${sSymbol}" "${sName}" "${fPrice}" "${sCurrency}" "${sExchange}"
done
