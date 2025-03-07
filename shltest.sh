#!/bin/bash
#set -x 
# Simple script to test the SHL assembly fragment

# assemble shltest.S into shltest.o
if [[ -a shltest.o ]]; then rm shltest.o; fi
make shltest.o
# assemble shl.S into shl.o
if [[ -a shl.o ]]; then rm shl.o; fi
make shl.o
# link shltest.o and shl.o into shltest
if [[ -a shltest ]]; then rm shltest; fi
make shltest

if [[ ! -a shltest ]]; then
    echo "FAIL: shltest not made"
    echo "0/1"
    exit -1
fi

# delete output file if it exits
if [[ -a shl.resbin ]]; then rm shl.resbin; fi

# run gdb with commands feed from standard input
# using bash here docment support
# https://www.gnu.org/software/bash/manual/bash.html#Here-Documents
# both standard ouput and error are sent to /dev/null so things are quiet
echo "running gdb ... you will have to look in $0 to see what we are doing"

gdb shltest >/dev/null 2>&1 <<EOF
b _start
run
delete 1
set \$rip=test1
c
dump binary value shl.resbin { \$rax, *((long long *)&SUM_POSITIVE), *((long long *)&SUM_NEGATIVE) }
set \$rip=test2
c
append binary value shl.resbin { \$rax, *((long long *)&SUM_POSITIVE), *((long long *)&SUM_NEGATIVE) }
set \$rip=test3
c
append binary value shl.resbin { \$rax, *((long long *)&SUM_POSITIVE), *((long long *)&SUM_NEGATIVE) }
set \$rip=test4
c
append binary value shl.resbin { \$rax, *((long long *)&SUM_POSITIVE), *((long long *)&SUM_NEGATIVE) }
quit
EOF

actual=$(xxd -ps -g8 shl.resbin | tr -d ' ' | tr -d '\n')
# change expected res
expected='02000000000000000100000000000000000000000000000020000000000000000500000000000000000000000000000000000000000200006900000000000000000000000000000000000000000000006900000000000000a2feffffffffffff'

if [[ $actual == $expected ]]; then
    echo PASS
    echo 1/1
else
    echo FAIL
    echo 0/1
fi
