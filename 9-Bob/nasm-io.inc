%ifndef NASM_IO_INC
%define NASM_IO_INC

%define	elf32	1
%define	elf	elf32
%define	coff	2
%define	win32	3
%define	win64	4
%define bin	5
%define obj	6

%if __OUTPUT_FORMAT__ == elf
;; Linux uchun

%define tizim_global global
%define tizim_extern extern

%else
;; Qolgan barcha andozalar uchun

%macro tizim_global 1-*
	%rep %0
		global _%1
		%define %1 _%1
		%rotate 1
	%endrep
%endmacro

%macro tizim_extern 1-*
	%rep %0
		extern _%1
		%define %1 _%1
		%rotate 1
	%endrep
%endmacro

%endif

tizim_extern printf, scanf

;;;;;;;;;;;;;;;;;;;; Asosiy makrolar ;;;;;;;;;;;;;;;;;;;;;;;;
;; YOZUV
%macro chop_et 1-*

%ifnstr %1
	%error ": chop_et ning birinchi qiymati qatorli\
	o'zgarmas bo'lishi kerak"
	jmp %%tamom
%endif
	
%assign	qiymatlar_soni	%0-1

	jmp %%chetlash
%%andoza	db	%1, 0

%%chetlash:
	pushf
	pusha

	%rep qiymatlar_soni
		%rotate -1
		push dword %1
	%endrep
	push dword %%andoza
	call printf

	add esp , %0 * 4
	popa
	popf

%%tamom:
%endmacro


;; O'QUV
%macro qabul_qil 1-*

%ifnstr %1
	%error ": qabul_qil ning birinchi qiymati qatorli o'zgarmas bo'lishi kerak"
	jmp %%tamom
%endif
	
%assign	qiymatlar_soni	%0-1

	jmp %%chetlash
%%andoza	db	%1, 0

%%chetlash:
	pushf
	%rep qiymatlar_soni
		%rotate -1
		push dword %1
	%endrep
	push dword %%andoza
	call scanf

	add esp , %0 * 4
	popf
%%tamom:
%endmacro

%endif
