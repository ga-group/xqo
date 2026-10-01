[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

exchange quirks ontology (xqo)
==============================

The exchange quirks ontology (xqo) provides vocabulary to classify and
relate certain operational contract variants of exchange-listed
derivatives.


Why?
----

FIBO's official ontology (much like FIX) stop at exchange-specific
implementations, and instead refer to the possibility of extending the
standard unofficially as needed.

Marker trading, in this case, calls for such an extension.
Implemented as order type, or, more precise, as *execution modality*,
marker trading bears no price formation burden, instead it uses
(consumes) a price formed elsewhere.  As such, entry to the market
without contributing to price discovery mandates an exit from the
market without price discovery which now implies that such exposure
must be tracked separately from the outright contract.  Exchanges
solve this tracking problem via *operational products*: They clone the
outright contract to create a variant that shares all the economic
attributes of the "underlying" contract but allows for separate
book-keeping of open interest.

With this trick, future commission merchants (FCMs) need not change
infrastructure on their end as the contract variant simply looks like
another contract to them.  Data vendors, alas, are also oblivious to
the cloning: Other than mentioning the "underlying" contract in the
contract description variants look and behave as separate resources.


How?
----

A class, `xqo:ExecutionModality` is introduced, and the most prominent
modalities are identified and introduced as classes in their own
right.  Moreover, a class `xqo:FuturesVariant` is introduced, itself a
subclass of `fibo-fbc-fi-fi:Future` to capture the operational futures
contract as a variant of FIBO's future.  Then for each of the
modalities a variant is introduced, itself a subclass of
`xqo:FuturesVariant` which is inferred if a resource states

    R xqo:executedVia xqo:<Modality> .
=>
    R a xqo:<Modality>Variant .

and, conversely:

    R a xqo:<Modality>Variant .
=>
    R xqo:executedVia [
            a xqo:<Modality> 
    ] .


Where?
------

The [official github repository](https://github.com/ga-group/xqo/) contains the
published ontology.

The project's canonical home is <http://schema.ga-group.nl/xqo/>.
