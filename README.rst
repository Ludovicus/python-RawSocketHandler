RawSocketHandler: Simple line oriented network socket for logging
==========================================

This library is provided to allow standard python logging to output log data
as lines to a remote socket listener.

Installing
----------

Usage
-----

::

    import logging

    logger = logging.getLogger()
    handler = logging.StreamHandler()
    formatter = LogstashFormatter()

    handler.setFormatter(formatter)
    logger.addHandler(handler)

