Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63774FECD3
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540127; cv=none; b=sazbxrSXmBrY2HZkrSlB0u+on67MmmbOcbdVC17QO6ikqoaP3D5ZXebEihKjBVnQt/0fc5Uu9oWMkCbv3Itn8JNh6N2msZrFtSl2x0f8EGYDe75J6AphbK1Xv1OAJVg6/86Jt5pWiq8xztaGTa6nXBOCda/7gaIEAKpyVy6Wyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540127; c=relaxed/simple;
	bh=FtwZPiNUsMP/xfUK71nHkR8f6eGWTrDNA2Um1G91eBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ogeamoIfXH/rqlvBRVd0tMJyMEWUnNKMFAaYoW3jbMJ7Pbru10D2eG6E0A3yC4JjG1OwSYg/Ybp4jAXi0i2gvCidKukXEDu5YGidvzqlRp6j/RDJ1b0brOC4/fybiOQVO1WKRnLTLQDdC+qJmyP2Q6ikkNnFxaVITobkWEpbFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+ZlQae/; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+ZlQae/"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84859a64079so1554594b3a.3
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788540124; x=1789144924; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAmEFChS+Mw8ORUnC6NaPfXbsqCC3aTDWqLaVLXDsik=;
        b=C+ZlQae/k5CDQiopwNRnqmqIUF9ozMtO3CSvZNyseTv7vJS+Ff4Ygq0Sc30h7j3IA+
         zw7UzM1gRhkV6i2i+f83kreNpPi2Ko/fD8xu9GFvk7kpkHqtI2FNDwIqJ/4iCQLKtOf0
         Phm9hjLlRmqoNOTJ9cLfZIkLWnJQ9iqOPx9BHhQK7YYqFKrheCKLdGQF7/khkxkzeS9v
         jM3SL7qWWATKwPu3AadJw15OlDZ8wqU2gb3iclgw63RhsaSB4xvTgS8D7HEwDruAtTrc
         fEbm+2Ep6BLtul/9cBrEbjFmhPGCqpIdOmJY8p8XZTBa6DmM0R3+NvXcvOEwtYavC0eB
         hlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540124; x=1789144924;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rAmEFChS+Mw8ORUnC6NaPfXbsqCC3aTDWqLaVLXDsik=;
        b=qONedZgJ+1l3V/oeToJj9SlYIBC1cm39eW5Br7ahDD15S9NE2fDQtGJRP2fy3kwG/3
         Sa+wAXhjAbpFzWzhTYeYXcOXRDRe1Xh1UACKfk63ADxz+nbQA3U72QV3eDBEKzHGczIQ
         LnDfNVyKmtt2FSbhXs+D03JJS6h3tx1Ug32n8ttthbXtpyPJo2WHvyQnKFOHBPgS2wg5
         gQ11IEvKSSGq3jJw76OiXYK0MQHOJ5Wm8QfjTL/kj0bptfS31cgrsKdtHYfjESRYUWfF
         PABZpPT2arocHd+9B5bhEsYQWE8n9Ey5I2ocOqakWKRzbj/G6YOFshNhw+vaPfOiCWkh
         x5ug==
X-Forwarded-Encrypted: i=1; AKwUvBxWbMkZsAfQYC5jkoaBZqqsirugKJWvsbDH/ASC1NC5LLlMzIlg9/elsrDOZC37ghFK9wY=@vger.kernel.org
X-Gm-Message-State: AFuF++lD1j9Ey1M4xRJ9zOiAuVod07h4BAqnh3clKY+/DcsZS7AH/45A
	tJt4/Gtl3IgQyBDDGpki58MBzBvr67SFDFvFZkd3TqmSZCCvn97CmSKmz0WYS9ZBWTEnffMZhge
	kzwcz5g==
X-Received: from pfbgv7.prod.google.com ([2002:a05:6a00:4e87:b0:848:81e8:f2d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c02:b0:85b:635e:7814
 with SMTP id d2e1a72fcca58-86169e6ed2bmr10426398b3a.12.1788540123262; Fri, 04
 Sep 2026 09:42:03 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:42:02 -0700
In-Reply-To: <20260904023105.1167376-2-zhao1.liu@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904023105.1167376-1-zhao1.liu@intel.com> <20260904023105.1167376-2-zhao1.liu@intel.com>
Message-ID: <apr02qOMhsZnXIlV@google.com>
Subject: Re: [RFC 1/4] KVM: nVMX: Don't copy L2's CET state to L1 if VM-entry
 didn't load it
From: Sean Christopherson <seanjc@google.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Xin Li <xin@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 04, 2026, Zhao Liu wrote:
> On a nested VM-exit that disables VM_EXIT_LOAD_CET_STATE, only copy L2's
> CET state from vmcs12 to vmcs01 if VM-entry really loaded that state,
> i.e. don't copy when VM-entry fails before loading guest state.
>
> The state, that L1 should see after a L2 VM-exit, depends on three
> things: the VM-exit load (host state) control, whether VM-entry loaded
> L2's state, and whether L2 ran.

No, it depends on four things.  The three things you listed, plus uarch-specific
ordering of checks and loads of guest state.  The SDM says:

  the following operations take place concurrently:
  
    (1) the guest-state area of the VMCS is checked to ensure that, after the
        VM entry completes, the state of the logical processor is consistent
	with IA-32 and Intel 64 architectures;
    (2) processor state is loaded from the guest-state area or as specified by
        the VM-entry control fields; and (3) address-range monitoring is cleared.

  Because the checking and the loading occur concurrently, a failure may be
  discovered only after some state has been loaded. For this reason, the logical
  processor responds to such failures by loading state from the host-state area,
  as it would for a VM exit.

So KVM is well within its rights to load vmcs01 state from vmcs12 even on VM-Exit
due to a failed VM-Entry.  More at the very bottom (below the first diff).
 
> For CET, there are 4 cases:
> 
>  1) VM_EXIT_LOAD_CET_STATE is set. Load L1's CET state from vmcs12's
>     host fields, no matter what happened before. KVM already does this.
> 
>  2) VM_EXIT_LOAD_CET_STATE is clear, and VM-entry loaded L2's CET
>     state. Whether it's the normal VM-exit or VM-entry failure exit,
>     the guest's (L2's) state should be retained, so copy vmcs12's guest
>     fields into vmcs01 to give L1 the same result.
> 
>  3) VM_EXIT_LOAD_CET_STATE is clear, VM-entry didn't load L2's CET
>     state, and L2 never ran. This is the typical case that VM-entry
>     fails before loading guest state, the CPU keeps L1's own state, so
>     do nothing.
> 
>  4) VM_EXIT_LOAD_CET_STATE is clear, VM-entry didn't load L2's CET
>     state, but L2 ran and exited normally. The CPU keeps L1's state
>     again, but L2 could have changed it while running, so still copy
>     vmcs12's guest fields into vmcs01, because they hold what L2 left
>     behind.

...

> @@ -3700,6 +3738,13 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  		goto vmentry_fail_vmexit_guest_mode;
>  	}
>  
> +	/*
> +	 * VM-entry has completed the architectural guest-state loading phase;
> +	 * MSRs are loaded after guest state, so failures below should retain
> +	 * L2's state (see nested_l2_state_is_live()).
> +	 */
> +	l2_state = L2_STATE_LOADED_FROM_VMCS12;

This works, but IMO is unnecessarily convoluted.  KVM doesn't need to manually
query vmcs12 entry controls, we can and should instead call sync_vmcs02_to_vmcs12()
in the failed VM-Entry path if vmcs02 has been prepared with vmcs12 state.  Then
the only thing that needs to be communicated to load_vmcs12_host_state() is
whether or not vmcs02 was prepared.  This would make KVM consistent with how it
handles guest state on failed VM-Entry VM-Exits that occur because of hardware's
consistency checks (KVM only validates a subset of guest state).

So I'm fairly certain it's just the below change (I also tweaked the comment about
CET state because it's not at all obvious why vmcs12 would hold the correct state).

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 47599e7312cf..cb6a910eed2e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3613,8 +3613,9 @@ static int nested_vmx_check_permission(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
-				   struct vmcs12 *vmcs12);
+static void load_vmcs12_host_state(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
+				   bool prepared_vmcs02);
+static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12);
 
 /*
  * If from_vmentry is false, this is being called from state restore (either RSM
@@ -3636,6 +3637,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		.basic = EXIT_REASON_INVALID_STATE,
 		.failed_vmentry = 1,
 	};
+	bool prepared_vmcs02 = false;
 	u32 failed_index;
 
 	trace_kvm_nested_vmenter(kvm_rip_read(vcpu),
@@ -3700,6 +3702,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		goto vmentry_fail_vmexit_guest_mode;
 	}
 
+	prepared_vmcs02 = true;
+
 	if (from_vmentry) {
 		failed_index = nested_vmx_load_msr(vcpu,
 						   vmcs12->vm_entry_msr_load_addr,
@@ -3758,6 +3762,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * 26.7 "VM-entry failures during or after loading guest state".
 	 */
 vmentry_fail_vmexit_guest_mode:
+	if (prepared_vmcs02)
+		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
+
 	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
 
@@ -3778,7 +3785,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	nested_put_vmcs12_pages(vcpu);
 
-	load_vmcs12_host_state(vcpu, vmcs12);
+	load_vmcs12_host_state(vcpu, vmcs12, prepared_vmcs02);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
@@ -4797,8 +4804,8 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
  * Failures During or After Loading Guest State").
  * This function should be called when the active VMCS is L1's (vmcs01).
  */
-static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
-				   struct vmcs12 *vmcs12)
+static void load_vmcs12_host_state(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
+				   bool prepared_vmcs02)
 {
 	enum vm_entry_failure_code ignored;
 	struct kvm_segment seg;
@@ -4854,14 +4861,15 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		vmcs_write64(GUEST_BNDCFGS, 0);
 
 	/*
-	 * Load CET state from host state if VM_EXIT_LOAD_CET_STATE is set.
-	 * otherwise CET state should be retained across VM-exit, i.e.,
-	 * guest values should be propagated from vmcs12 to vmcs01.
+	 * If CET state should be retained across VM-exit, i.e. isn't loaded
+	 * from host state fields, and vmcs02 was prepared with guest state and
+	 * thus synchronized back to vmcs12 (CET state is unconditionally saved
+	 * on VM-Exit), then propagate the guest's values from vmcs12 to vmcs01.
 	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_CET_STATE)
 		vmcs_write_cet_state(vcpu, vmcs12->host_s_cet, vmcs12->host_ssp,
 				     vmcs12->host_ssp_tbl);
-	else
+	else if (prepared_vmcs02)
 		vmcs_write_cet_state(vcpu, vmcs12->guest_s_cet, vmcs12->guest_ssp,
 				     vmcs12->guest_ssp_tbl);
 
@@ -5193,7 +5201,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 						       vmcs12->vm_exit_intr_error_code,
 						       KVM_ISA_VMX);
 
-		load_vmcs12_host_state(vcpu, vmcs12);
+		load_vmcs12_host_state(vcpu, vmcs12, true);
 
 		/*
 		 * Process events if an injectable IRQ or NMI is pending, even

As for nitpicking the SDM, KVM doesn't *need* to wait until prepare_vmcs02()
completes cleanly, KVM just needs to guarantee that vmcs12 holds the correct state
if L2 state is loaded from vmcs12 on VM-Exit.  Because even on failure,
prepare_vmcs02() has already loaded (most) guest state into vmcs02.  So we could
sync vmcs02=>vmcs12 on any failure after switching to vmcs02, if we adjusted
prepare_vmcs02() to fully prepare vmcs02 before do its final consistency checks.
I.e. we could do the below on top.

However, as much as I want to be pedantic on this point, I don't think we should
actually do the below.  I combed through the flows and can't find anything that
would result in loading the wrong L1 state if KVM mostly prepares vmcs02 but
doesn't do sync_vmcs02_to_vmcs12().  And marking vmcs02 as prepared if and only
if it's fully prepared is much more obviously correct.

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cb6a910eed2e..68f3b09a1531 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2843,25 +2843,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	/* Note: may modify VM_ENTRY/EXIT_CONTROLS and GUEST/HOST_IA32_EFER */
 	vmx_set_efer(vcpu, vcpu->arch.efer);
 
-	/*
-	 * Guest state is invalid and unrestricted guest is disabled,
-	 * which means L1 attempted VMEntry to L2 with invalid state.
-	 * Fail the VMEntry.
-	 *
-	 * However when force loading the guest state (SMM exit or
-	 * loading nested state after migration, it is possible to
-	 * have invalid guest state now, which will be later fixed by
-	 * restoring L2 register state
-	 */
-	if (CC(from_vmentry && !vmx_guest_state_valid(vcpu))) {
-		*entry_failure_code = ENTRY_FAIL_DEFAULT;
-		return -EINVAL;
-	}
-
-	/* Shadow page tables on either EPT or shadow page tables. */
-	if (nested_vmx_load_cr3(vcpu, vmcs12->guest_cr3, nested_cpu_has_ept(vmcs12),
-				from_vmentry, entry_failure_code))
-		return -EINVAL;
+	kvm_rsp_write(vcpu, vmcs12->guest_rsp);
+	kvm_rip_write(vcpu, vmcs12->guest_rip);
 
 	/*
 	 * Immediately write vmcs02.GUEST_CR3.  It will be propagated to vmcs12
@@ -2882,6 +2865,50 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
 	}
 
+	/*
+	 * DO NOT write vmcs02 after this point!  I.e. load all L2 guest state
+	 * into vmcs02 before performining *any* consistency checks on vmcs12
+	 * guest state.  KVM loads vmcs12 guest from vmcs02 on *all* VM-Exits,
+	 * including VM-Exits due to failed VM-Entry.  Doing so avoids having
+	 * to track which fields are live in vmcs12, and when.  While counter-
+	 * intuitive, loading guest state before it is checked is explicitly
+	 * allowed by the SDM, which says:
+	 *
+	 * the following operations take place concurrently:
+	 *
+	 *  (1) the guest-state area of the VMCS is checked to ensure that,
+	 *      after the VM entry completes, the state of the logical processor
+	 *      is consistent with IA-32 and Intel 64 architectures;
+	 *  (2) processor state is loaded from the guest-state area or as
+	 *      specified by the VM-entry control fields;
+	 *  (3) and address-range monitoring is cleared.
+	 *
+	 * Because the checking and the loading occur concurrently, a failure
+	 * may be discovered only after some state has been loaded. For this
+	 * reason, the logical processor responds to such failures by loading
+	 * state from the host-state area, as it would for a VM exit.
+	 */
+
+	/*
+	 * Guest state is invalid and unrestricted guest is disabled,
+	 * which means L1 attempted VMEntry to L2 with invalid state.
+	 * Fail the VMEntry.
+	 *
+	 * However when force loading the guest state (SMM exit or
+	 * loading nested state after migration, it is possible to
+	 * have invalid guest state now, which will be later fixed by
+	 * restoring L2 register state
+	 */
+	if (CC(from_vmentry && !vmx_guest_state_valid(vcpu))) {
+		*entry_failure_code = ENTRY_FAIL_DEFAULT;
+		return -EINVAL;
+	}
+
+	/* Shadow page tables on either EPT or shadow page tables. */
+	if (nested_vmx_load_cr3(vcpu, vmcs12->guest_cr3, nested_cpu_has_ept(vmcs12),
+				from_vmentry, entry_failure_code))
+		return -EINVAL;
+
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL) &&
 	    kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu)) &&
 	    WARN_ON_ONCE(__kvm_emulate_msr_write(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
@@ -2890,9 +2917,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		return -EINVAL;
 	}
 
-	kvm_rsp_write(vcpu, vmcs12->guest_rsp);
-	kvm_rip_write(vcpu, vmcs12->guest_rip);
-
 	/*
 	 * It was observed that genuine Hyper-V running in L1 doesn't reset
 	 * 'hv_clean_fields' by itself, it only sets the corresponding dirty
@@ -3696,14 +3720,19 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	enter_guest_mode(vcpu);
 
+	/*
+	 * Mark vmcs02 as having been prepared, even if preparation ultimately
+	 * fails, as the final consistency checks performed by prepare_vmcs02()
+	 * are done only after vmcs02 has been loaded with guest state.
+	 */
+	prepared_vmcs02 = true;
+
 	if (prepare_vmcs02(vcpu, vmcs12, from_vmentry, &entry_failure_code)) {
 		exit_reason.basic = EXIT_REASON_INVALID_STATE;
 		vmcs12->exit_qualification = entry_failure_code;
 		goto vmentry_fail_vmexit_guest_mode;
 	}
 
-	prepared_vmcs02 = true;
-
 	if (from_vmentry) {
 		failed_index = nested_vmx_load_msr(vcpu,
 						   vmcs12->vm_entry_msr_load_addr,
@@ -3762,8 +3791,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * 26.7 "VM-entry failures during or after loading guest state".
 	 */
 vmentry_fail_vmexit_guest_mode:
-	if (prepared_vmcs02)
-		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
+	sync_vmcs02_to_vmcs12(vcpu, vmcs12);
 
 	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
@@ -3775,6 +3803,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 */
 	kvm_service_local_tlb_flush_requests(vcpu);
 
+	sync_vmcs02_to_vmcs12(vcpu, vmcs12);
+
 	leave_guest_mode(vcpu);
 
 vmentry_fail_vmexit:

