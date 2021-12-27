# Stockbit iOS Submission

This project is made for Stockbit Online Test

## Description

The project is made using VIP design pattern and Starscream for subscribing with webscoket. When the user first enter the app, it fetches a list of 
50 highest ranked cryptocurrency from cryptocompare. It then takes each cryptocurrency's symbol and subscribe to it's price changes using websocket. 
Whenever the app gets a new price, 
it will find the coin's symbol and replace the coin's data with a new one
and update it's cell accordingly instead of reloading the whole tableview. The app calculates the coins price diferent using the 24 hour price.


If the user activate the pull to refresh, it will fetch a new list, cancel previous subscription and resubscribe from the current top 50 list. 
When the user tap a cell, it will use the selected coin symbol as a parameter to fetch related news. 

If I had more time to finish the project, I would implement a sorting feature to sort the coin list based on price trends.

## Dependencies

* Cocoapod
* Starscream
