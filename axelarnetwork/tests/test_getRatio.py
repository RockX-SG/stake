import pytest
import time
import sys
import brownie
import random

from pathlib import Path
from brownie import *

def test_getRatio(ratioReceiverContract):
    ratio = ratioReceiverContract.getExchangeRatio()