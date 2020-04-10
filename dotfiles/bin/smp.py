#!/usr/bin/env python
# coding: utf-8
'''
按照上下位置，交换主屏幕
外部调用，可以eval这个脚本
'''
import os


def swap_main_display(pos=None):
    pos_d = {'left': 'right', 'right': 'left', 'up': 'bottom',
             'top': 'bottom', 'bottom': 'top', 'down': 'top'}
    pos = pos_d.get(pos, 'top')

    cmd = 'hmscreens -setMainID `hmscreens -info | grep "Screen ID:"' \
        '| head -2 | tail -1 | sed "s/[^0-9]*//g"`'
    cmd += ' -othersStartingPosition ' + pos
    os.system(cmd)


if __name__ == '__main__':
    import sys
    target_pos = sys.argv[1] if len(sys.argv) > 1 else None
    swap_main_display(target_pos)
