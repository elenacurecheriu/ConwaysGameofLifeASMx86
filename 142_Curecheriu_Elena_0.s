.data
    m: .space 4
    n: .space 4
    p: .space 4
    n_copie: .space 4
    m_copie: .space 4
    lineIndex: .space 4
    columnIndex: .space 4
    matrice: .zero 1600
    cnt: .zero 1600
    contor: .space 4
    k: .space 4
    x: .space 4
    y: .space 4
    val_ant: .space 4
    index: .space 4
    pozitie: .space 4
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d "
    endl: .asciz "\n"
.text
 
.global main
 
main:
    push $m #citire m
    push $formatScanf
    call scanf
    pop %ebx
    pop %ebx
 
    push $n #citire n
    push $formatScanf
    call scanf
    pop %ebx
    pop %ebx
 
    push $p #citire p
    push $formatScanf
    call scanf
    add $8, %esp
 
    mov $matrice, %edi #incarcam in memorie matricea "celulelor"
    mov $cnt, %esi #incarcam in memorie matricea in care contorizam vecinii
    movl $0, %ecx
    
    addl $2, n #pentru a prelucra cu tot cu matricea extinsa
    addl $2, m
    
    push %eax #pentru afisare fara bordare
    movl n, %eax
    movl %eax, n_copie
    decl n_copie
    pop %eax
 
    push %eax
    movl m, %eax
    movl %eax, m_copie
    decl m_copie
    pop %eax
    
    
 
et_for_indici:
    cmp p, %ecx
    je et_citire_iteratii
 
    push %ecx
    
 	
    push $x
    push $formatScanf
    call scanf
    add $8, %esp
 
    push $y
    push $formatScanf
    call scanf
    add $8, %esp
 	
    pop %ecx
    
    incl x
    incl y
    
    movl x, %eax
    movl $0, %edx
    mull n
    addl y, %eax
 
    movl $1, (%edi, %eax, 4)
 
    inc %ecx 
    jmp et_for_indici
 
### ^^^ ok


et_citire_iteratii:
    push $k #citire k
    push $formatScanf
    call scanf
    add $8, %esp
    movl $0, %ecx
    jmp et_for_mare
    
et_for_mare:
	cmp k, %ecx
	je et_afis_matrice
	push %ecx
	et_for_golire_cnt:
		movl $1, lineIndex
		for_golire_lines:
			movl lineIndex, %ecx
			cmp m_copie, %ecx
			je et_for_prelucrare_cnt
			movl $1, columnIndex
		for_golire_columns:
			movl columnIndex, %ecx
			cmp n_copie, %ecx
			je cont_for_golire
 		
				movl lineIndex, %eax
				movl $0, %edx
				mull n
				addl columnIndex, %eax
				movl $0, (%esi, %eax, 4)
 		
			incl columnIndex
			jmp for_golire_columns
 
		cont_for_golire:
			incl lineIndex
			jmp for_golire_lines
	
	
	et_for_prelucrare_cnt:
		movl $1, lineIndex
		for_prelucrare_lines:
			movl lineIndex, %ecx
			cmp m_copie, %ecx
			je et_for_prelucrare_matrice
			movl $1, columnIndex
	
		for_prelucrare_columns:
			movl columnIndex, %ecx
			cmp n_copie, %ecx
			je cont_for_prelucrare_cnt
			
			
			movl lineIndex, %eax
			mull n
			addl columnIndex, %eax
			movl %eax, pozitie
			
			movl $0, %ebx
			
			
			# i, j-1
			movl lineIndex, %eax
			mull n
			addl columnIndex, %eax
			decl %eax
			addl (%edi, %eax, 4), %ebx
			
			
			# i, j+1
			movl lineIndex, %eax
			mull n
			addl columnIndex, %eax
			incl %eax
			addl (%edi, %eax, 4), %ebx
			
			# i-1, j
			movl lineIndex, %eax
			decl %eax
			mull n
			addl columnIndex, %eax
			addl (%edi, %eax, 4), %ebx
			
			# i+1, j
			movl lineIndex, %eax
			incl %eax
			mull n
			addl columnIndex, %eax
			addl (%edi, %eax, 4), %ebx
			
			# i-1, j-1
			movl lineIndex, %eax
			decl %eax
			mull n
			addl columnIndex, %eax
			decl %eax
			addl (%edi, %eax, 4), %ebx
			
			# i-1, j+1
			movl lineIndex, %eax
			decl %eax
			mull n
			addl columnIndex, %eax
			incl %eax
			addl (%edi, %eax, 4), %ebx
			
			# i+1, j-1
			movl lineIndex, %eax
			incl %eax
			mull n
			addl columnIndex, %eax
			decl %eax
			addl (%edi, %eax, 4), %ebx
			
			# i+1, j+1
			movl lineIndex, %eax
			incl %eax
			mull n
			addl columnIndex, %eax
			incl %eax
			addl (%edi, %eax, 4), %ebx
			
			
			
			movl pozitie, %eax
			movl %ebx, (%esi, %eax, 4)
			incl columnIndex
			jmp for_prelucrare_columns
		
		cont_for_prelucrare_cnt:
			incl lineIndex
			jmp for_prelucrare_lines
	
	et_for_prelucrare_matrice:
		movl $1, lineIndex
		for_prelucrare_matrice_lines:
			movl lineIndex, %ecx
			cmp m_copie, %ecx
			je revenire_for_mare
			movl $1, columnIndex
		for_prelucrare_matrice_columns:
			movl columnIndex, %ecx
			cmp n_copie, %ecx
			je cont_for_prelucrare_matrice
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			addl columnIndex, %eax
			
			movl (%edi, %eax, 4), %ebx
			movl %ebx, val_ant
			movl (%esi, %eax, 4), %ebx
			
			movl $0, (%edi, %eax, 4)
			
			#push %ebx
			#push $formatPrintf
			#call printf
			#addl $8, %esp
			
			
			cmpl $1, val_ant
			je modif_1
			
			cmpl $0, val_ant
			je modif_2
			
			modif_1:
				cmpl $2, %ebx
				jl modif_zero
				
				cmpl $3, %ebx
				jg modif_zero
				
				jmp nimic
				modif_zero:
					movl $0, (%edi, %eax, 4)
					jmp revenire
				nimic:
					movl $1, (%edi, %eax, 4)
					jmp revenire
			
			modif_2:
				cmpl $3, %ebx
				je modif_one
				jmp revenire
				
				modif_one:
					movl $1, (%edi, %eax, 4)
					jmp revenire
		revenire:
			incl columnIndex
			jmp for_prelucrare_matrice_columns
		
		cont_for_prelucrare_matrice:
			incl lineIndex
			jmp for_prelucrare_matrice_lines
	
revenire_for_mare:
	pop %ecx
	incl %ecx
	jmp et_for_mare

### vvvv ok
et_afis_matrice:
	movl $1, lineIndex
	for_lines:
		movl lineIndex, %ecx
		cmp m_copie, %ecx
		je et_exit
		movl $1, columnIndex
	for_columns:
		movl columnIndex, %ecx
		cmp n_copie, %ecx
		je cont
 		
 		# prelucrarea efectiva din cele doua for-uri, aici vrem sa afisam elementele
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			addl columnIndex, %eax
			# ^^ calcul adresa a[i][j] cu indicii de la 1
			movl (%edi, %eax, 4), %ebx 
			push %ebx
			push $formatPrintf
			call printf
			addl $8, %esp
 		#
 		
		incl columnIndex
		jmp for_columns
 
	cont:
		push $endl
		call printf
		add $4, %esp
		incl lineIndex
		jmp for_lines
 
et_exit:

	push $0
	call fflush
	addl $4, %esp
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
