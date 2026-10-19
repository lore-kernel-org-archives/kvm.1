Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445265;
	b=umNSbFxhJipgo3hGQQ1ZcJFzszkaplqroLZYQBhrZmSv6lZ6Sp3Vzz68jOlbUafCU1gc
	 Z6IEOZST4tZUphm1wvQd6fmlqjcgmsjF2iGZm9u1WuFkRZ7jKaLvJA2a/rCfXCNi9nixf
	 Uvn1DyaG5o5flmGcRaHxADMCRiNoteBNfDScIdn2Ly5plyg/LM0q1RcHlrkVwWDLa27g/
	 n+ZIrIU9fBEt9GAu/RerdVCZEXRwVRtF9DgwtlkkNASrg/bW3ryc5yBm8NxHTquL9IFCv
	 8q2BhS9QtW1sWIOPnB8TQR6mG1v+Afa2cUwMfNOrk+jfl6e+ZBYGW8Z1o0HvoDgzWPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pcBsMEwCijvS4r5xZrDMw6uwulx4KbwEcNqxVRxyt34=;
	b=4vIXfW9wQP2Bfmci3Zu1sYalMYuGD4NggZctl5TBmlsWdtVKTY6UQMEq56RxDubp1bMu
	 NlahdyJymeQ7KLukRbcWE1kpkPULOYc58nhBWHq3LdcZcwiBOzF0rBhyaHfNDkqro8DxD
	 HregEPpKkML08GhZlEfcJBriGR6YHjrK7T4iQk5wzcRX7RKN8eDuKlfbsISI+R+tZpV8l
	 IQfpkIPSq7emw5jUWSydtHVFou9zFqZJE2aIQ1oqB6k2rm9OXzHM55q9m4k3yTNvmuSFA
	 bN9Mdf+jUFxoYfRsx2dwAvnrhJOV26CSDpvtu2JB5/q+6wkit68r1LD3oiZTDamFDWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsKp74z6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73E606A319
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsKp74z6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE62D1F000C4;
	Mon, 19 Oct 2026 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445265;
	bh=pcBsMEwCijvS4r5xZrDMw6uwulx4KbwEcNqxVRxyt34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsKp74z6/9Xro4Xn7J6qJLEjd1WMgrflhKnRocapLestkw7XzJKQAGWc3udlQ3ooN
	 aXUJ0h3nl77q0ck01LjMjzgc8PKhbphT4UuY6hOI/9ni/nn6grkzTeGhB8sFT7mCyC
	 V0TB9XG+IsLXLefuhFJ/1BOFbuSpIPB03JYpwLSh6XZOIfBq25jv29beSb8LTuncAv
	 +HbnW8jlqsuuwlqwLQv6cbxkUd//EWi8AVwNQBPSbD8j5ZXvXDfobgJrP+KZV2vSz/
	 avRuGqAZ7skny/uYjhKJs1yYaM8F/+WOrZQPc9QFC2IDtmC0LV30P+vL9OWNScAvxf
	 w/x7rM7Rk8SSA==
Message-ID: <sashiko-outbox-178256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] KVM: SVM: Add LBR/PMC freeze support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019210532.378628-12-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-12-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:27:44 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KVM: SVM: AMD_LBR_PMC_FREEZE advertised without gating in svm_set_=
cpu_caps()
- [High] KVM: SVM: amd_pmu_refresh() leaves freeze bits reserved in global_=
status_rsvd
- [High] KVM: SVM: svm_vcpu_run() loses hardware PMC freeze when GLOBAL_CTL=
 intercepted
- [High] KVM: SVM: svm_need_lbr_virtualization() omits DEBUGCTL freeze-on-P=
MI bits
--

commit e9a3e4432aa85c33133e5cfe1c272c751022082d
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Add LBR/PMC freeze support

This commit advertises X86_FEATURE_AMD_LBR_PMC_FREEZE (CPUID
0x80000022.EAX[2]) to guests and allows guests with the feature to set
DEBUGCTLMSR_FREEZE_LBRS_ON_PMI and DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI in
MSR_IA32_DEBUGCTLMSR.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index bb24d83621328..37da587ede716 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1259,6 +1259,7 @@ void kvm_initialize_cpu_caps(void)
>  	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
>  		F(PERFMON_V2),
>  		SCATTERED_F(AMD_LBR_V2),
> +		SCATTERED_F(AMD_LBR_PMC_FREEZE),
>  	);

[Severity: High]
Should X86_FEATURE_AMD_LBR_PMC_FREEZE also be gated in svm_set_cpu_caps()
(and in svm_get_supported_debugctl()) on lbrv, enable_mediated_pmu, and
X86_FEATURE_PERFMON_V2?

In arch/x86/kvm/svm/svm.c, svm_set_cpu_caps() clears X86_FEATURE_AMD_LBR_V2
and X86_FEATURE_BUS_LOCK_DETECT when LBR virtualization or the mediated PMU
is unavailable:

arch/x86/kvm/svm/svm.c:svm_set_cpu_caps() {
	...
		if (!lbrv || !enable_mediated_pmu ||
		    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2) ||
		    kvm_pmu_cap.num_branches_lbr !=3D SVM_LBR_V2_STACK_SIZE)
			kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
	}
	...
	if (!lbrv)
		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
}

Without similar gating for X86_FEATURE_AMD_LBR_PMC_FREEZE:

1. When !lbrv, MSR_IA32_DEBUGCTLMSR is not virtualized in svm_set_msr(),
   which ignores writes via kvm_pr_unimpl_wrmsr(), leaving the advertised
   feature non-functional:

arch/x86/kvm/svm/svm.c:svm_set_msr() {
	case MSR_IA32_DEBUGCTLMSR:
		if (!lbrv) {
			kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
			break;
		}
}

2. When lbrv is enabled but !enable_mediated_pmu (or when
   !kvm_vcpu_has_mediated_pmu(vcpu)), the perf_event-backed vPMU does not
   emulate freeze-on-PMI in __kvm_perf_overflow(). Because
   svm_get_supported_debugctl() still permits setting
   DEBUGCTLMSR_FREEZE_LBRS_ON_PMI and DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI in
   svm->vmcb->save.dbgctl, those bits are loaded into the physical
   MSR_IA32_DEBUGCTLMSR while the hardware PMCs and LBRv2 remain owned by
   host perf, causing host PMIs during guest execution to freeze host PMCs
   and LBRs (and trigger the reserved PerfCntrGlobalStatus warning in
   amd_pmu_v2_handle_irq() if bit 59 is set).

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 01be2fc05d701..9b65728ee0d2f 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -801,6 +801,10 @@ static inline u64 svm_get_supported_debugctl(struct =
kvm_vcpu *vcpu)
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
>  		debugctl |=3D DEBUGCTLMSR_BUS_LOCK_DETECT;
> =20
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_PMC_FREEZE))
> +		debugctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |
> +			    DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI;
> +
>  	return debugctl;
>  }

[Severity: High]
When X86_FEATURE_AMD_LBR_PMC_FREEZE is exposed to the guest, does
amd_pmu_refresh() also need to clear the freeze status bits in
pmu->global_status_rsvd?

When DEBUGCTLMSR_FREEZE_LBRS_ON_PMI is enabled and a PMC overflows in the
guest, hardware sets GLOBAL_STATUS_LBRS_FROZEN (bit 58) in
MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, which amd_mediated_pmu_put() saves into
pmu->global_status:

arch/x86/kvm/svm/pmu.c:amd_mediated_pmu_put() {
	...
	wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, pmu->global_status);
}

However, amd_pmu_refresh() leaves all bits above nr_arch_gp_counters marked
as reserved in pmu->global_status_rsvd:

arch/x86/kvm/svm/pmu.c:amd_pmu_refresh() {
	...
	if (pmu->version > 1) {
		pmu->global_ctrl_rsvd =3D ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
		pmu->global_status_rsvd =3D pmu->global_ctrl_rsvd;
	}
}

Won't kvm_pmu_set_msr() then reject host-initiated KVM_SET_MSRS writes to
MSR_AMD64_PERF_CNTR_GLOBAL_STATUS during live migration (and strip the free=
ze
bits on intercepted writes to MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET) whenev=
er
GLOBAL_STATUS_LBRS_FROZEN (or GLOBAL_STATUS_COUNTERS_FROZEN) is set?

arch/x86/kvm/pmu.c:kvm_pmu_set_msr() {
	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
		/* Per PPR, Read-only MSR. Writes are ignored. */
		if (!msr_info->host_initiated)
			break;

		if (data & pmu->global_status_rsvd)
			return 1;

		pmu->global_status =3D data;
		break;
}

[Severity: High]
Can the hardware-cleared MSR_AMD64_PERF_CNTR_GLOBAL_CTL state on PMC
freeze-on-PMI be lost across a VM-Exit when MSR_AMD64_PERF_CNTR_GLOBAL_CTL
is write-intercepted?

When DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI is set and a counter overflows,
hardware clears the PerfCntrEn bits in MSR_AMD64_PERF_CNTR_GLOBAL_CTL
directly without a guest WRMSR.

On VM-Exit, svm_vcpu_run() only saves MSR_AMD64_PERF_CNTR_GLOBAL_CTL when
writes to the MSR are not intercepted, and amd_mediated_pmu_put() then zero=
es
the hardware MSR:

arch/x86/kvm/svm/svm.c:svm_vcpu_run() {
	...
	if (kvm_vcpu_has_mediated_pmu(vcpu)) {
		if (!msr_write_intercepted(svm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
			rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
			       vcpu_to_pmu(vcpu)->global_ctrl);
		...
	}
}

If MSR_AMD64_PERF_CNTR_GLOBAL_CTL is write-intercepted (for example when
kvm_need_perf_global_ctrl_intercept(vcpu) is true because guest
nr_arch_gp_counters differs from host num_counters_gp, or when L1 intercepts
the MSR for L2), won't KVM miss the hardware-cleared value and reload the
stale pre-overflow pmu->global_ctrl on the next amd_mediated_pmu_load(),
unfreezing the guest's counters?

[Severity: High]
Does svm_need_lbr_virtualization() also need to check for
DEBUGCTLMSR_FREEZE_LBRS_ON_PMI and DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI?

Currently svm_need_lbr_virtualization() only checks for DEBUGCTLMSR_LBR,
DEBUGCTLMSR_BUS_LOCK_DETECT, and svm_lbrv2_active():

arch/x86/kvm/svm/svm.c:svm_need_lbr_virtualization() {
	struct vcpu_svm *svm =3D to_svm(vcpu);

	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETEC=
T))
		return true;

	if (svm_lbrv2_active(vcpu))
		return true;

	return false;
}

If a guest sets DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI without enabling LBRs or
Bus Lock Detect (or sets DEBUGCTLMSR_FREEZE_LBRS_ON_PMI before setting
DBG_EXTN_CFG_LBRV2EN), SVM_MISC2_ENABLE_V_LBR will remain clear in
svm->vmcb->control.misc_ctl2.

When SVM_MISC2_ENABLE_V_LBR is clear, svm_vcpu_run() only updates the
hardware MSR_IA32_DEBUGCTLMSR when vcpu->arch.host_debugctl differs from
svm->vmcb->save.dbgctl:

arch/x86/kvm/svm/svm.c:svm_vcpu_run() {
	if (!(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR) &&
	    vcpu->arch.host_debugctl !=3D svm->vmcb->save.dbgctl)
		update_debugctlmsr(svm->vmcb->save.dbgctl);
}

Because vcpu_enter_guest() captures vcpu->arch.host_debugctl =3D
get_debugctlmsr() before kvm_mediated_pmu_load() calls
perf_load_guest_context() -> amd_pmu_lbr_disable_all() (which clears
DEBUGCTLMSR_FREEZE_LBRS_ON_PMI in hardware MSR_IA32_DEBUGCTLMSR on the host=
),
if the guest's svm->vmcb->save.dbgctl matches the host's pre-disable
DEBUGCTLMSR_FREEZE_LBRS_ON_PMI value, won't svm_vcpu_run() skip
update_debugctlmsr() and leave the hardware MSR_IA32_DEBUGCTLMSR cleared?

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019210532.3786=
28-1-shivansh.dhiman@amd.com?part=3D11
