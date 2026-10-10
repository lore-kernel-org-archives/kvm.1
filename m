Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6049DBBE;
	Sat, 10 Oct 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638563; cv=none; b=UBPNStnnooR+3fcIUiZjCZfT0G6UJ6KWv3BT1CH2lzb5xDc8CczyyFYDHcHe+SXT973VhEsT0766nPBHaRU2s9zWBimAy3m/1pjaZmEKF9oxRiQxsW2VSBMYOUi3X8XZW648/DtG2X0NP679qvDkvq5JMp4Q7EmNB26uKW2/C5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638563; c=relaxed/simple;
	bh=kI0LMQId2pijABUOn7EzH7LxEKO5JNnfOsHFnJ0ects=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxO8TRKcZrRRAzQSaE5yO986McfP6cRhqHsCtT9mDpILoaMJYUb11r7pr/pCcWtUZplO9sgvlqhfr11VFBBKe4WZ7N24YynrpyCNgVNr7Z4vVCL1bkevglGW2MbgMNAU0qqsS9MlZUwDFnjKpjIoFGG73MeFEkJw6xot77TiQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeG0Kx0M; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeG0Kx0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791638561; x=1823174561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kI0LMQId2pijABUOn7EzH7LxEKO5JNnfOsHFnJ0ects=;
  b=jeG0Kx0MP29OCTUSxptsw6+O/vu1asl8LPTSopFRu8CosSPoULcRpNn/
   Mnu5gGsD9dugcYYqTg2iZ/QL6jYp+f/rDvZ/tNkXUkIcNqvDoXnYv0rtK
   S6K+Y1G5p3QzRNsjWcfoZEe1sbBE1XGUVIg7NDT5JniDSgyVzFfXH3gjB
   M5NwvJYaYkGzJ6TOwr5xaUivWuHTeXawECWN/qxbKK/M/T241BzjM2kRT
   j9j76peI39NjVjzqfrvVZVcTLPciglIf0K85jVVS2hkPOlbSKrmhWWX4H
   i49Dqzy160+mF7+kLrR87rxvaaxdW+SV3126RzTMrerJHfuQWRg05gS+L
   A==;
X-CSE-ConnectionGUID: UYiQXHI+RwCl7Lh8iSTTZA==
X-CSE-MsgGUID: /Lzq1e7hTb61t4SiXFh+yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="421501"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="421501"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 06:22:41 -0700
X-CSE-ConnectionGUID: Ra8ixKxZTV+AnIqfpcyipQ==
X-CSE-MsgGUID: vXjroTTcShOHzPeOAnjgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="522337"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Oct 2026 06:22:39 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFX23-000000009ki-40Wf;
	Sat, 10 Oct 2026 13:22:35 +0000
Date: Sat, 10 Oct 2026 21:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 2/2] KVM: nVMX: avoid losing the posted notification
 interrupt when exiting L2
Message-ID: <202610102131.6oaK34Gm-lkp@intel.com>
References: <20261009205036.672523-3-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009205036.672523-3-mlevitsk@redhat.com>

Hi Maxim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next mst-vhost/linux-next linus/master v7.3-rc6 next-20261009]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxim-Levitsky/KVM-nVMX-don-t-check-PIR-ON-when-processing-nested-posted-interrupts/20261009-165035
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261009205036.672523-3-mlevitsk%40redhat.com
patch subject: [PATCH 2/2] KVM: nVMX: avoid losing the posted notification interrupt when exiting L2
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20261010/202610102131.6oaK34Gm-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610102131.6oaK34Gm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610102131.6oaK34Gm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/nested.c:5167:48: warning: result of comparison of constant -1 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
    5167 |                 if (!WARN_ON_ONCE(vmx->nested.posted_intr_nv == -1)) {
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
   include/asm-generic/bug.h:120:25: note: expanded from macro 'WARN_ON_ONCE'
     120 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   1 warning generated.


vim +5167 arch/x86/kvm/vmx/nested.c

  5069	
  5070	/*
  5071	 * Emulate an exit from nested guest (L2) to L1, i.e., prepare to run L1
  5072	 * and modify vmcs12 to make it see what it would expect to see there if
  5073	 * L2 was its real guest. Must only be called when in L2 (is_guest_mode())
  5074	 */
  5075	void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
  5076				 u32 exit_intr_info, unsigned long exit_qualification,
  5077				 u32 exit_insn_len)
  5078	{
  5079		struct vcpu_vmx *vmx = to_vmx(vcpu);
  5080		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
  5081	
  5082		/* Pending MTF traps are discarded on VM-Exit. */
  5083		vmx->nested.mtf_pending = false;
  5084	
  5085		/* trying to cancel vmlaunch/vmresume is a bug */
  5086		kvm_warn_on_nested_run_pending(vcpu);
  5087	
  5088		/* Note, "checking" the request also clears the request. */
  5089		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
  5090	#ifdef CONFIG_KVM_HYPERV
  5091			/*
  5092			 * KVM_REQ_GET_NESTED_STATE_PAGES is also used to map
  5093			 * Enlightened VMCS after migration and we still need to
  5094			 * do that when something is forcing L2->L1 exit prior to
  5095			 * the first L2 run.
  5096			 */
  5097			(void)nested_get_evmcs_page(vcpu);
  5098	#endif
  5099		}
  5100	
  5101		/* Service pending TLB flush requests for L2 before switching to L1. */
  5102		kvm_service_local_tlb_flush_requests(vcpu);
  5103	
  5104		/*
  5105		 * VCPU_REG_PDPTR will be clobbered in arch/x86/kvm/vmx/vmx.h between
  5106		 * now and the new vmentry.  Ensure that the VMCS02 PDPTR fields are
  5107		 * up-to-date before switching to L1.
  5108		 */
  5109		if (enable_ept && is_pae_paging(vcpu))
  5110			vmx_ept_load_pdptrs(vcpu);
  5111	
  5112		leave_guest_mode(vcpu);
  5113	
  5114		if (nested_cpu_has_preemption_timer(vmcs12))
  5115			hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
  5116	
  5117		if (nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETTING)) {
  5118			vcpu->arch.tsc_offset = vcpu->arch.l1_tsc_offset;
  5119			if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_TSC_SCALING))
  5120				vcpu->arch.tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
  5121		}
  5122	
  5123		if (likely(!vmx->fail)) {
  5124			sync_vmcs02_to_vmcs12(vcpu, vmcs12);
  5125	
  5126			if (vm_exit_reason != -1)
  5127				prepare_vmcs12(vcpu, vmcs12, vm_exit_reason,
  5128					       exit_intr_info, exit_qualification,
  5129					       exit_insn_len);
  5130	
  5131			/*
  5132			 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
  5133			 * also be used to capture vmcs12 cache as part of
  5134			 * capturing nVMX state for snapshot (migration).
  5135			 *
  5136			 * Otherwise, this flush will dirty guest memory at a
  5137			 * point it is already assumed by user-space to be
  5138			 * immutable.
  5139			 */
  5140			nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
  5141		} else {
  5142			/*
  5143			 * The only expected VM-instruction error is "VM entry with
  5144			 * invalid control field(s)." Anything else indicates a
  5145			 * problem with L0.
  5146			 */
  5147			WARN_ON_ONCE(vmcs_read32(VM_INSTRUCTION_ERROR) !=
  5148				     VMXERR_ENTRY_INVALID_CONTROL_FIELD);
  5149	
  5150			/* VM-Fail at VM-Entry means KVM missed a consistency check. */
  5151			WARN_ON_ONCE(warn_on_missed_cc);
  5152		}
  5153	
  5154		/*
  5155		 * Drop events/exceptions that were queued for re-injection to L2
  5156		 * (picked up via vmx_complete_interrupts()), as well as exceptions
  5157		 * that were pending for L2.  Note, this must NOT be hoisted above
  5158		 * prepare_vmcs12(), events/exceptions queued for re-injection need to
  5159		 * be captured in vmcs12 (see vmcs12_save_pending_event()).
  5160		 */
  5161		vcpu->arch.nmi_injected = false;
  5162		kvm_clear_exception_queue(vcpu);
  5163		kvm_clear_interrupt_queue(vcpu);
  5164	
  5165		if (lapic_in_kernel(vcpu) && vmx->nested.pi_pending) {
  5166			vmx->nested.pi_pending = 0;
> 5167			if (!WARN_ON_ONCE(vmx->nested.posted_intr_nv == -1)) {
  5168				kvm_lapic_set_irr(vmx->nested.posted_intr_nv, vcpu->arch.apic);
  5169				kvm_make_request(KVM_REQ_EVENT, vcpu);
  5170			}
  5171		}
  5172	
  5173		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
  5174	
  5175		kvm_nested_vmexit_handle_ibrs(vcpu);
  5176	
  5177		/*
  5178		 * Update any VMCS fields that might have changed while vmcs02 was the
  5179		 * active VMCS.  The tracking is per-vCPU, not per-VMCS.
  5180		 */
  5181		vmcs_write32(VM_EXIT_MSR_STORE_COUNT, vmx->msr_autostore.nr);
  5182		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
  5183		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
  5184		vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
  5185		if (kvm_caps.has_tsc_control)
  5186			vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);
  5187	
  5188		nested_put_vmcs12_pages(vcpu);
  5189	
  5190		if ((vm_exit_reason != -1) &&
  5191		    (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx)))
  5192			vmx->nested.need_vmcs12_to_shadow_sync = true;
  5193	
  5194		/* in case we halted in L2 */
  5195		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
  5196	
  5197		if (likely(!vmx->fail)) {
  5198			if (vm_exit_reason != -1)
  5199				trace_kvm_nested_vmexit_inject(vmcs12->vm_exit_reason,
  5200							       vmcs12->exit_qualification,
  5201							       vmcs12->idt_vectoring_info_field,
  5202							       vmcs12->vm_exit_intr_info,
  5203							       vmcs12->vm_exit_intr_error_code,
  5204							       KVM_ISA_VMX);
  5205	
  5206			load_vmcs12_host_state(vcpu, vmcs12);
  5207	
  5208			/*
  5209			 * Process events if an injectable IRQ or NMI is pending, even
  5210			 * if the event is blocked (RFLAGS.IF is cleared on VM-Exit).
  5211			 * If an event became pending while L2 was active, KVM needs to
  5212			 * either inject the event or request an IRQ/NMI window.  SMIs
  5213			 * don't need to be processed as SMM is mutually exclusive with
  5214			 * non-root mode.  INIT/SIPI don't need to be checked as INIT
  5215			 * is blocked post-VMXON, and SIPIs are ignored.
  5216			 */
  5217			if (kvm_cpu_has_injectable_intr(vcpu) || vcpu->arch.nmi_pending)
  5218				kvm_make_request(KVM_REQ_EVENT, vcpu);
  5219			return;
  5220		}
  5221	
  5222		/*
  5223		 * After an early L2 VM-entry failure, we're now back
  5224		 * in L1 which thinks it just finished a VMLAUNCH or
  5225		 * VMRESUME instruction, so we need to set the failure
  5226		 * flag and the VM-instruction error field of the VMCS
  5227		 * accordingly, and skip the emulated instruction.
  5228		 */
  5229		(void)nested_vmx_fail(vcpu, VMXERR_ENTRY_INVALID_CONTROL_FIELD);
  5230	
  5231		/*
  5232		 * Restore L1's host state to KVM's software model.  We're here
  5233		 * because a consistency check was caught by hardware, which
  5234		 * means some amount of guest state has been propagated to KVM's
  5235		 * model and needs to be unwound to the host's state.
  5236		 */
  5237		nested_vmx_restore_host_state(vcpu);
  5238	
  5239		vmx->fail = 0;
  5240	}
  5241	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
