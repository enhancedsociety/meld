# meld

This repo is the set of contracts for the GOLD token from Meld.

In at its core it's a very simple token with some slight modifications to allow for compliance checking i.e. whitelisting and blacklisting. All these address lists are managed within the token contract itself. 

Blacklisting/Whitelisting exist to allow for compliance with the regulatory requirements.

By Default the Whitelist is off and can be turned on/off by the owner based on their operational & legal requirements. Turning the Whitelist on only allows addresses listed in the whitelist to send/receive the token.

Any address added to the blacklist cannot send/receive the token. 

There's 2 main roles accounted for in the tokens compliance contract. Each of these actors can be filled by multiple ethereum addresses, but likely will be filled by a multisig address.

1. Owner - Address holding the token that can add / remove addresses to the whitelist & blacklist. 
2. Minter - minters can mint tokens to any compliant addresses.


Minters and Owner can only be removed by themselves (ie renunciation) so additions to these lists should be taken very seriously. The ES recommendation would be to have a multisig wallet perform duties on each of these lists.

