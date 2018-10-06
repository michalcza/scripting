#!/bin/bash
fPrice=$(wget -qO - 'http://www.google.com/finance?q=tsla&ei=DMdNV4mVBqj3iwKWp4TACw' | grep -A 1 'itemprop="price"' | tr -d '\n' | cut -d '"' -f 4)
fName=$(wget -qO - 'http://www.google.com/finance?q=tsla&ei=DMdNV4mVBqj3iwKWp4TACw' | grep -A 1 'itemprop="name"' | tr -d '\n' | cut -d '"' -f 4)
fExchange=$(wget -qO - 'http://www.google.com/finance?q=tsla&ei=DMdNV4mVBqj3iwKWp4TACw' | grep -A 1 'itemprop="exchange"' | tr -d '\n' | cut -d '"' -f 4)
fCurrency=$(wget -qO - 'http://www.google.com/finance?q=tsla&ei=DMdNV4mVBqj3iwKWp4TACw' | grep -A 1 'itemprop="priceCurrency"' | tr -d '\n' | cut -d '"' -f 4)
echo "The current price of ${fName} is ${fPrice}."  
