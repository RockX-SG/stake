import pytest
import time
import sys
import brownie
import random

from pathlib import Path
from brownie import *

def test_updateRatio(ratioSenderContract,destinationChain,destinationContract,sender):
    ratioSenderContract.updateExchangeRatio(destinationChain, destinationContract,{'from':sender, 'value': '1 ether'})