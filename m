Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C66340260
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728898; cv=none; b=NxSsfpATkidevspeLnFe4dDsLb6CxLlzAA8N+RLCjq/k5BIA9y44cF5jHAN3+A1SDIYco7fB7Cta0yW4+6qP/kkT8LVFJni7L867Yw5FFG+rIsd29abWPolvwe4D/6ttRPS70UbBDB26u8WpxWMQtLhTVkeqNyxhCIFfmCD09uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728898; c=relaxed/simple;
	bh=5R0g6qUZdqeJscnktqaMOsyNf0Z8uBUSj0nQCR+jgV0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qfwoL64Zix2KXL6IfKi4NbD/+6rzCL0Z+0yNMxiLuVQTWRrm4YiiH7tE6LiQ3hKQ+l++kfo0+WP218hjorZJHLPNulAOdOHYdhYP1UUafCUoJCbRwuEolnTc5MZmOhrN4eXopKIFkGz7vFcHn6Q3rZWkyGHEZtODuutAgoO9jR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KamiG4h+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KamiG4h+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778728894; x=1810264894;
  h=date:from:to:cc:subject:message-id;
  bh=5R0g6qUZdqeJscnktqaMOsyNf0Z8uBUSj0nQCR+jgV0=;
  b=KamiG4h+fae1j1lvZQWcOcA3UlXpl5FHhWyHhdQzAfriFb1owGSzj3Ug
   GPsJJYFtCZYRXvB3kCwrM3RCf/C6LLGCsxjtceSzRlQGhx97biD37VpBB
   GJvSVYtTwB4P9l1xzlt8cjehEFRnKRRoDHHOHJZzLv4TzuZ0DLcKdZOgl
   hUWZxfZG2ADiIkNnkAip7ICDSG+9tsDqKXHdQE+GPhpuzMCSXpytJjizc
   1sZGJ97LkJ3B9nIIZM5IPLPKYaI3XuBnGveieVJZywW1whoFH69UQhmNg
   bgW9VJIt1b1gj/h9Poj470cQBsSDzhwChUGgkvQXRilt4lNoKmDFbXXiQ
   Q==;
X-CSE-ConnectionGUID: puiB8pWDTSmSZP5EAxTzpQ==
X-CSE-MsgGUID: 0UIzyT2kTG+EisgufvMaIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79380543"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79380543"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 20:21:30 -0700
X-CSE-ConnectionGUID: GaT/K6goTv6lMvgXjY+16A==
X-CSE-MsgGUID: V7nlbkClRcqMklO9B+2a9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237284359"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 May 2026 20:21:27 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNMdY-000000005jv-37ad;
	Thu, 14 May 2026 03:21:24 +0000
Date: Thu, 14 May 2026 11:20:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Farrah Chen <farrah.chen@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm:queue 4/24] arch/x86/kvm/vmx/vmenter.S:98: Error:
 invalid operands (*UND* and *ABS* sections) for `*'
Message-ID: <202605141102.53Vk824r-lkp@intel.com>
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
commit: d1d1534a7ef4694a6a7b079c80e661dd66d04e9c [4/24] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
config: i386-buildonly-randconfig-001-20260514 (https://download.01.org/0day-ci/archive/20260514/202605141102.53Vk824r-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141102.53Vk824r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141102.53Vk824r-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/vmx/vmenter.S: Assembler messages:
>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:105: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
   arch/x86/kvm/vmx/vmenter.S:166: Error: invalid operands (*UND* and *ABS* sections) for `*'


vim +98 arch/x86/kvm/vmx/vmenter.S

    88	
    89		/*
    90		 * Since vmentry is serializing on affected CPUs, there's no need for
    91		 * an LFENCE to stop speculation from skipping the wrmsr.
    92		 */
    93	
    94		/*
    95		 * Load guest registers.  Don't clobber flags. Intentionally omit
    96		 * %_ASM_SP as it's context switched by hardware
    97		 */
  > 98		LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
    99			  %_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
   100	#ifdef CONFIG_X86_64
   101		LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
   102			  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
   103	#endif
   104		/* Load guest RDI.  This kills the @vmx pointer! */
   105		LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI
   106	
   107		/*
   108		 * Note, ALTERNATIVE_2 works in reverse order.  If CLEAR_CPU_BUF_VM is
   109		 * enabled, do VERW unconditionally.  If CPU_BUF_VM_MMIO is enabled,
   110		 * check @flags to see if the vCPU has access to host MMIO, and if so,
   111		 * do VERW.  Else, do nothing (no mitigations needed/enabled).
   112		 */
   113		ALTERNATIVE_2 "",									  \
   114			      __stringify(testl $KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO, (%_ASM_SP);	  \
   115					  jz .Lskip_mmio_verw;						  \
   116					  VERW;								  \
   117					  .Lskip_mmio_verw:),					  	  \
   118			      X86_FEATURE_CLEAR_CPU_BUF_VM_MMIO,					  \
   119			      __stringify(VERW), X86_FEATURE_CLEAR_CPU_BUF_VM
   120	
   121		/* Check @flags to see if VMLAUNCH or VMRESUME is needed. */
   122		testl $KVM_ENTER_VMRESUME, (%_ASM_SP)
   123		jz .Lvmlaunch
   124	
   125		/*
   126		 * After a successful VMRESUME/VMLAUNCH, control flow "magically"
   127		 * resumes below at 'vmx_vmexit' due to the VMCS HOST_RIP setting.
   128		 * So this isn't a typical function and objtool needs to be told to
   129		 * save the unwind state here and restore it below.
   130		 */
   131		UNWIND_HINT_SAVE
   132	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
