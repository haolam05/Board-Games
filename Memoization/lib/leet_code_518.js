// Work through this problem on https://leetcode.com/problems/coin-change-2/ and use the specs given there.
// Feel free to use this file for scratch work.

/**
 * @param {number} amount
 * @param {number[]} coins
 * @return {number}
 */
var change = function (amount, coins, memo = {}) {
    let key = coins + '-' + amount
    if (key in memo) return memo[key]
    if (amount == 0) return 1

    let quantity = 0
    let currentCoin = coins[coins.length - 1]
    let total = 0
    
    while (quantity * currentCoin <= amount) {
        total += change(amount - quantity * currentCoin, coins.slice(0, -1), memo)

        quantity++
    }

    memo[key] = total
    return memo[key]
};

var change = function (amount, coins) {
    if (amount == 0) return 1

    let quantity = 0
    let currentCoin = coins[coins.length - 1]
    let total = 0

    while (quantity * currentCoin <= amount) {
        total += change(amount - quantity * currentCoin, coins.slice(0, -1))

        quantity++
    }

    return total
};