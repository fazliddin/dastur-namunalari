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
