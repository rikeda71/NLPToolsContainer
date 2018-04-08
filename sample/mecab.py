# -*- coding: utf-8 -*-
import sys
import MeCab

m = MeCab.Tagger("-Ochasen")
line = sys.stdin.readline()
print(m.parse(line))
