Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489220;
	b=Ey3yTAhvP1wXzXr2q2yOxtpp7WTulr3p9oxwRu0t44Qk8/NVYqcJ5fRtZPEbXOxLq5QP
	 WhAm0PkrVaVOBemZX7a8LqXdi/y3uNcY6N8GZ7dFEVS3Vpqpc6/MaKI1hYi4rJ3L179W8
	 GDMszvSth8UA9xlgNZuQ93I6r8S9vhii+GvQypSNC5bxAKhnhb6LzFf2ChlodIicpOUY5
	 5j2cVMeohKeS9WFh+v+ZcC/E7+nAkAqsI5lZ9xJCJ0NyQ7HwAKFGeC4pCic2OSkJByLiH
	 R01lv487i2VpF9zjs7oy5LY/i/45e+1PXYfb6ojQ2xC5MRk8HXWod26luq9Gp3t5eTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489220;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=r9shP6GkVB70Dk/mMINE0Dt3WFJY0BvMcvpvoN47fe8=;
	b=MnGmtEV2ivt+TGBIHzvMBdvryDsW90QkMWKFkKrpQKPTdAOMhP6rw02cczycNQyLJY1v
	 xjrN6lNjx5+U5eDomSMw4E9uTICiNnuqCCVCmhyl+IdUDq81PibsrdUHlBhnBRtgslTUp
	 EGv99K+ukTN407bT8UPU4OOuTsrScNwg3QrTQhXVH1bslltdSy3OqXM0kVzAdqjhxd+QS
	 QqryB6gbNNsRFnync/df1wfoUrfZCOyZTXsyhqPfwnZJEpJnFfXrI7tPUMrDHomSTYx9g
	 iGTJRIWAfNIj+1XPf58PWEoUKFb/4WJVfrB7mnXgsJEc36oJyge3mzad5Y8esgfqb6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mmMzRA03;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C8606A322;
	Tue, 24 Nov 2026 03:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B8C8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mmMzRA03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795489220; x=1827025220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2QK2BmR8K4w7jSwkmLsFkGSkNiGrhgz+DIBmoHciFY=;
  b=mmMzRA0345iCIvd9kBVlBgvQ+YlDWOWO9Mb8yYW95NGW6x2azgpf05e7
   wj8MUZC3Sm8j37C/dZ+/PeuRk1zb+IDi3RuxJNNXKJnzo29reTFuZGfOI
   erD2VjbPbUBs7cA8D9WJkBDLC5H6Slq+twm75K6BgktJ8W6XYXppUv6Xg
   janSLomJQxTtLmb/uVHGhHC04shEbJ62hosdPtprX1SClzOlDxpa3NxHm
   8p1sLfwVXiU6+jMqryYQmeOiP9eow4aVCfzWKlPwtTHT2sxGTh8xSnq7f
   qFUokG+Hprwi3l9/vPXvv3NkbHIP+ixiHAHvWAQKI5+cjd1rrfOwHmrxE
   w==;
X-CSE-ConnectionGUID: PL7Ly39CSv6X9jkX/PMSHQ==
X-CSE-MsgGUID: vQDjLTJWTtqkjn/kIjB53w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4203363"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4203363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 19:00:18 -0800
X-CSE-ConnectionGUID: SvxwGF6RSjC2g/r9lNPVHA==
X-CSE-MsgGUID: 5mUgQJiFTMqu76VCkQniyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11484093"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Nov 2026 19:00:16 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVglR-00000001ONS-1JyI;
	Tue, 24 Nov 2026 03:00:13 +0000
Date: Tue, 24 Nov 2026 10:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 2/5] KVM: x86: split vcpu->arch.hflags into
 nested_guest_mode and smm_mode
Message-ID: <20261124105040.GgfsW2nq-lkp@intel.com>
References: <20261123175512.80438-3-mlevitsk@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123175512.80438-3-mlevitsk@redhat.com>

Hi Maxim,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on kvm/next mst-vhost/linux-next linus/master v7.4-rc4]
[cannot apply to tip/master kvm/linux-next tip/auto-latest next-20261123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxim-Levitsky/KVM-nVMX-don-t-check-PIR-ON-when-processing-nested-posted-interrupts/20261123-125508
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261123175512.80438-3-mlevitsk%40redhat.com
patch subject: [PATCH v3 2/5] KVM: x86: split vcpu->arch.hflags into nested_guest_mode and smm_mode
config: x86_64-buildonly-randconfig-1001-20261124 (https://download.01.org/0day-ci/archive/20261124/20261124105040.GgfsW2nq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261124/20261124105040.GgfsW2nq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261124105040.GgfsW2nq-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/x86.c: In function 'kvm_vcpu_reset':
>> arch/x86/kvm/x86.c:9652:19: error: 'struct kvm_vcpu_arch' has no member named 'smm_mode'
    9652 |         vcpu->arch.smm_mode = 0;
         |                   ^


vim +9652 arch/x86/kvm/x86.c

  9623	
  9624	void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
  9625	{
  9626		struct kvm_cpuid_entry2 *cpuid_0x1;
  9627		unsigned long old_cr0 = kvm_read_cr0(vcpu);
  9628		unsigned long new_cr0;
  9629	
  9630		/*
  9631		 * Several of the "set" flows, e.g. ->set_cr0(), read other registers
  9632		 * to handle side effects.  RESET emulation hits those flows and relies
  9633		 * on emulated/virtualized registers, including those that are loaded
  9634		 * into hardware, to be zeroed at vCPU creation.  Use CRs as a sentinel
  9635		 * to detect improper or missing initialization.
  9636		 */
  9637		WARN_ON_ONCE(!init_event &&
  9638			     (old_cr0 || kvm_read_cr3(vcpu) || kvm_read_cr4(vcpu)));
  9639	
  9640		/*
  9641		 * SVM doesn't unconditionally VM-Exit on INIT and SHUTDOWN, thus it's
  9642		 * possible to INIT the vCPU while L2 is active.  Force the vCPU back
  9643		 * into L1 as EFER.SVME is cleared on INIT (along with all other EFER
  9644		 * bits), i.e. virtualization is disabled.
  9645		 */
  9646		if (is_guest_mode(vcpu))
  9647			kvm_leave_nested(vcpu);
  9648	
  9649		kvm_lapic_reset(vcpu, init_event);
  9650	
  9651		WARN_ON_ONCE(is_guest_mode(vcpu) || is_smm(vcpu));
> 9652		vcpu->arch.smm_mode = 0;
  9653		vcpu->arch.nested_guest_state = 0;
  9654	
  9655		vcpu->arch.smi_pending = 0;
  9656		vcpu->arch.smi_count = 0;
  9657		atomic_set(&vcpu->arch.nmi_queued, 0);
  9658		vcpu->arch.nmi_pending = 0;
  9659		vcpu->arch.nmi_injected = false;
  9660		kvm_clear_interrupt_queue(vcpu);
  9661		kvm_clear_exception_queue(vcpu);
  9662	
  9663		memset(vcpu->arch.db, 0, sizeof(vcpu->arch.db));
  9664		kvm_update_dr0123(vcpu);
  9665		vcpu->arch.dr6 = DR6_ACTIVE_LOW;
  9666		vcpu->arch.dr7 = DR7_FIXED_1;
  9667		kvm_update_dr7(vcpu);
  9668	
  9669		vcpu->arch.cr2 = 0;
  9670	
  9671		kvm_make_request(KVM_REQ_EVENT, vcpu);
  9672		vcpu->arch.apf.msr_en_val = 0;
  9673		vcpu->arch.apf.msr_int_val = 0;
  9674		vcpu->arch.st.msr_val = 0;
  9675	
  9676		kvmclock_reset(vcpu);
  9677	
  9678		kvm_clear_async_pf_completion_queue(vcpu);
  9679		kvm_async_pf_hash_reset(vcpu);
  9680		vcpu->arch.apf.halted = false;
  9681	
  9682		kvm_xstate_reset(vcpu, init_event);
  9683	
  9684		if (!init_event) {
  9685			vcpu->arch.smbase = 0x30000;
  9686	
  9687			vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
  9688	
  9689			vcpu->arch.msr_misc_features_enables = 0;
  9690			vcpu->arch.ia32_misc_enable_msr = MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL |
  9691							  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL;
  9692	
  9693			__kvm_set_xcr(vcpu, 0, XFEATURE_MASK_FP);
  9694			kvm_msr_write(vcpu, MSR_IA32_XSS, 0);
  9695		}
  9696	
  9697		/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
  9698		memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
  9699		kvm_register_mark_dirty(vcpu, VCPU_REGS_RSP);
  9700	
  9701		/*
  9702		 * Fall back to KVM's default Family/Model/Stepping of 0x600 (P6/Athlon)
  9703		 * if no CPUID match is found.  Note, it's impossible to get a match at
  9704		 * RESET since KVM emulates RESET before exposing the vCPU to userspace,
  9705		 * i.e. it's impossible for kvm_find_cpuid_entry() to find a valid entry
  9706		 * on RESET.  But, go through the motions in case that's ever remedied.
  9707		 */
  9708		cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1);
  9709		kvm_edx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
  9710	
  9711		kvm_x86_call(vcpu_reset)(vcpu, init_event);
  9712	
  9713		kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
  9714		kvm_rip_write(vcpu, 0xfff0);
  9715	
  9716		vcpu->arch.cr3 = 0;
  9717		kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
  9718	
  9719		/*
  9720		 * CR0.CD/NW are set on RESET, preserved on INIT.  Note, some versions
  9721		 * of Intel's SDM list CD/NW as being set on INIT, but they contradict
  9722		 * (or qualify) that with a footnote stating that CD/NW are preserved.
  9723		 */
  9724		new_cr0 = X86_CR0_ET;
  9725		if (init_event)
  9726			new_cr0 |= (old_cr0 & (X86_CR0_NW | X86_CR0_CD));
  9727		else
  9728			new_cr0 |= X86_CR0_NW | X86_CR0_CD;
  9729	
  9730		kvm_x86_call(set_cr0)(vcpu, new_cr0);
  9731		kvm_x86_call(set_cr4)(vcpu, 0);
  9732		kvm_x86_call(set_efer)(vcpu, 0);
  9733		kvm_x86_call(update_exception_bitmap)(vcpu);
  9734	
  9735		/*
  9736		 * Unconditionally reset the MMU, even though super strictly speaking,
  9737		 * a MMU reset is only necessary if and only one of the page role bits
  9738		 * is changing.  All of the CR0/CR4/EFER bits effectively get covered
  9739		 * by checking CR0.PG=1, as CR0.WP and the paging-related bits in CR4
  9740		 * and EFER are irrelevant if CR0.PG was '0'.  Subtly, if the vCPU was
  9741		 * in guest mode (L2) or SMM (although emulating INIT in SMM _should_
  9742		 * be impossible), an MMU reset is also necessary as "guest mode" and
  9743		 * "smm" are both encoded in the shadow page role.  As a result, the
  9744		 * only scenarios where an MMU reset is *not* needed is if the vCPU is
  9745		 * in Real Mode or Unpaged Protected Mode, and micro-optimizing those
  9746		 * paths are not worth the risk of running with a stale MMU context.
  9747		 */
  9748		kvm_mmu_reset_context(vcpu);
  9749	
  9750		/*
  9751		 * Intel's SDM states that all TLB entries are flushed on INIT "as with
  9752		 * a hardware reset", and AMD's APM states the TLBs are flushed on
  9753		 * "External initialization of the processor".  Flush the guest TLB for
  9754		 * both RESET and INIT, regardless of vendor, even though both the SDM
  9755		 * and APM contradict the above statements in other tables.  There is
  9756		 * no meaningful benefit in relying on the guest to flush the TLB, and
  9757		 * a spurious TLB flush is benign and likely negligible from a
  9758		 * performance perspective (especially for RESET).
  9759		 */
  9760		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
  9761	}
  9762	EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_reset);
  9763	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
