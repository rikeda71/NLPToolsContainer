# -*- coding: utf-8 -*-
from pyknp import Jumanpp
import sys
import codecs

j = Jumanpp()
line = sys.stdin.readline()
if sys.version[0] == str(2):
    result = j.analysis(line.decode("utf-8"))
else:
    result = j.analysis(line)
for mrph in result.mrph_list():
    print(mrph.midasi)
