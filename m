Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763A274B58
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730275; cv=none; b=iOemHzes08lqciJq7GpxXlBAlmtZnVGVio57Y/S00HAFOtE4MfyqTyIOH8aQP/rm/Yjp6Zpc+u3bQlR2qgtw1AU+oSVQPHomJF7KoI6Cb+RBqr6pQimX2wTGGV0SyhYjiT//nutZ0RmP6lbySlBD9waScLPA+xArqiVM/8DNHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730275; c=relaxed/simple;
	bh=tIjeursDWAn8brSKiPk0zCi2oGtq+KqA9l2GLev78FQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dRf18bC8jjVu8cLyHtpG0uIDigVlmwqtHOjAkNnxaqi7DunvV8pTTqIverME7fycp2D6a+pR0QZOFCnl2aN03CAbMe3fn1OJKVpyZ/Y3Ae9S2LugSRuJq0mOJ2YgDVNuB9wyabBfRCidczBwgu3y4b2UQVrGojLzMod+8d+yKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l48/+vuU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l48/+vuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778730273; x=1810266273;
  h=date:from:to:cc:subject:message-id;
  bh=tIjeursDWAn8brSKiPk0zCi2oGtq+KqA9l2GLev78FQ=;
  b=l48/+vuUucHWF53ACteRCoffBF/gzhFkLadgFGlud/Z2K2f066TkeXG7
   V2P09YwgSKgyrfM3BWevZq8y2cZnGceHUGTxMbZvX8kvG+qyjAsd1p+5p
   jleo4LUBT3ERGzvNcbiy3Fe9s7dTUpGwK8hjtJCBihBaA5Qlhm6e/jX2L
   bCMX4jfuNCDmC0n7YwXiGgZjawhdLwYENPRFxk7qhVRylj6QIgxhF6Hpk
   KDdtdJC6wA/N0oyBTVd3oeqaHmuYwwlpdGRDemofabemzq2zQx3mmWPe8
   t2vbBDmDDiDYZPhm/RgRcMo0SCWp4ZooPHxtHgdgCSO0LUzIamrF+M6hb
   g==;
X-CSE-ConnectionGUID: u3PWRtwAQge3XkqTvit5tA==
X-CSE-MsgGUID: H+QJTbkFRjufFvmjvmqHaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79620942"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79620942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 20:44:33 -0700
X-CSE-ConnectionGUID: XawiJM0kQ9S9MSjY2w6JQA==
X-CSE-MsgGUID: UXPMpiR4TASmhIQfhSkT6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="238153306"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 May 2026 20:44:31 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNMzt-000000005lj-0OY2;
	Thu, 14 May 2026 03:44:29 +0000
Date: Thu, 14 May 2026 11:44:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Farrah Chen <farrah.chen@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm:queue 5/24] arch/x86/kvm/svm/vmenter.S:95: Error:
 invalid operands (*UND* and *ABS* sections) for `*'
Message-ID: <202605141116.deKGCTHy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Hi Chang,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
head:   2b5e4245e1d31fd0858bb7abbd82af85a6457c33
commit: 6dec918c1fc7766e505e4ac5cdbbc28a0cc73819 [5/24] KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
config: i386-randconfig-r062-20260514 (https://download.01.org/0day-ci/archive/20260514/202605141116.deKGCTHy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141116.deKGCTHy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141116.deKGCTHy-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/svm/vmenter.S: Assembler messages:
>> arch/x86/kvm/svm/vmenter.S:95: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/svm/vmenter.S:95: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/svm/vmenter.S:95: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/svm/vmenter.S:95: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/svm/vmenter.S:95: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:101: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:116: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:116: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:116: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:116: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:116: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/svm/vmenter.S:116: Error: invalid operands (*UND* and *ABS* sections) for `*'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && HAS_IOMEM [=y]


vim +95 arch/x86/kvm/svm/vmenter.S

    72	
    73		/* Clobbers RAX, RCX, RDX (and ESI on 32-bit), consumes RDI (@svm). */
    74		RESTORE_GUEST_SPEC_CTRL
    75	801:
    76	
    77		/*
    78		 * Use a single vmcb (vmcb01 because it's always valid) for
    79		 * context switching guest state via VMLOAD/VMSAVE, that way
    80		 * the state doesn't need to be copied between vmcb01 and
    81		 * vmcb02 when switching vmcbs for nested virtualization.
    82		 */
    83		mov SVM_vmcb01_pa(%_ASM_DI), %_ASM_AX
    84	1:	vmload %_ASM_AX
    85	2:
    86	
    87		/* Get svm->current_vmcb->pa into RAX. */
    88		mov SVM_current_vmcb(%_ASM_DI), %_ASM_AX
    89		mov KVM_VMCB_pa(%_ASM_AX), %_ASM_AX
    90	
    91		/*
    92		 * Load guest registers. Intentionally omit %_ASM_AX and %_ASM_SP as
    93		 * context switched by hardware
    94		 */
  > 95		LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, \
    96			  %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
    97	#ifdef CONFIG_X86_64
    98		LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, \
    99			  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
   100	#endif
   101		LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, %_ASM_DI
   102	
   103		/* Clobbers EFLAGS.ZF */
   104		SVM_CLEAR_CPU_BUFFERS
   105	
   106		/* Enter guest mode */
   107	3:	vmrun %_ASM_AX
   108	4:
   109		/* Pop @svm to RAX while it's the only available register. */
   110		pop %_ASM_AX
   111	
   112		/*
   113		 * Save all guest registers. Intentionally omit %_ASM_AX and %_ASM_SP as
   114		 * context switched by hardware
   115		 */
   116		STORE_REGS %_ASM_AX, SVM_vcpu_arch_regs, \
   117			   %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI, %_ASM_DI
   118	#ifdef CONFIG_X86_64
   119		STORE_REGS %_ASM_AX, SVM_vcpu_arch_regs, \
   120			   %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
   121	#endif
   122	
   123		/* @svm can stay in RDI from now on.  */
   124		mov %_ASM_AX, %_ASM_DI
   125	
   126		mov SVM_vmcb01_pa(%_ASM_DI), %_ASM_AX
   127	5:	vmsave %_ASM_AX
   128	6:
   129	
   130		/* Restores GSBASE among other things, allowing access to percpu data.  */
   131		pop %_ASM_AX
   132	7:	vmload %_ASM_AX
   133	8:
   134	
   135		/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
   136		FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
   137	
   138		/*
   139		 * Clobbers RAX, RCX, RDX (and ESI, EDI on 32-bit), consumes RDI (@svm)
   140		 * and RSP (pointer to @spec_ctrl_intercepted).
   141		 */
   142		RESTORE_HOST_SPEC_CTRL
   143	901:
   144	
   145		/*
   146		 * Mitigate RETBleed for AMD/Hygon Zen uarch. RET should be
   147		 * untrained as soon as we exit the VM and are back to the
   148		 * kernel. This should be done before re-enabling interrupts
   149		 * because interrupt handlers won't sanitize 'ret' if the return is
   150		 * from the kernel.
   151		 */
   152		UNTRAIN_RET_VM
   153	
   154		/*
   155		 * Clear all general purpose registers except RSP and RAX to prevent
   156		 * speculative use of the guest's values, even those that are reloaded
   157		 * via the stack.  In theory, an L1 cache miss when restoring registers
   158		 * could lead to speculative execution with the guest's values.
   159		 * Zeroing XORs are dirt cheap, i.e. the extra paranoia is essentially
   160		 * free.  RSP and RAX are exempt as they are restored by hardware
   161		 * during VM-Exit.
   162		 */
   163		CLEAR_REGS %ecx, %edx, %ebx, %ebp, %esi, %edi
   164	#ifdef CONFIG_X86_64
   165		CLEAR_REGS %r8d, %r9d, %r10d, %r11d, %r12d, %r13d, %r14d, %r15d
   166	#endif
   167	
   168		/* "Pop" @enter_flags.  */
   169		pop %_ASM_BX
   170	
   171		pop %_ASM_BX
   172	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
