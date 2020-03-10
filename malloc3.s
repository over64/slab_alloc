	.text
	.file	"malloc3.c"
	.globl	my_init                 # -- Begin function my_init
	.p2align	4, 0x90
	.type	my_init,@function
my_init:                                # @my_init
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.L.str, %edi
	movl	$270565904, %esi        # imm = 0x10208210
	xorl	%eax, %eax
	callq	printf
	movl	$270565904, %edi        # imm = 0x10208210
	movl	$1, %esi
	callq	calloc
	addq	$2130440, %rax          # imm = 0x208208
	movq	%rax, %fs:entry@TPOFF+48
	movq	%fs:0, %rax
	leaq	entry@TPOFF+48(%rax), %rsi
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, %fs:entry@TPOFF+56
	movq	$0, %fs:entry@TPOFF+72
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	jmp	printf                  # TAILCALL
.Lfunc_end0:
	.size	my_init, .Lfunc_end0-my_init
	.cfi_endproc
                                        # -- End function
	.globl	reindex3                # -- Begin function reindex3
	.p2align	4, 0x90
	.type	reindex3,@function
reindex3:                               # @reindex3
	.cfi_startproc
# %bb.0:
	retq
.Lfunc_end1:
	.size	reindex3, .Lfunc_end1-reindex3
	.cfi_endproc
                                        # -- End function
	.globl	reindex2                # -- Begin function reindex2
	.p2align	4, 0x90
	.type	reindex2,@function
reindex2:                               # @reindex2
	.cfi_startproc
# %bb.0:
	retq
.Lfunc_end2:
	.size	reindex2, .Lfunc_end2-reindex2
	.cfi_endproc
                                        # -- End function
	.globl	reindex1                # -- Begin function reindex1
	.p2align	4, 0x90
	.type	reindex1,@function
reindex1:                               # @reindex1
	.cfi_startproc
# %bb.0:
	retq
.Lfunc_end3:
	.size	reindex1, .Lfunc_end3-reindex1
	.cfi_endproc
                                        # -- End function
	.globl	my_malloc               # -- Begin function my_malloc
	.p2align	4, 0x90
	.type	my_malloc,@function
my_malloc:                              # @my_malloc
	.cfi_startproc
# %bb.0:
;	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%fs:entry@TPOFF+48, %rax
	movq	%fs:entry@TPOFF, %rcx
	movq	-2097152(%rax,%rcx,8), %rsi
	cmpq	$-1, %rsi
	je	.LBB4_1
.LBB4_7:
	movq	%rsi, %rdx
	notq	%rdx
	tzcntq	%rdx, %rdx
	btsq	%rdx, %rsi
	movq	%rsi, -2097152(%rax,%rcx,8)
	shlq	$6, %rcx
	orq	%rdx, %rcx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	movl	%ecx, 4(%rax,%rdx)
	movl	$0, (%rax,%rdx)
	addq	%rdx, %rax
	addq	$8, %rax
;	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB4_1:
	.cfi_def_cfa_offset 16
	movq	%fs:entry@TPOFF+24, %rdx
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	movq	%fs:entry@TPOFF+8, %rcx
	movq	-2129920(%rax,%rcx,8), %rsi
	btsq	%rdx, %rsi
	movq	%rsi, -2129920(%rax,%rcx,8)
	cmpq	$-1, %rsi
	je	.LBB4_4
# %bb.3:                                #   in Loop: Header=BB4_2 Depth=1
	notq	%rsi
	tzcntq	%rsi, %rdx
.LBB4_6:                                #   in Loop: Header=BB4_2 Depth=1
	movq	%rdx, %fs:entry@TPOFF+24
	shlq	$6, %rcx
	orq	%rdx, %rcx
	movq	%rcx, %fs:entry@TPOFF
	movq	-2097152(%rax,%rcx,8), %rsi
	cmpq	$-1, %rsi
	jne	.LBB4_7
	jmp	.LBB4_2
.LBB4_4:                                #   in Loop: Header=BB4_2 Depth=1
	movq	%fs:entry@TPOFF+16, %rcx
	movzbl	%fs:entry@TPOFF+32, %esi
	movq	-2130432(%rax,%rcx,8), %rdx
	btsq	%rsi, %rdx
	movq	%rdx, -2130432(%rax,%rcx,8)
	cmpq	$-1, %rdx
	je	.LBB4_8
.LBB4_5:                                #   in Loop: Header=BB4_2 Depth=1
	notq	%rdx
	tzcntq	%rdx, %rdx
	movq	%rdx, %fs:entry@TPOFF+32
	shlq	$6, %rcx
	orq	%rdx, %rcx
	movq	%rcx, %fs:entry@TPOFF+8
	movq	-2129920(%rax,%rcx,8), %rdx
	notq	%rdx
	tzcntq	%rdx, %rdx
	jmp	.LBB4_6
.LBB4_8:                                #   in Loop: Header=BB4_2 Depth=1
	movzbl	%fs:entry@TPOFF+40, %edx
	movq	-2130440(%rax), %rcx
	btsq	%rdx, %rcx
	movq	%rcx, -2130440(%rax)
	cmpq	$-1, %rcx
	je	.LBB4_10
# %bb.9:                                #   in Loop: Header=BB4_2 Depth=1
	notq	%rcx
	tzcntq	%rcx, %rcx
	movq	%rcx, %fs:entry@TPOFF+40
	movq	%rcx, %fs:entry@TPOFF+16
	movq	-2130432(%rax,%rcx,8), %rdx
	jmp	.LBB4_5
.LBB4_10:
	movl	$.Lstr, %edi
	callq	puts
	movq	%fs:entry@TPOFF+40, %rsi
	movq	%fs:entry@TPOFF+16, %rdx
	movq	%fs:entry@TPOFF+8, %rcx
	movq	%fs:entry@TPOFF, %r8
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$1, %edi
	callq	exit
.Lfunc_end4:
	.size	my_malloc, .Lfunc_end4-my_malloc
	.cfi_endproc
                                        # -- End function
	.globl	shl_inv                 # -- Begin function shl_inv
	.p2align	4, 0x90
	.type	shl_inv,@function
shl_inv:                                # @shl_inv
	.cfi_startproc
# %bb.0:
	shlxq	%rsi, %rdi, %rax
	notq	%rax
	retq
.Lfunc_end5:
	.size	shl_inv, .Lfunc_end5-shl_inv
	.cfi_endproc
                                        # -- End function
	.globl	free_storage_class      # -- Begin function free_storage_class
	.p2align	4, 0x90
	.type	free_storage_class,@function
free_storage_class:                     # @free_storage_class
	.cfi_startproc
# %bb.0:
                                        # kill: def $esi killed $esi def $rsi
	movl	%esi, %eax
	imulq	%rdx, %rax
	addq	%rdi, %rax
	leaq	(%rax,%rcx,8), %rdi
	movl	%esi, %edx
	shrl	$6, %edx
	movl	$1, %r10d
	shlxq	%rsi, %r10, %rax
	xorq	%rax, (%rdi,%rdx,8)
	je	.LBB6_1
.LBB6_4:
	retq
.LBB6_1:
	movq	%rcx, %r8
	sarq	$63, %r8
	movq	%r8, %rax
	shrq	$58, %rax
	addq	%rcx, %rax
	sarq	$6, %rax
	leaq	(%rdi,%rax,8), %r9
	movl	%esi, %edi
	shrl	$12, %edi
	shlxq	%rdx, %r10, %rax
	xorq	%rax, (%r9,%rdi,8)
	jne	.LBB6_4
# %bb.2:
	movq	%r8, %rax
	shrq	$52, %rax
	addq	%rcx, %rax
	sarq	$12, %rax
	leaq	(%r9,%rax,8), %rdx
	shrl	$18, %esi
	movl	$1, %eax
	shlxq	%rdi, %rax, %rdi
	xorq	%rdi, (%rdx,%rsi,8)
	jne	.LBB6_4
# %bb.3:
	shrq	$46, %r8
	addq	%r8, %rcx
	sarq	$18, %rcx
	shlxq	%rsi, %rax, %rax
	xorq	%rax, (%rdx,%rcx,8)
	retq
.Lfunc_end6:
	.size	free_storage_class, .Lfunc_end6-free_storage_class
	.cfi_endproc
                                        # -- End function
	.globl	my_free                 # -- Begin function my_free
	.p2align	4, 0x90
	.type	my_free,@function
my_free:                                # @my_free
	.cfi_startproc
# %bb.0:
	movl	-8(%rdi), %ecx
	movl	-4(%rdi), %eax
	movslq	classes(,%rcx,8), %rdx
	movslq	classes+4(,%rcx,8), %rcx
	imulq	%rax, %rdx
	addq	%rdi, %rdx
	leaq	(%rdx,%rcx,8), %rdi
	movq	%rax, %rsi
	shrq	$6, %rsi
	movl	$1, %r10d
	shlxq	%rax, %r10, %rdx
	xorq	%rdx, (%rdi,%rsi,8)
	je	.LBB7_1
.LBB7_4:
	retq
.LBB7_1:
	movq	%rcx, %r8
	sarq	$63, %r8
	movq	%r8, %rdx
	shrq	$58, %rdx
	addq	%rcx, %rdx
	sarq	$6, %rdx
	leaq	(%rdi,%rdx,8), %r9
	movq	%rax, %rdi
	shrq	$12, %rdi
	shlxq	%rsi, %r10, %rdx
	xorq	%rdx, (%r9,%rdi,8)
	jne	.LBB7_4
# %bb.2:
	movq	%r8, %rdx
	shrq	$52, %rdx
	addq	%rcx, %rdx
	sarq	$12, %rdx
	leaq	(%r9,%rdx,8), %rsi
	shrl	$18, %eax
	movl	$1, %edx
	shlxq	%rdi, %rdx, %rdi
	xorq	%rdi, (%rsi,%rax,8)
	jne	.LBB7_4
# %bb.3:
	shrq	$46, %r8
	addq	%r8, %rcx
	sarq	$18, %rcx
	shlxq	%rax, %rdx, %rax
	xorq	%rax, (%rsi,%rcx,8)
	retq
.Lfunc_end7:
	.size	my_free, .Lfunc_end7-my_free
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	xorl	%r14d, %r14d
	movl	$.L.str.4, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.5, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.6, %edi
	movl	$12, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str, %edi
	movl	$270565904, %esi        # imm = 0x10208210
	xorl	%eax, %eax
	callq	printf
	movl	$270565904, %edi        # imm = 0x10208210
	movl	$1, %esi
	callq	calloc
	addq	$2130440, %rax          # imm = 0x208208
	movq	%rax, %fs:entry@TPOFF+48
	movq	%fs:0, %rax
	leaq	entry@TPOFF+48(%rax), %rsi
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, %fs:entry@TPOFF+56
	movq	$0, %fs:entry@TPOFF+72
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	callq	printf
	.p2align	4, 0x90
.LBB8_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_2 Depth 2
                                        #     Child Loop BB8_4 Depth 2
	movl	$16777216, %ebx         # imm = 0x1000000
	.p2align	4, 0x90
.LBB8_2:                                #   Parent Loop BB8_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$16, %edi
	callq	my_malloc
	decl	%ebx
	jne	.LBB8_2
# %bb.3:                                #   in Loop: Header=BB8_1 Depth=1
	movl	$268435448, %ebx        # imm = 0xFFFFFF8
	.p2align	4, 0x90
.LBB8_4:                                #   Parent Loop BB8_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%fs:entry@TPOFF+48, %rdi
	addq	%rbx, %rdi
	callq	my_free
	addq	$-16, %rbx
	cmpq	$-8, %rbx
	jne	.LBB8_4
# %bb.5:                                #   in Loop: Header=BB8_1 Depth=1
	incq	%r14
	cmpq	$1000, %r14             # imm = 0x3E8
	jne	.LBB8_1
# %bb.6:
	movl	$.L.str.7, %edi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	main, .Lfunc_end8-main
	.cfi_endproc
                                        # -- End function
	.globl	inv                     # -- Begin function inv
	.p2align	4, 0x90
	.type	inv,@function
inv:                                    # @inv
	.cfi_startproc
# %bb.0:
	movq	%rdi, %rax
	notq	%rax
	retq
.Lfunc_end9:
	.size	inv, .Lfunc_end9-inv
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"slab size(bytes): %ld\n"
	.size	.L.str, 23

	.type	entry,@object           # @entry
	.section	.tbss,"awT",@nobits
	.globl	entry
	.p2align	3
entry:
	.zero	80
	.size	entry, 80

	.type	.L.str.1,@object        # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"data start(0) = %ld\n"
	.size	.L.str.1, 21

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"l1bit=%ld idx2=%ld idx3=%ld idx4=%ld"
	.size	.L.str.3, 37

	.type	classes,@object         # @classes
	.data
	.globl	classes
	.p2align	4
classes:
	.long	4294967280              # 0xfffffff0
	.long	4294705151              # 0xfffbffff
	.long	4294967264              # 0xffffffe0
	.long	4294705151              # 0xfffbffff
	.size	classes, 16

	.type	.L.str.4,@object        # @.str.4
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.4:
	.asciz	"ffs(0) = %d\n"
	.size	.L.str.4, 13

	.type	.L.str.5,@object        # @.str.5
.L.str.5:
	.asciz	"ffs(1) = %d\n"
	.size	.L.str.5, 13

	.type	.L.str.6,@object        # @.str.6
.L.str.6:
	.asciz	"ffs(4096) = %d\n"
	.size	.L.str.6, 16

	.type	.L.str.7,@object        # @.str.7
.L.str.7:
	.asciz	"16777216 * 10^3 iterations done"
	.size	.L.str.7, 32

	.type	.Lstr,@object           # @str
.Lstr:
	.asciz	"out of memory"
	.size	.Lstr, 14


	.ident	"clang version 9.0.1-8 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
