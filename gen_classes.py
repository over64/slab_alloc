#!/usr/bin/python3
classes = [
  [8, 12],     # 64x64 && 64
  [16, 20],    # 48
  [64, 16],    # 32
  [256, 16],   # 16
  [1024, 16],  # 8
  [4096, 16]   # 4
]

levels = []
last = 0
for mul, n in classes:
  last = (last // mul + 1) * mul
  for i in range(0, n):
    #print(mul, last)
    if i == n - 1:
      levels.append([last, mul])
    last += mul


#print(levels)

def show_sc():
  last = 0
  for mul, n in classes:
    last = (last // mul + 1) * mul
    for i in range(0, n):
      print(mul, last)
      last += mul

def bloat(x):
  for lvl, by in levels:
    if x <= lvl:
      sz = x // by * by if x % by == 0 else (x // by + 1) * by
      #print('x = ', x, ' lvl = ', lvl, ' by = ', by, ' size = ', sz)
      if sz != 0:
        print(x, 100 - 100 / sz * x)
      break

def show_bloat():
  for i in range(0, 128000):
    bloat(i)

show_sc()
#show_bloat()
