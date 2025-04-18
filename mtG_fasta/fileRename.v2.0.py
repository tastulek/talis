import os
import sys

with open(sys.argv[1]) as fh:
    for line in fh:
        sl = line.strip().split("\t")
        old_name = sl[0]
        new_name = sl[1]
        os.rename(old_name, new_name)
