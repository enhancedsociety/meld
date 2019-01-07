# meld

This repo is the set of contracts for the GOLD token from Meld.

At its core it's a very simple token using the default OpenZeppelin contracts besides 2 additional contracts to allow for compliance checking. 

Blacklisting/Whitelisting exist to allow for compliance with the regulatory requirements.

By Default the Whitelist is off and can be turned on/off by the owner based on their operational & legal requirements. Turning the Whitelist on only allows addresses listed in the whitelist to send/receive the token.

Any address added to the blacklist cannot send/receive the token. 

All the compliant addres lists and roles are managed within the token contract itself.

There's 2 main roles accounted for in the tokens compliance contract. 

1. Owner - Address holding the token that can add / remove addresses to the whitelist & blacklist. Ownership can be renounced and transferred.

2. Minter - minters can mint tokens to any compliant addresses. This actor can be filled by multiple ethereum addressesif need be and can be renounced.

Minters and Owner can only be removed by themselves (ie renunciation) so additions to these lists should be taken very seriously. 

The ES recommendation would be to have a multisig wallet perform duties of each of these roles.

