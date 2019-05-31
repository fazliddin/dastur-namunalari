%ifndef LINUX_TIZIM_XIZMATLARI_INC
%define LINUX_TIZIM_XIZMATLARI_INC

;; Me'zoniy fayllar
%define	STDIN	0
%define	STDOUT	1
%define	STDERR	3

;; Tizim xizmatlari 
%define	FAYLNI_OCHISH_TCH  5
%define	O_QISH_TCH	3
%define	YOZISH_TCH	4
%define	FAYLNI_YOPISH_TCH	6
%define	DASTURNI_YAKUNLASH_TCH	1

;; Faylni ochish maqsadlari
%define	O_QISH_MAQ	0x000
%define	YOZISH_MAQ	0x001
%define	YARATISH_MAQ	0x040
%define	TOZALASH_MAQ	0x200
%define	QO_SHISH_MAQ	0x400


;;LINUX TIZIM XIZMATLARIGA MUROJAAT ETADIGAN MAKRO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Ushbu makroga qiymatlar REGISTERLARDA berilishi
;;   shart emas!
;;
;; * qiymatlari
;;	%1 - tizim xizmatining tartib raqami
;;	%2-%4 - tizim xizmatiga beriladigan
;;		qo'shimcha qiymatlar
;; (agar %3 va %4 berilmasa, ular 0 ga teng qilib olinadi)
%macro tizim_xizmati 2-4 0, 0
	push edx
	push ecx
	push ebx
	push dword %1
	push dword %2
	push dword %3
	push dword %4
	pop edx
	pop ecx
	pop ebx
	pop eax 
	int 0x80
	pop ebx
	pop ecx
	pop edx
%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Faylni ochish tizim chaqiruvi
;;
;; * qiymatlari
;;	%1 - fayl yo'li
;;	%2 - fayli ochish maqsadlari
;;	%3 - faylga beriladigan ruxsatlar
;; (agar %3 berilmasa, u 111000000b ga teng qilib olinadi)
%macro faylni_ochish 2-3 111000000b

	tizim_xizmati FAYLNI_OCHISH_TCH, %1, %2, %3

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * O'qish tizim chaqiruvi
;;
;; * qiymatlari
;;	%1 - fayl tartib raqami
;;	%2 - o'qilgan baytlarni saqlash manzili
;;	%3 - necha bayt o'qilishi
%macro fayldan_o_qish 3

	tizim_xizmati O_QISH_TCH, %1, %2, %3

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Yozish tizim chaqiruvi
;;
;; * qiymatlari
;;	%1 - fayl tartib raqami
;;	%2 - yoziladigan baytlarning xotiradagi manzili
;;	%3 - necha bayt yozilishi
%macro faylga_yozish 3

	tizim_xizmati YOZISH_TCH, %1, %2, %3

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Faylni yopish tizim chaqiruvi
;;
;; * qiymatlari
;;	%1 - fayl tartib raqami
%macro faylni_yopish 1

	tizim_xizmati FAYLNI_YOPISH_TCH, %1

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Dasturni yakunlash tizim chaqiruvi
;;
;; * qiymatlari
;;	%1 - Dastur qanday tugaganligi haqida xabar
%macro dasturni_yakunlash 1

	tizim_xizmati DASTURNI_YAKUNLASH_TCH, %1

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%endif		;; LINUX_TIZIM_XIZMATLARI_INC faylining oxiri
