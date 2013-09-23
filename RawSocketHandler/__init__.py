'''
This library is provided to allow standard python
logging to output log data  to a raw network socket sans pickling
'''
import logging
import socket
import datetime
import traceback as tb
import json
import sys

