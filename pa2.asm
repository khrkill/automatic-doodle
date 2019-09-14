;benjamin yee
;Titlepa2.asm
move textequ <mov>
temp  textequ <2*3*4*5*6*7>
clearEax textequ <move eax,0>
clearEbx textequ <move ebx,0>
clearEcx textequ <move ecx,0>
clearEdx textequ <move edx,0>
SECOONDS_IN_DAY textequ <24d*60d*60d>
include Irvine32.inc
.data
;define variables needed 
i word 0
signDword  Dword -7fffffffh
aDword Dword 0fffffffh
.data?

.code
main PROC
clearEax
clearEbx
clearEcx
clearEdx
move i,temp
move i,ax
move ebx,signDword
add  ebx,-07ffffffh
move ecx,aDword 
add ecx,aDword
move edx,SECOONDS_IN_DAY
call DumpRegs
exit
main ENDP
END main