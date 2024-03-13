as bindzsh.asm -o bindzsh.o
# ld bindzsh.o -o bindzsh -lSystem -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
ld bindzsh.o -o bindzsh -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`
objdump -d bindzsh.o | grep 00
