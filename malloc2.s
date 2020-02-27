	.text
	.file	"malloc2.c"
	.globl	my_init                 # -- Begin function my_init
	.p2align	4, 0x90
	.type	my_init,@function
my_init:                                # @my_init
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.L.str, %edi
	movl	$270565952, %esi        # imm = 0x10208240
	xorl	%eax, %eax
	callq	printf
	movl	$270565952, %edi        # imm = 0x10208240
	movl	$1, %esi
	callq	calloc
	movq	%rax, %fs:entry@TPOFF
	leaq	2130488(%rax), %rsi
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, %fs:entry@TPOFF+8
	movq	$0, %fs:entry@TPOFF+24
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	callq	printf
	cmpq	$0, %fs:entry@TPOFF
	je	.LBB0_2
# %bb.1:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.LBB0_2:
	.cfi_def_cfa_offset 16
	movl	$.Lstr, %edi
	callq	puts
	movl	$1, %edi
	callq	exit
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
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	%fs:entry@TPOFF, %rbx
	movq	(%rbx), %rax
	movq	33336(%rbx,%rax,8), %rdx
	cmpq	$-1, %rdx
	je	.LBB4_1
.LBB4_7:
	movq	%rdx, %rcx
	notq	%rcx
	tzcntq	%rcx, %rcx
	btsq	%rcx, %rdx
	movq	%rdx, 33336(%rbx,%rax,8)
	shlq	$6, %rax
	orq	%rcx, %rax
	movq	%rax, %rcx
	shlq	$4, %rcx
	movl	%eax, 2130492(%rbx,%rcx)
	movl	$0, 2130488(%rbx,%rcx)
	leaq	(%rbx,%rcx), %rax
	addq	$2130496, %rax          # imm = 0x208240
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB4_1:
	.cfi_def_cfa_offset 16
	movq	24(%rbx), %rcx
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	movq	8(%rbx), %rax
	movq	568(%rbx,%rax,8), %rdx
	btsq	%rcx, %rdx
	movq	%rdx, 568(%rbx,%rax,8)
	cmpq	$-1, %rdx
	je	.LBB4_4
# %bb.3:                                #   in Loop: Header=BB4_2 Depth=1
	notq	%rdx
	tzcntq	%rdx, %rcx
.LBB4_6:                                #   in Loop: Header=BB4_2 Depth=1
	movq	%rcx, 24(%rbx)
	shlq	$6, %rax
	orq	%rcx, %rax
	movq	%rax, (%rbx)
	movq	33336(%rbx,%rax,8), %rdx
	cmpq	$-1, %rdx
	jne	.LBB4_7
	jmp	.LBB4_2
.LBB4_4:                                #   in Loop: Header=BB4_2 Depth=1
	movq	16(%rbx), %rax
	movzbl	32(%rbx), %edx
	movq	56(%rbx,%rax,8), %rcx
	btsq	%rdx, %rcx
	movq	%rcx, 56(%rbx,%rax,8)
	cmpq	$-1, %rcx
	je	.LBB4_8
.LBB4_5:                                #   in Loop: Header=BB4_2 Depth=1
	notq	%rcx
	tzcntq	%rcx, %rcx
	movq	%rcx, 32(%rbx)
	shlq	$6, %rax
	orq	%rcx, %rax
	movq	%rax, 8(%rbx)
	movq	568(%rbx,%rax,8), %rcx
	notq	%rcx
	tzcntq	%rcx, %rcx
	jmp	.LBB4_6
.LBB4_8:                                #   in Loop: Header=BB4_2 Depth=1
	movzbl	40(%rbx), %ecx
	movq	48(%rbx), %rax
	btsq	%rcx, %rax
	movq	%rax, 48(%rbx)
	cmpq	$-1, %rax
	je	.LBB4_10
# %bb.9:                                #   in Loop: Header=BB4_2 Depth=1
	notq	%rax
	tzcntq	%rax, %rax
	movq	%rax, 40(%rbx)
	movq	%rax, 16(%rbx)
	movq	56(%rbx,%rax,8), %rcx
	jmp	.LBB4_5
.LBB4_10:
	movl	$.Lstr.9, %edi
	callq	puts
	movq	40(%rbx), %rsi
	movq	16(%rbx), %rdx
	movq	(%rbx), %r8
	movq	8(%rbx), %rcx
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$1, %edi
	callq	exit
.Lfunc_end4:
	.size	my_malloc, .Lfunc_end4-my_malloc
	.cfi_endproc
                                        # -- End function
	.globl	free_storage_class      # -- Begin function free_storage_class
	.p2align	4, 0x90
	.type	free_storage_class,@function
free_storage_class:                     # @free_storage_class
	.cfi_startproc
# %bb.0:
	movq	%rsi, %rax
	shrq	$6, %rsi
	imulq	%rax, %rdx
	subq	%rdx, %rdi
	movq	$-2, %r9
	movq	$-2, %rdx
	movl	%eax, %ecx
	rolq	%cl, %rdx
	andq	%rdx, -2097152(%rdi,%rsi,8)
	jne	.LBB5_4
# %bb.1:
	movq	%rax, %r8
	shrq	$12, %r8
	addq	$-2130440, %rdi         # imm = 0xFFDF7DF8
	movl	%esi, %ecx
	rolq	%cl, %r9
	andq	%r9, 520(%rdi,%r8,8)
	jne	.LBB5_4
# %bb.2:
	andl	$63, %r8d
	shrq	$18, %rax
	movq	$-2, %rdx
	movq	$-2, %rsi
	movl	%r8d, %ecx
	rolq	%cl, %rsi
	andq	%rsi, 8(%rdi,%rax,8)
	je	.LBB5_3
.LBB5_4:
	retq
.LBB5_3:
	movl	%eax, %ecx
	rolq	%cl, %rdx
	andq	%rdx, (%rdi)
	retq
.Lfunc_end5:
	.size	free_storage_class, .Lfunc_end5-free_storage_class
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
	addq	$-8, %rdi
	movq	%rax, %rsi
	shrq	$6, %rsi
	cmpl	$1, %ecx
	je	.LBB6_3
# %bb.1:
	testl	%ecx, %ecx
	jne	.LBB6_4
# %bb.2:
	movq	%rax, %rcx
	shlq	$4, %rcx
	jmp	.LBB6_5
.LBB6_3:
	movq	%rax, %rcx
	shlq	$5, %rcx
	jmp	.LBB6_5
.LBB6_4:
	movq	%rax, %rcx
	shlq	$4, %rcx
	leaq	(%rcx,%rcx,2), %rcx
.LBB6_5:
	subq	%rcx, %rdi
	movq	$-2, %r9
	movq	$-2, %rdx
	movl	%eax, %ecx
	rolq	%cl, %rdx
	andq	%rdx, -2097152(%rdi,%rsi,8)
	jne	.LBB6_9
# %bb.6:
	movq	%rax, %r8
	shrq	$12, %r8
	addq	$-2130440, %rdi         # imm = 0xFFDF7DF8
	movl	%esi, %ecx
	rolq	%cl, %r9
	andq	%r9, 520(%rdi,%r8,8)
	jne	.LBB6_9
# %bb.7:
	andl	$63, %r8d
	shrq	$18, %rax
	movq	$-2, %rdx
	movq	$-2, %rsi
	movl	%r8d, %ecx
	rolq	%cl, %rsi
	andq	%rsi, 8(%rdi,%rax,8)
	je	.LBB6_8
.LBB6_9:
	retq
.LBB6_8:
	movl	%eax, %ecx
	rolq	%cl, %rdx
	andq	%rdx, (%rdi)
	retq
.Lfunc_end6:
	.size	my_free, .Lfunc_end6-my_free
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
	movl	$.L.str.5, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.6, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.7, %edi
	movl	$12, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str, %edi
	movl	$270565952, %esi        # imm = 0x10208240
	xorl	%eax, %eax
	callq	printf
	movl	$270565952, %edi        # imm = 0x10208240
	movl	$1, %esi
	callq	calloc
	movq	%rax, %fs:entry@TPOFF
	leaq	2130488(%rax), %rsi
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, %fs:entry@TPOFF+8
	movq	$0, %fs:entry@TPOFF+24
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	callq	printf
	cmpq	$0, %fs:entry@TPOFF
	je	.LBB7_8
# %bb.1:
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB7_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_3 Depth 2
                                        #     Child Loop BB7_5 Depth 2
	movl	$16777216, %ebx         # imm = 0x1000000
	.p2align	4, 0x90
.LBB7_3:                                #   Parent Loop BB7_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$16, %edi
	callq	my_malloc
	decl	%ebx
	jne	.LBB7_3
# %bb.4:                                #   in Loop: Header=BB7_2 Depth=1
	movl	$270565936, %ebx        # imm = 0x10208230
	.p2align	4, 0x90
.LBB7_5:                                #   Parent Loop BB7_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%fs:entry@TPOFF, %rdi
	addq	%rbx, %rdi
	callq	my_free
	addq	$-16, %rbx
	cmpq	$2130480, %rbx          # imm = 0x208230
	jne	.LBB7_5
# %bb.6:                                #   in Loop: Header=BB7_2 Depth=1
	incq	%r14
	cmpq	$1000, %r14             # imm = 0x3E8
	jne	.LBB7_2
# %bb.7:
	movl	$.L.str.8, %edi
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
.LBB7_8:
	.cfi_def_cfa_offset 32
	movl	$.Lstr, %edi
	callq	puts
	movl	$1, %edi
	callq	exit
.Lfunc_end7:
	.size	main, .Lfunc_end7-main
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
	.zero	32
	.size	entry, 32

	.type	.L.str.1,@object        # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"data start(0) = %ld\n"
	.size	.L.str.1, 21

	.type	.L.str.4,@object        # @.str.4
.L.str.4:
	.asciz	"l1bit=%ld idx2=%ld idx3=%ld idx4=%ld"
	.size	.L.str.4, 37

	.type	.L.str.5,@object        # @.str.5
.L.str.5:
	.asciz	"ffs(0) = %d\n"
	.size	.L.str.5, 13

	.type	.L.str.6,@object        # @.str.6
.L.str.6:
	.asciz	"ffs(1) = %d\n"
	.size	.L.str.6, 13

	.type	.L.str.7,@object        # @.str.7
.L.str.7:
	.asciz	"ffs(4096) = %d\n"
	.size	.L.str.7, 16

	.type	.L.str.8,@object        # @.str.8
.L.str.8:
	.asciz	"16777216 * 10^3 iterations done"
	.size	.L.str.8, 32

	.type	.Lstr,@object           # @str
.Lstr:
	.asciz	"cannot allocate slab"
	.size	.Lstr, 21

	.type	.Lstr.9,@object         # @str.9
.Lstr.9:
	.asciz	"out of memory"
	.size	.Lstr.9, 14


	.ident	"clang version 9.0.1-8 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
