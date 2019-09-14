;benjamin yee
;reorder.asm
move textequ <mov>
clearEax textequ <move eax,0>
clearEbx textequ <move ebx,0>
clearEcx textequ <move ecx,0>
clearEdx textequ <move edx,0>
include Irvine32.inc
.data
;define variables needed 
arrayD Dword 123,251,12
.code
main PROC
clearEax
clearEbx
clearEcx
clearEdx
move eax,[arrayD];moves the first term to eax
move ebx,[arrayD+4];moves the second term to ebx
move ecx,[arrayD+8];moves the third term to ecx
move [arrayD],ecx;makes the first term ecx
move [arrayD+4],eax;makes the secind term eax
move [arrayD+8],ebx;makes the third term ebx
call DumpRegs
exit
main ENDP
END main