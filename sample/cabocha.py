# -*- coding: utf-8 -*-
import sys
import CaboCha

c = CaboCha.Parser()
line = sys.stdin.readline()
print(c.parseToString(line))
