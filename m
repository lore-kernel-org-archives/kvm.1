Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFB289367
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587336; cv=none; b=RAejnYQSPU2z9bUwMeI1yeOVSmr4kP1rzK/p5CyV4uQhPJMWbRyYwiibxVTdX+Ez0c+jkb86FuYtW+25rI8jptiLjOD23C90WOrv4le6dMFAHJX2gDm6r6AdwNjfcydLWOR6E46IKERMZ0W5mkorvVZ4PdpHfwZFDjqlrIegXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587336; c=relaxed/simple;
	bh=DjxYLvRAp8ti97QizA88QgS5r4h7iKjuoUs7ZKea07c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jCi30TUF4RV3bRnrsSGEK/FkPtoWy/LEZYLP1iW5pZf+q0wb/yJNLFKdN+XfjYICK/zUv1s46dC8QuRIWtVx++SozMl1++Ln7xL38rQUBh4haYaM4iFAu8RvnEguBXMj4YSraW5HnpDrXeKKOF7mzTouvkKcDFg0DZ8lUOUbsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adbiYm+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adbiYm+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8F81F000E9;
	Thu,  9 Jul 2026 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587335;
	bh=mtVu+GNsdNYm8/+35SwrsCKddrAGrrj5dqsNSt42Mhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adbiYm+zRnYp/ZHcTtDwPCKWOdm/rq15qq6GfN8Cr17jXSOBrEbRREJL2HCN0nRkc
	 K0YbNMNUUyvVjw7NKp6O6AazQqim0Eut3XaDp0R5Gp3GqkvkyHLm/bJKNakF5XVcgL
	 NK1Mmyib/0PiITPwGHKG6jDKgnX+s4gAbrXwCmzyhlxaVxmdaFFHONpEntmE/d0jY0
	 ODcaaiMBn2VTuTU35RsNzlmFPxAklLppRGU9QVZKBhj7jP+TD1hDEc8F0taYTEozfJ
	 wWvVvGbTC3Rynz7CZVIenDtHNT6rhXD9E7o3Pd2Oq9njI7cceaORrfxg6Tt2gDFGJU
	 1Hc1Or9wCmOuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] KVM: SVM: Add Bus Lock Detect support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082953.69434-6-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-6-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:55:34 +0000
Message-Id: <20260709085535.3D8F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unprivileged host userspace can trigger a KVM_BUG_ON (resulting in=
 a WARN_ON_ONCE and potential host panic) by dynamically toggling MSR_IA32_=
DEBUGCTLMSR for a SEV-ES guest.
- [High] Enabling Bus Lock Detect inadvertently un-intercepts LBR MSRs, gra=
nting the guest unauthorized hardware access to LBRs.

Pre-existing issues:
- [High] L2 guest can bypass MSR intercepts and overwrite L1's MSR_IA32_DEB=
UGCTLMSR and LBR state when L1 enables Bus Lock Detect or LBR.
- [High] Bus Lock Trap #DB causes are lost during reinjection, rendering th=
e feature non-functional in the guest.
--

--- Patch [5]: [PATCH v3 5/5] KVM: SVM: Add Bus Lock Detect support ---
commit d2f71feda9dbdbb51e59bc110b5518d4f10bcf93
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Add Bus Lock Detect support

Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
Virtualization is enabled. Add this dependency in the SVM.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index a59389c322da1..bd204aa33e47f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -882,7 +882,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  	bool current_enable_lbrv =3D svm->vmcb->control.misc_ctl2 & SVM_MISC2_E=
NABLE_V_LBR;
>  	bool enable_lbrv =3D false;
> =20
> -	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
> +	/* Bus Lock Detect in guest depends on LBR Virtualization */
> +	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DE=
TECT))
>  		enable_lbrv =3D true;

[Severity: High]
Could this change allow unprivileged host userspace to trigger a kernel pan=
ic
on systems with panic_on_warn=3D1?

If userspace calls KVM_SET_MSRS for a SEV-ES vCPU before the guest is
finalized and sets MSR_IA32_DEBUGCTLMSR with DEBUGCTLMSR_LBR or
DEBUGCTLMSR_BUS_LOCK_DETECT, svm_update_lbrv() will set enable_lbrv =3D tru=
e.

If userspace subsequently writes 0 to clear the bit, enable_lbrv becomes
false, causing KVM to call __svm_disable_lbrv().

This would then hit the following assertion:

arch/x86/kvm/svm/svm.c:__svm_disable_lbrv() {
    ...
    KVM_BUG_ON(is_sev_es_guest(vcpu), vcpu->kvm);
    ...
}


[Severity: High]
Does enabling Bus Lock Detect inadvertently grant the guest unauthorized
hardware access to LBRs?

When a guest with Bus Lock Detect sets DEBUGCTLMSR_BUS_LOCK_DETECT,
enable_lbrv becomes true. This leads to a call to
svm_recalc_lbr_msr_intercepts():

arch/x86/kvm/svm/svm.c:svm_recalc_lbr_msr_intercepts() {
    ...
    bool intercept =3D !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_=
LBR);
    ...
}

Because intercepts are disabled entirely based on SVM_MISC2_ENABLE_V_LBR,
could this un-intercept all LBR MSRs (e.g., MSR_IA32_LASTBRANCHFROMIP) even
if the guest does not possess the LBRV CPUID feature?


[Severity: High]
This is a pre-existing issue, but can an L2 guest bypass MSR intercepts and
overwrite L1's state if L1 enables Bus Lock Detect or LBRs?

If L1 enables these features but does not expose LBRV to L2, KVM populates
vmcb02->save.dbgctl with L1's state. When svm_update_lbrv() sees these bits,
it appears to activate hardware LBRV (SVM_MISC2_ENABLE_V_LBR) for L2.

This would un-intercept MSRs for L2, allowing L2 to modify DEBUGCTLMSR
natively. Upon nested VMEXIT, KVM copies this modified state back to L1:

arch/x86/kvm/svm/nested.c:nested_svm_vmexit() {
    ...
    if (!nested_vmcb12_has_lbrv(vcpu)) {
        svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
        vmcb_mark_dirty(vmcb01, VMCB_LBR);
    }
    ...
}

Would this allow a malicious L2 guest to corrupt L1's state?

[ ... ]

> @@ -5595,9 +5596,17 @@ static __init void svm_set_cpu_caps(void)
>  	 * Clear capabilities that are automatically configured by common code,
>  	 * but that require explicit SVM support (that isn't yet implemented).
>  	 */
> -	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
> =20
> +	/*
> +	 * LBR Virtualization must be enabled to support BusLockTrap inside the
> +	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
> +	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
> +	 * enabled.
> +	 */
> +	if (!lbrv)
> +		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);

[Severity: High]
This isn't a bug introduced by this patch, but are Bus Lock Trap exceptions
actually reaching the guest?

According to the AMD APM, when a #DB is intercepted, the CPU provides the
new DR6 value (containing the DR6_BUS_LOCK bit) in EXITINFO1 and does not
update the guest's DR6.

However, when KVM reinjects the exception, it reads the stale save.dr6:

arch/x86/kvm/svm/svm.c:db_interception() {
    ...
    u32 payload =3D svm->vmcb->save.dr6 ^ DR6_ACTIVE_LOW;
    kvm_queue_exception_p(vcpu, DB_VECTOR, payload);
    ...
}

Does this cause the DR6_BUS_LOCK bit to be lost during reinjection, renderi=
ng
the feature non-functional in the guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082953.6943=
4-1-shivansh.dhiman@amd.com?part=3D5
