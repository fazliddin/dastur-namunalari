%macro lotindan_kirilga 2

%ifnid %1
	error lotindan_kirilga beriladigan birinchi qiymat nishon nomi bo'lishi kerak.
%elifnstr %2
	error lotindan_kirilga beriladigan ikkinchi qiymat qatorli o'zgarmas bo'lishi kerak.
%endif

%strlen uzunlik	%2
%assign	joriy_belgi_tr	1
%define	bosh_harf_farqi	160
%define	kichik_harf_farqi	96

%1:
%rep	uzunlik
	%substr	harf %2 joriy_belgi_tr
	
	%if (harf >= 65) && (harf <= 90)
		db	harf+bosh_harf_farqi
	%elif (harf >= 97) && (harf <= 122)
		db	harf+kichik_harf_farqi
	%else
		db	harf
	%endif
	
	%assign	joriy_belgi_tr	joriy_belgi_tr+1
%endrep
	db	0		;; Qator so'ngi

%endmacro
