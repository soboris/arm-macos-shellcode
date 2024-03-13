as bindzsh2.asm -o bindzsh2.o
# ld bindzsh2.o -o bindzsh2 -lSystem -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
ld bindzsh2.o -o bindzsh2 -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`
objdump -d bindzsh2.o | grep 00
