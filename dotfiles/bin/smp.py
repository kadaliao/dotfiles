#!/usr/bin/env python
# coding: utf-8
'''
按照上下位置，交换主屏幕
外部调用，可以eval这个脚本
'''
import os


def swap_main_display():
    pos_key = 'OTHER_DISPLAY_POS'
    pos = os.environ.get(pos_key) or 'top'

    if pos == 'top':
        pos = 'bottom'
    else:
        pos = 'top'

    cmd = 'hmscreens -setMainID `hmscreens -info | grep "Screen ID:" | head -2 | tail -1 | sed "s/[^0-9]*//g"`'
    cmd += ' -othersStartingPosition ' + pos
    os.system(cmd)
    print('export %s=%s' % (pos_key, pos))


if __name__ == '__main__':
    swap_main_display()
