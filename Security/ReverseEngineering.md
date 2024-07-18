# Reverse Engineering
## STACK INFO
```
--Stack Number
  5

--Username
CODA-503-M

--Password
Gx1LjlSgOgQJJMy

Boxes
Student - Password
--Linux ops
10.50.31.135
 
--Windows
xfreerdp /v:10.50.24.133 /u:student /dynamic-resolution +glyph-cache +clipboard
10.50.24.133

--Jump
10.50.27.155

--Password
Gx1LjlSgOgQJJMy

--CTFd
http://10.50.20.30:8000/resources
```
## X86_64 Assembly
```
X86_64 Assembly - Common Instruction Pointers
MOV   move source to destination

PUSH  push source onto stack

POP   Pop top of stack to destination

INC   Increment source by 1

DEC   Decrement source by 1

ADD   Add source to destination

SUB   Subtract source from destination

CMP   Compare 2 values by subtracting them and setting the %RFLAGS register. ZeroFlag set means they are the same.

JMP   Jump to specified location

JLE   Jump if less than or equal

JE    Jump if equal
```
## Demo
```
main:
    mov rax, 16     //16 moved into rax
    push rax        //push value of rax (16) onto stack. RSP is pushed up 8 bytes (64 bits)
    jmp mem2        //jmp to mem2 memory location

mem1:
    mov rax, 0      //move 0 (error free) exit code to rax
    ret             //return out of code

mem2:
    pop r8          //pop value on the stack (16) into r8. RSP falls 8 bytes
    cmp rax, r8     //compare rax register value (16) to r8 register value (16)
    je mem1         //jump if comparison has zero bit set to mem1
```
```
main:
    mov rcx, 25     //store the value 25 in rcx register
    mov rbx, 62     //store the value 62 in rbx register
    jmp mem1        //jumps to mem1 location

mem1:
    sub rbx, 40     //subtract 40 from rbx
    mov rsi, rbx    //copy rbx value to rsi
    cmp rcx, rsi    //compare the values in rcx and rsi
    jmple mem2      //jumps to mem2 location if value is less than or equal

mem2:
    mov rax, 0      //store 0 in rax
    ret             //return out of code
```
## Methodology
```
Ghidra
Strings

LINOPS>  proxychains nmap -Pn -T4 192.168.28.111 --open --scri    pt=http-enum
  4 LINOPS> ssh -S /tmp/jump dum -O forward -L 5150:192.168.28.111    :80 -L 5151:192.168.28.111:8080 -L 5152:192.168.28.111:2222
  5 
  6 DOWNLOAD FILES FROM WEBSERVER
  7 LINOPS> scp entry* student@10.50.24.133:C:
  8 
  9 ..........................................
 10 WINOPS> strings entry.c
 11   iVar2 = FUN_004010a0(local_1c);
 12   if (iVar2 == 13519) {
 13     FUN_00401150((wchar_t *)s_Success!_0041c010);
 14     Sleep(5000);
 15   }
 16     
 17     iVar1 = FUN_00404a5c(param_1);
 18   local_8 = 2;
 19   while( true ) {
 20     if (11 < local_8) {
 21       return 12;
 22     }
 23     if (local_8 * 46 == iVar1) break;
 24     local_8 = local_8 + 1;
 25   }
 26   return 13519;
 27 .............................................
    ......................
 30       iVar3 = FUN_00401060();
 31       if (iVar3 == 146) {
 32         FUN_00401320((wchar_t *)s_Success!_004200b8);
 33         Sleep(5000);
 34         
 35           RegOpenKeyExA((HKEY)0x80000001,s_SOFTWARE\MICROSOFT\    KEYED3_00420048,0,983103,&local_20c);
 36   RegQueryValueExA(local_20c,(LPCSTR)0x0,(LPDWORD)0x0,&local_2    18,local_208,&local_214);
 37   RegCloseKey(local_20c);
 38   local_210 = _fopen(s_C:\Users\Public\Documents\secret_004200    68,&DAT_00420064);
 39   FID_conflict:_fwprintf(local_210,(wchar_t *)&DAT_00420090,lo    cal_108);
 40   _fclose(local_210);
 41   sVar1 = _strlen(local_108);
 42   if (sVar1 != 0) {
 43     _strcmp((char *)local_208,local_108);
 44   }
 45   ......................
```
```
