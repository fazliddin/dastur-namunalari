%ifndef C_QISM_DASTURLARI_INC
%define C_QISM_DASTURLARI_INC

%include "nasm-io.inc"

;; C me'zoniy kutubxonasidagi fayllar bilan ishlovchi qism dasturlari.
tizim_extern	fopen, fread, fwrite, fclose
tizim_extern	exit		;; Dasturni yakunlash Windowsda ham exit

;; Tizim xizmatlari
%define	FAYLNI_OCHISH_TCH	fopen
%define	O_QISH_TCH		fread
%define	YOZISH_TCH		fwrite
%define	FAYLNI_YOPISH_TCH	fclose
%define	DASTURNI_YAKUNLASH_TCH	exit

;; Faylni ochish maqsadlari
%define	O_QISH_MAQ	"r" 
%define	YOZISH_MAQ	"w"
%define	QO_SHISH_MAQ	"wa"

;; C QISM DASTURLARINI CHAQIRADIGAN MAKRO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Ushbu makro qism dasturlarni chaqirishni osonlashtiradi.
;;
;; * qiymatlari
;;	%1 - tizim xizmatini amalga oshiradigan qism dasturi nomi
;;	%2-* - tizim xizmatiga beriladigan qo'shimcha qiymatlar
%macro tizim_xizmati 2-*

%xdefine	qism_dastur	%1
%assign		qiymatlar_soni	%0-1

	%rep	qiymatlar_soni
		%rotate -1
		push	dword %1
	%endrep

	call	qism_dastur
	add		esp , qiymatlar_soni * 4

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Faylni ochish qism dasturi
;;
;; * qiymatlari
;;	%1 - fayl nomi
;;	%2 - fayli ochish maqsadlari
%macro faylni_ochish 2

	jmp	%%chetlash
	%%fayl_ochish_maq	db	%2,0

%%chetlash:

	tizim_xizmati FAYLNI_OCHISH_TCH, %1, %%fayl_ochish_maq

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * O'qish qism dasturi
;;
;; * qiymatlari
;;	%1 - fayl
;;	%2 - o'qilgan baytlarni saqlash manzili
;;	%3 - necha bayt o'qilishi
%macro fayldan_o_qish 3

	tizim_xizmati O_QISH_TCH, %2, 1, %3, %1

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Yozish qism dasturi
;;
;; * qiymatlari
;;	%1 - fayl
;;	%2 - yoziladigan baytlarning xotiradagi manzili
;;	%3 - necha bayt yozilishi
%macro faylga_yozish 3

	tizim_xizmati YOZISH_TCH, %2, 1, %3, %1

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Faylni yopish qism dasturi
;;
;; * qiymatlari
;;	%1 - fayl tartib raqami
%macro faylni_yopish 1

	tizim_xizmati FAYLNI_YOPISH_TCH, %1

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; * Dasturni yakunlash qism dasturi
;;
;; * qiymatlari
;;	%1 - Dastur qanday tugaganligi haqida xabar
%macro dasturni_yakunlash 1

	tizim_xizmati DASTURNI_YAKUNLASH_TCH, %1

%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%endif
