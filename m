Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB160175A72
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359437; cv=none; b=c21WpAk1JbiX/xvyFfPX+sCd81yNCGRZ/XCubQZyovGpHn7bqNM1O8ou4hnK3XKfkhPnDIeEI95jhX7qD+ZChWvX3+qeLwmvEY6+83Yg7gqZMwo/1P4ED9kDnbIe/LX95RovMGq/YYfRjEtvGMV12PXhTvoOr5Z7n4oz5iNGY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359437; c=relaxed/simple;
	bh=3a+Z64C6C0DCwG010zWN0FPlzluR76NwJy2kZuY/8nY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BHzjv57JkboNm8MzIbmH+Da5sAnROZs7PY5oKNGkuYR9wK5p0NjL/59G+2LM/BTRbgFkPpJ9yWL2rwEWy7j3qAq/TH1NFctJcFO28MdkGSdqShW0HnkruLYRFzxAgdflICZYhX3x+9SSmf5L3nukYi4V5jm93ulVW+dtCtlb3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHLjaoXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHLjaoXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CE11F00A3A;
	Mon, 10 Aug 2026 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359435;
	bh=6xq5TfJMDWjEZh8bvz4EIyOR3zHAC/zqM81YHkVk5VQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHLjaoXKGQII1XDBwNW4sXbyzu7SIBhoDuKl8ga3Vfej3O8sY6fy7ICo/ZD4zVUpe
	 l4W0OUpl/46rBzrL7S8R8YpAJgUUuiVauuz9MkPelc6brwSHUarKfeGIjSoW/WARnH
	 oRxw81PqHQNiP74iD4IGL3UO4V0I6IoaURGLlW4pMQWGrtbd7ntEYQ4RFNhxQletE/
	 ov42HVuLJNyvRF2NMcPO0TvK7ZVnriwKXgIfJ3eIWco7ot/pcnbAV/FNghSvpuD62z
	 wduWAmNMakRB6JW/bHdJreNiHw8YsZo7e/ebvYHyjSCpwJpS1DDJqU08gYlPaa/1lq
	 Gf1/UJ+uzrpkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] KVM: SVM: Add support for hardware-switched PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <901b3726ed48b666f72913e6c395f1317b574dd9.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <901b3726ed48b666f72913e6c395f1317b574dd9.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:57:14 +0000
Message-Id: <20260810105714.A2CE11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Emulated guest reads and writes to PMU MSRs return stale data or a=
re lost because the vendor state sync is skipped for guest-initiated access=
es.
- [High] PMC virtualization is never enabled for the BSP (Boot Strap Proces=
sor), leaving its PMU completely broken.
- [High] Nested virtualization (L2) PMU is broken because SVM_MISC2_ENABLE_=
V_PMC is never propagated to vmcb02.
- [High] Calling `wrmsrq()` inside the `noinstr` function `svm_vcpu_enter_e=
xit()` invokes instrumentable tracepoint code while RCU is not watching.
- [High] The `noinstr` function `svm_vcpu_enter_exit()` calls non-`__always=
_inline` PMU capability helpers, risking instrumentation in the VMRUN path.
--

--- Patch [6]: [PATCH 6/8] KVM: SVM: Add support for hardware-switched PMU =
---
commit d7b31e3949e70dae0c322517e2056c7007227bb4
Author: Sandipan Das <sandipan.das@amd.com>
Subject: KVM: SVM: Add support for hardware-switched PMU

This patch enables PMC virtualization on Zen 5 processors to offload
guest PMU context switches to hardware. It introduces vendor state sync
operations and a module parameter to toggle the feature, integrating it
with the VMCB save area.

> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 5dccf87763686..7d3a151b6cdee 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c

[ ... ]

> @@ -134,6 +217,10 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, st=
ruct msr_data *msr_info)
>  	/* MSR_PERFCTRn */
>  	pmc =3D get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
>  	if (pmc) {
> +		if (msr_info->host_initiated &&
> +		    kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITC=
HED) &&
> +		    amd_get_vendor_state(vcpu, msr))
> +			kvm_pmu_warn_vendor_state(msr);
>  		msr_info->data =3D pmc_read_counter(pmc);
>  		return 0;
>  	}

[Severity: High]
Does gating the vendor state sync behind msr_info->host_initiated break
guest-initiated emulated reads?

When KVM emulates an instruction (e.g., forced emulation or MMIO) that
accesses a PMU counter, host_initiated is false. For reads, this skips the
vendor state sync and returns the stale value in pmc->counter.

> @@ -158,6 +245,10 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, st=
ruct msr_data *msr_info)
>  	pmc =3D get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
>  	if (pmc) {
>  		pmc_write_counter(pmc, data);
> +		if (msr_info->host_initiated &&
> +		    kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITC=
HED) &&
> +		    amd_set_vendor_state(vcpu, msr))
> +			kvm_pmu_warn_vendor_state(msr);
>  		return 0;
>  	}

[Severity: High]
Does gating the vendor state sync behind msr_info->host_initiated break
guest-initiated emulated writes?

For emulated writes, KVM will update pmc->counter but skip updating the VMCB
save area because host_initiated is false. Since pmc_write_counter() does n=
ot
trigger a PMU refresh for mediated PMUs, the VMCB save area is never update=
d.
Hardware natively reloads the stale PMU state from the VMCB on the next VMR=
UN,
silently discarding the guest's emulated write.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ac3d898d21bda..2fa5d85d3c40e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -1271,6 +1274,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool i=
nit_event)
> =20
>  	svm_hv_init_vmcb(vmcb);
> =20
> +	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCH=
ED))
> +		control->misc_ctl2 |=3D SVM_MISC2_ENABLE_V_PMC;
> +
>  	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);

[Severity: High]
Will PMC virtualization remain disabled for the Boot Strap Processor (BSP)?

During early VCPU creation (svm_vcpu_reset), init_vmcb() is called before
userspace sets the CPUID via KVM_SET_CPUID2. At this point, the PMU version
is 0, so kvm_vcpu_has_mediated_pmu_caps() returns false and
SVM_MISC2_ENABLE_V_PMC is not set.

Unlike APs (which receive an INIT signal that triggers a subsequent
init_vmcb() after CPUID is set), the BSP does not undergo another reset.
During runtime, KVM skips manual PMU context switching because the
capability evaluates to true, but hardware also skips it due to the missing
V_PMC bit in the BSP's VMCB, effectively breaking the PMU for the BSP.

[Severity: High]
Is nested virtualization (L2) PMU broken because SVM_MISC2_ENABLE_V_PMC is
never propagated to vmcb02?

When KVM prepares vmcb02 to run an L2 guest in
nested_vmcb02_prepare_control(), it initializes misc_ctl2 but completely om=
its
setting SVM_MISC2_ENABLE_V_PMC. KVM will skip manual loading of the PMU sta=
te
because kvm_vcpu_has_mediated_pmu_caps() returns true when L2 is running, b=
ut
hardware will also skip it because vmcb02 lacks the V_PMC enable bit.

[ ... ]

> @@ -4456,6 +4486,14 @@ static noinstr void svm_vcpu_enter_exit(struct kvm=
_vcpu *vcpu, unsigned enter_fl
> =20
>  	amd_clear_divider();
> =20
> +	/*
> +	 * On #VMEXIT, PerfCntrGlobalCtl goes back to its reset state since
> +	 * its save slot is of Swap Type C. All enable bits are set but PMC
> +	 * virtualization requires them to be cleared before VMRUN.
> +	 */
> +	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCH=
ED))
> +		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> +
>  	if (is_sev_es_guest(vcpu))
>  		__svm_sev_es_vcpu_run(svm, enter_flags,

[Severity: High]
Does calling kvm_vcpu_has_mediated_pmu_caps() from a noinstr function risk
instrumentation in the VMRUN path?

Functions executed in a noinstr context must be explicitly marked noinstr or
__always_inline. kvm_vcpu_has_mediated_pmu_caps() and its dependency
kvm_vcpu_has_mediated_pmu() are only declared as static inline. If the
compiler compiles them out-of-line, the noinstr protections are stripped,
which can lead to objtool warnings and potential kernel panics if tracing
or instrumentation triggers during this VMRUN entry path.

[Severity: High]
Can calling wrmsrq() inside the noinstr function svm_vcpu_enter_exit() invo=
ke
instrumentable tracepoint code while RCU is not watching?

The wrmsrq() macro wraps native_write_msr(), which conditionally calls
do_trace_write_msr() if the write_msr tracepoint is enabled. Tracepoints
utilize RCU to safely iterate their probe lists. Executing this inside a
noinstr section where RCU is not watching causes lockdep/RCU splats
(RCU used illegally from extended quiescent state) and potential system
panics when tracing is active.

Should this use a non-instrumented wrapper such as native_wrmsrl() or
__wrmsr()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D6
