Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7247045E;
	Mon,  7 Sep 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785275; cv=none; b=birroldFJzoj0Hi8etWZKSBECeVTx1PfRFvDAnOdu+Ni/dmdlcnw75QMmc/ymLx6ijpMxtHuNw3jwbVhLDxIs28YLm1rA92cKc18sj+kTTKELa7UTrTgEVEz9aj255DxrFrfZzUqJmRsndALkRWRDuGrqCgoFMG0f53etCLmoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785275; c=relaxed/simple;
	bh=JC/Oe5ZF+0FMXi+tB4cSC18yJde7t7u/o1RW76OfS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoeDstWoHkxTV7njG9qv7QOwardnnmW+B+G12FiKrTO97mg8eIonUgewADS72IyhQdTzD8KxFh+F1dPqsH4RuuU/fGY+vRzHG5XGchNbYlp6sXtnPypbYm7QZwDfh+MyMLDrgRqBezmWC83u2AthzVuSqHcP0zaZ3w4pR9qkCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsdkepCf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsdkepCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788785273; x=1820321273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JC/Oe5ZF+0FMXi+tB4cSC18yJde7t7u/o1RW76OfS+E=;
  b=HsdkepCf+LQIYqocB+bAi9asRiRnsxtL223zuIQG36b+Zng7CWGQUbLF
   3X/9BORgtZH1FX5fueZipmOGIho/MJ7ZQjAHrPFyVmznq3d87WfmLBAXP
   ZLcBKrqEo8555WJO7tYmatSpIr1/PK/l+K8Y6MNyqbqq7+bGaTesY1cJK
   JKgVrPB6oYZhLgaryn/u7AVooY5qPZDM2+kunhM298LwRj+a4a9Xx+Mf8
   RLE+hn4QQDK5C5s+Tzu+Yg16fkenAPFTk1R8sG9845CDJz74TMEb9H58G
   ypLv1vidiZnfpUVMgB5NXog8x1sLsgV0R0xwfjuNqDLE813kdHvxxNGtI
   Q==;
X-CSE-ConnectionGUID: 1uRHmsC0S4qBygBCQADlzg==
X-CSE-MsgGUID: kmckoH8RSnitY1QmgHXfhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="88948549"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="88948549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 05:47:51 -0700
X-CSE-ConnectionGUID: Ic2JHZ2uQV6hiLQWygpaEQ==
X-CSE-MsgGUID: d6wLlAXvQS6/w5EN3wicBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274504647"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa004.jf.intel.com with ESMTP; 07 Sep 2026 05:47:48 -0700
Date: Mon, 7 Sep 2026 20:47:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
	Chao Gao <chao.gao@intel.com>, Xin Li <xin@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 1/4] KVM: nVMX: Don't copy L2's CET state to L1 if VM-entry
 didn't load it
Message-ID: <ap6yciu1m7tz+NGv@intel.com>
References: <20260904023105.1167376-1-zhao1.liu@intel.com>
 <20260904023105.1167376-2-zhao1.liu@intel.com>
 <apr02qOMhsZnXIlV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apr02qOMhsZnXIlV@google.com>

Hi Sean,

Thanks for your feedback!

On Fri, Sep 04, 2026 at 09:42:02AM -0700, Sean Christopherson wrote:
> Date: Fri, 4 Sep 2026 09:42:02 -0700
> From: Sean Christopherson <seanjc@google.com>
> Subject: Re: [RFC 1/4] KVM: nVMX: Don't copy L2's CET state to L1 if
>  VM-entry didn't load it
> 
> On Fri, Sep 04, 2026, Zhao Liu wrote:
> > On a nested VM-exit that disables VM_EXIT_LOAD_CET_STATE, only copy L2's
> > CET state from vmcs12 to vmcs01 if VM-entry really loaded that state,
> > i.e. don't copy when VM-entry fails before loading guest state.
> >
> > The state, that L1 should see after a L2 VM-exit, depends on three
> > things: the VM-exit load (host state) control, whether VM-entry loaded
> > L2's state, and whether L2 ran.
> 
> No, it depends on four things.  The three things you listed, plus uarch-specific
> ordering of checks and loads of guest state.  The SDM says:
> 
>   the following operations take place concurrently:
>   
>     (1) the guest-state area of the VMCS is checked to ensure that, after the
>         VM entry completes, the state of the logical processor is consistent
> 	with IA-32 and Intel 64 architectures;
>     (2) processor state is loaded from the guest-state area or as specified by
>         the VM-entry control fields; and (3) address-range monitoring is cleared.
> 
>   Because the checking and the loading occur concurrently, a failure may be
>   discovered only after some state has been loaded. For this reason, the logical
>   processor responds to such failures by loading state from the host-state area,
>   as it would for a VM exit.
> 
> So KVM is well within its rights to load vmcs01 state from vmcs12 even on VM-Exit
> due to a failed VM-Entry.  More at the very bottom (below the first diff).

Yes, I agree. I think the specific way KVM handles guest state can also be
considered "uarch-specific" and is not part of the ABI guarantee.

> This works, but IMO is unnecessarily convoluted.  KVM doesn't need to manually
> query vmcs12 entry controls, we can and should instead call sync_vmcs02_to_vmcs12()
> in the failed VM-Entry path if vmcs02 has been prepared with vmcs12 state.  Then
> the only thing that needs to be communicated to load_vmcs12_host_state() is
> whether or not vmcs02 was prepared.  This would make KVM consistent with how it
> handles guest state on failed VM-Entry VM-Exits that occur because of hardware's
> consistency checks (KVM only validates a subset of guest state).
> 
> So I'm fairly certain it's just the below change (I also tweaked the comment about
> CET state because it's not at all obvious why vmcs12 would hold the correct state).

I tested this solution, and it passed the selftest in patch 4. Thanks!

But when I think more deeply about what the sync_vmcs02_to_vmcs12()
function actually does, I think there are still two points worth
discussing:

1. We call sync_vmcs02_to_vmcs12() along the vm-entry failure path; for
   CET, this effectively overwrites the CET guest in vmcs12 with the
   expected L2 CET state.

   Per SDM 29.8, regarding VM-entry failure handling - it states:

   Although this process resembles that of a VM exit, many steps taken
   during a VM exit do not occur for these VM-entry failures:
   • Most VM-exit information fields are not updated (see step 1 above).
   • The valid bit in the injected-event identification field is not cleared.
-> • The guest-state area is not modified.
   • No MSRs are saved into the VM-exit MSR-store area.

   The key point here I want to refer is that the guest state should
   remain unchanged. And considering this case, when VM_ENTRY_LOAD_CET_STATE
   is cleared, KVM tries to load L1's CET state to vmcs02 (vmcs01->vmcs02),
   but sync_vmcs02_to_vmcs12() loads vmcs02 CET states back to vmcs12
   (vmcs02->vmcs12), which changes the guest state and such vmcs12 guest
   state is visible to L1 (so, the whole states transition path is:
   vmcs01->vmcs02->vmcs12, the vmcs12 is changed!).

2. I feel sync_vmcs02_to_vmcs12() might be doing too much. One issue is
   it updates vmcs12->guest_activity_state based on vcpu->arch.mp_state,
   However, the "correct" vcpu->arch.mp_state is set based on
   vmcs12->guest_activity_state only after the VM-entry succeeds (see
   nested_vmx_run). Therefore, in an extreme case (just code reading, not
   tested yet), GUEST_ACTIVITY_HLT might be set to guest_activity_state,
   but because the vm-entry fails, the value of vcpu->arch.mp_state is
   not updated, so sync_vmcs02_to_vmcs12() re-calculates an incorrect
   guest_activity_state.

   Another issue is about vmcs12->guest_linear_address. Per SDM 29.8
   again (the 1st point I listed above), guest_linear_address, as the
   VM-exit information field, is not necessary to be updated.

So, in short, I think sync_vmcs02_to_vmcs12() updates too much state,
and it seems we shouldn't directly modify the guest state visible to L1
(i.e., the guest state in vmcs12).

>  	if (from_vmentry) {
>  		failed_index = nested_vmx_load_msr(vcpu,
>  						   vmcs12->vm_entry_msr_load_addr,
> @@ -3758,6 +3762,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  	 * 26.7 "VM-entry failures during or after loading guest state".
>  	 */
>  vmentry_fail_vmexit_guest_mode:
> +	if (prepared_vmcs02)
> +		sync_vmcs02_to_vmcs12(vcpu, vmcs12);

Based on the two points mentioned above, does Option B (which I described
in my cover letter) seem more reasonable? Instead of updatding almost all
states to vmcs12, we can re-use pre_enter_* states:

vmentry_fail_vmexit_guest_mode:
     if (prepared_vmcs02)
             vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
				 &vmx->nested.pre_vmenter_ssp,
				 &vmx->nested.pre_vmenter_ssp_tbl);

...

> -static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
> -				   struct vmcs12 *vmcs12)
> +static void load_vmcs12_host_state(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
> +				   bool prepared_vmcs02)
>  {
>  	enum vm_entry_failure_code ignored;
>  	struct kvm_segment seg;
> @@ -4854,14 +4861,15 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>  		vmcs_write64(GUEST_BNDCFGS, 0);
>  
>  	/*
> -	 * Load CET state from host state if VM_EXIT_LOAD_CET_STATE is set.
> -	 * otherwise CET state should be retained across VM-exit, i.e.,
> -	 * guest values should be propagated from vmcs12 to vmcs01.
> +	 * If CET state should be retained across VM-exit, i.e. isn't loaded
> +	 * from host state fields, and vmcs02 was prepared with guest state and
> +	 * thus synchronized back to vmcs12 (CET state is unconditionally saved
> +	 * on VM-Exit), then propagate the guest's values from vmcs12 to vmcs01.
>  	 */
>  	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_CET_STATE)
>  		vmcs_write_cet_state(vcpu, vmcs12->host_s_cet, vmcs12->host_ssp,
>  				     vmcs12->host_ssp_tbl);
> -	else
> +	else if (prepared_vmcs02)
>  		vmcs_write_cet_state(vcpu, vmcs12->guest_s_cet, vmcs12->guest_ssp,
>  				     vmcs12->guest_ssp_tbl);

then update L1's state based on pre_vmenter_*, and keep vmcs12 guest
states upchanged:

    else if (prepared_vmcs02)
		vmcs_write_cet_state(vcpu, vmx->nested.pre_vmenter_s_cet,
				     vmx->nested.pre_vmenter_ssp,
				     vmx->nested.pre_vmenter_ssp_tbl);

In addition, in this way, pre_vmenter_* should also be synchronized on
the normal exit path with sync_vmcs02_to_vmcs12().

However, I’m still hesitant because this intermediate state seems too
fragmented. But considering that vmcs12 is L1 visible — and shouldn’t
be modified arbitrarily — maybe an intermediate state like this is
necessary?

Or maybe we should just go back to my original patch, i.e., Option A,
which eliminates the intermediate state.

> As for nitpicking the SDM, KVM doesn't *need* to wait until prepare_vmcs02()
> completes cleanly, KVM just needs to guarantee that vmcs12 holds the correct state
> if L2 state is loaded from vmcs12 on VM-Exit.  Because even on failure,
> prepare_vmcs02() has already loaded (most) guest state into vmcs02.  So we could
> sync vmcs02=>vmcs12 on any failure after switching to vmcs02, if we adjusted
> prepare_vmcs02() to fully prepare vmcs02 before do its final consistency checks.
> I.e. we could do the below on top.
>
> However, as much as I want to be pedantic on this point, I don't think we should
> actually do the below.  I combed through the flows and can't find anything that
> would result in loading the wrong L1 state if KVM mostly prepares vmcs02 but
> doesn't do sync_vmcs02_to_vmcs12().  And marking vmcs02 as prepared if and only
> if it's fully prepared is much more obviously correct.

Yes, I think both approaches - whether to wait until prepare_vmcs02()
completes cleanly or not - are consistent with the SDM; they can be
viewed as differences in the KVM uarch implementation :-) What the user
sees is the hardware state and the guest VMCS state as presented under
a given load control combination.

Thanks,
Zhao

