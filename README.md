# meld

This repo is the set of contracts for the GOLD token from Meld.

In at its core it's a very simple token with some slight modifications to allow for compliance checking and blacklisting.

All the compliance officer, blacklist and minter lists are all managed within the token contract. At present there's a list to enforce who can hold the token built in but disabled. At a later date it could be turned on or replaced entirely without adversely impacting the operation of the token.

There's 4 main actors accounted for in these contracts. Each of these actors can be filled by multiple ethereum addresses, but likely will be filled by a multisig address.

1. Holder - anyone holding the token. Currently the holder whitelist is disabled.
2. Blacklist - the naughty list
3. Minter - minters can mint tokens into any holder's address (or any address if holder list is off)
4. Compliance Officer - manage the membership of the other lists, except minters.

The Blacklist is on by default and the holder list is off.

Minters and Compliance officers can only be removed by themselves (ie renunciation) so additions to these lists should be taken very seriously. The ES recommendation would be to have a multisig wallet perform duties on each of these lists.

