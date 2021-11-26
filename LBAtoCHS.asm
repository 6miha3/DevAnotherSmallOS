LBAtoCHS:
;##############################################
;# ВХОД:  В ECX              - СЕКТОР LBA     #
;# ВЫХОД: В CHSCylinder      - Цилиндр в CHS  #
;#        В CHSHead          - Голова  в CHS  #
;#        В CHSSector        - Сектор  в CHS  #
;##############################################
;######## ВЫЧИСЛЯЕМ ВРЕМЕННОЕ ЗНАЧЕНИЕ ######## 
  pusha
  mov bp, sp
  mov ax, [BPB_SecPerTrk]
  mul word [BPB_NumHeads]
  push ax
;########  ВЫЧИСЛЯЕМ ЗНАЧЕНИЕ CYLINDER ########
  push ecx
  mov bx, cx
  shr ecx, 16
  mov dx, cx
  mov ax, bx
  div word [bp-2]              ; В ax - цилиндр
  pop ecx
  mov [CHSCylinder], ax
;######## ВЫЧИСЛЯЕМ ВРЕМЕННОЕ ЗНАЧЕНИЕ ########
  mov bx,  cx
  shr ecx, 16
  mov dx,  cx
  mov ax,  bx
  div word [bp-2]                 ; В dx - temp
;########   ВЫЧИСЛЯЕМ  ЗНАЧЕНИЕ  HEAD  ########
  mov ax,  dx
  xor dx,  dx
  div word [BPB_SecPerTrk]       ; В ax - голова
  mov [CHSHead], ax
;########  ВЫЧИСЛЯЕМ  ЗНАЧЕНИЕ  SECTOR ########
  inc dx
  mov [CHSSector], dx
;##############################################
add sp, 2
popa
ret
;##############################################
  CHSCylinder: dw 0
  CHSHead: dw 0
  CHSSector: dw 0