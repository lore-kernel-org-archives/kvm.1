Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F383F167C
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586701; cv=none; b=A8AmXhs5AjrEjbrd0KT9bj4y9mlGzFlWo/8lRXyxPGwC1cwe1542H9Z+OhnxUIxyO4XEAmJLGBS3gHqR5KVl3wU/h5XYFQ9YSm7G5z98A7FCct0TZopjp+qcrO7j23dxobNt9bte8uwl1ZBNUMEa8tsQfXST+dGWYWwF8m/tyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586701; c=relaxed/simple;
	bh=jG9V113rT7dB4uy6TMeLoVK9fHltAJcuikEkyew4LXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G6HsJk5CEJTutg0+eOFs2cS/2MehxjzWlH7V3ALnaNzs1Fm2crEUnBZum0B64m3T/Sa8PFpwxpTXHHpSHm91szWn9yNiuVAuCk/AzqYoBSa6jr6wevDetIRgERKmOxmbqJS7zZycltEJmSmPPvksayAQ1Mqu8BphcF5jF9GCzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQFFUXMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQFFUXMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F23B1F000E9;
	Thu,  9 Jul 2026 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586699;
	bh=KqEvPl3Hk2y41PVbtB95ORib24+z0C20hDV5IzlO1xQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQFFUXMgSZuPOunvu+DXNBGVPdhk8+jR5iVz7dvEUZ9STkveQDDJxdotRWE+x6Wwk
	 PSDQmlI4noT6lE5euu611mQh/JOqRLU/L7rRG4flxhGWO7NCwdh8qWzX6fWqIJMFOy
	 7+Yr4f1V1f0wAMC6i5NGbGqpNA5ejZLhPXdnnWqLl2B1mWTabQ9SOEtthQDI+dpUKa
	 WTVESwzpkh+5V3J9PeBMx1/g9lSF1ODOd/qkxUWUYvABWYHDwHHsiRuBBev7ZSLU2W
	 R2BY3PnHtSmZsiuvtf1Zn/cNgyEE+JMBX/Au5hXWNa5lyG1JbXuskKg2UjQ3NSC+ca
	 tO6VHTgkZQrjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits
 dynamically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082953.69434-5-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-5-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:44:59 +0000
Message-Id: <20260709084459.6F23B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The dynamic reserved bit check for DEBUGCTLMSR_BUS_LOCK_DETECT is =
dead code because KVM explicitly clears the feature from SVM's supported CP=
UID capabilities.
- [High] Hardware silently ignores the guest's Bus Lock Detect configuratio=
n on VMRUN unless the guest also enables LBRs, due to AMD SVM requirements =
for loading DEBUGCTLMSR.
- [High] Bus Lock Detect support is fundamentally broken because DEBUGCTLMS=
R state management is strictly gated by unrelated LBR Virtualization parame=
ters and host capabilities.
--

--- Patch [4]: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits dyna=
mically ---
commit 8b16c8234c21a39b440d6a7688ffcc624702cdf8
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Compute DEBUGCTL reserved bits dynamically

This patch replaces the static DEBUGCTL_RESERVED_BITS macro with a
per-vCPU helper that derives reserved bits from the guest's CPUID. This
allows DEBUGCTLMSR_BUS_LOCK_DETECT when the guest supports it.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -1231,7 +1231,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to=
_save,
> =20
>  	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
>  		svm_copy_lbrs(to_save, from_save);
> -		to_save->dbgctl &=3D ~DEBUGCTL_RESERVED_BITS;
> +		to_save->dbgctl &=3D ~svm_get_debugctl_reserved_bits(vcpu);

[Severity: High]
Does Bus Lock Detect incorrectly depend on LBR Virtualization being support=
ed
and enabled?

Here, the guest's dbgctl is only copied if the host supports X86_FEATURE_LB=
RV.

Similarly, in svm_set_msr(), writes to MSR_IA32_DEBUGCTLMSR are uncondition=
ally
rejected if the lbrv module parameter is disabled:

svm_set_msr() {
        ...
        case MSR_IA32_DEBUGCTLMSR:
                if (!lbrv) {
                        kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
                        break;
                }
        ...
}

And earlier in nested_vmcb02_prepare_save(), L2's dbgctl is replaced with
L1's dbgctl if L1 does not explicitly enable LBRV for L2:

nested_vmcb02_prepare_save() {
        ...
        if (nested_vmcb12_has_lbrv(vcpu)) {
                ...
        } else {
                svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
        }
        ...
}

Will this break Bus Lock Detect for guests when LBR features are unavailable
or disabled?

>  	}
>  }

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h

[ ... ]

> @@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
> =20
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
> +{
> +	u64 debugctl =3D DEBUGCTLMSR_LBR;
> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> +		debugctl |=3D DEBUGCTLMSR_BUS_LOCK_DETECT;

[Severity: High]
Is it possible for a guest to actually have this feature under SVM?

In svm_set_cpu_caps(), KVM unconditionally clears the feature:

svm_set_cpu_caps() {
        ...
        kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
        ...
}

Because of this, guest_cpu_cap_has() will always evaluate to false,
rendering this new logic dead code. Guest writes to enable the feature
will inject a #GP.

[Severity: High]
If the dead-code issue above is fixed and KVM accepts the write to
DEBUGCTLMSR_BUS_LOCK_DETECT, will the hardware silently ignore the guest's
configuration on VMRUN unless the guest also enables LBRs?

AMD SVM only loads DEBUGCTLMSR from the VMCB save area during VMRUN if LBR
Virtualization is enabled. In svm_update_lbrv(), KVM disables V_LBR if the
LBR bit is not set:

svm_update_lbrv() {
        ...
        if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
                enable_lbrv =3D true;
        ...
        else if (!enable_lbrv && current_enable_lbrv)
                __svm_disable_lbrv(vcpu);
        ...
}

Could this create a state desynchronization where KVM accepts the feature
but the CPU ignores it?

> +
> +	return ~debugctl;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082953.6943=
4-1-shivansh.dhiman@amd.com?part=3D4
