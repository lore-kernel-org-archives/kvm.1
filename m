Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6543BDB6
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924041; cv=none; b=TYMHrmGBUsW8TFfi+syOAF8FkuNNe81v5Dy6h/IKp6URV0hBkphvrNGFz739uDtxzVlZYzLZ1r/YEJnu35zqckBXdAhEPrTHYOWVcMHa6qQ5czQxpP+44JIVgeGZGWHKQcIKoQKdafAFjjHVTSjrYMeiSwTx1JAV/nTFJm4NoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924041; c=relaxed/simple;
	bh=XCOEx4KvCytE0P+VRrczsY6bMnpmvkYmmVyhLcQZDho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ky9kP+K1AI2BXyoTldj4YCZicOjz9KCsWQeNHCv8bK1nRQkgnFqYOHTq1juiMWerMleZ6iTxy78jMl3VwlbHTys4rpUcKP2JwPLhUuJesB63RlJU9ywnKsI1vRB9Ql9BZ+vn5F3CGvaV3Zuvr0iFb4JrT/eeVb7rfojS71tkKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnK+ql29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnK+ql29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3816C1F000E9;
	Fri, 24 Jul 2026 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784924024;
	bh=RRRCSHZRkBnrkUYHs4nfrxfX6MrJ/J1ctu1kdUdF5Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnK+ql29LjmDySaRMQp/30P/2zQss2sAIzO/CP+ZjJEFonFqDAFBHXLapnvsYxctW
	 JZXCSh4BhEUw2FbzdWHcvehbkrdI8nropwKkF5Ym+QwQtxOCEtnnGbTn4rt8W8NEvj
	 S9D/9btU7jFqMzfbrOGRSPmdQXn/2svSFoviQuVmlKzNqkYoNZ8Vrkkr/p7wKmiOMB
	 OCfaqLzre2ECdHHd71Ma+yyIbcIeVM6gIE9cQ25vnKGABFDqWyxYpQJ43GnnVaouLH
	 ABVLdXVUXSGEHrF8PZVvdx9OyLTyGNFbH04SbuIeERRxuRuZ7Wp9E3GkVK7MMJDOi5
	 UrcPSFr8Ohrog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] KVM: SVM: Add LBR/PMC freeze support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724195040.630468-7-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-7-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 20:13:43 +0000
Message-Id: <20260724201344.3816C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM incorrectly advertises AMD_LBR_PMC_FREEZE to the guest even wh=
en prerequisite features (mediated PMU or LBR virtualization) are disabled,=
 leading to broken PMU state.
- [High] An L1 hypervisor can bypass CPUID capability checks and enable LBR=
/PMC freeze bits for L2 by injecting them via VMCB12's DEBUGCTL.
--

--- Patch [6]: [PATCH 6/7] KVM: SVM: Add LBR/PMC freeze support ---
commit 8a4ef61c23eb3f96d674c17183bad9ad198a18dd
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Add LBR/PMC freeze support

This commit adds support for the LBR and PMC freeze-on-PMI feature.
It updates CPUID initialization and allows the guest to set the
corresponding bits in DEBUGCTL if the feature is advertised.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d450a5b2499d9..03501b3145eb0 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1268,6 +1268,7 @@ void kvm_initialize_cpu_caps(void)
>  	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
>  		F(PERFMON_V2),
>  		SCATTERED_F(AMD_LBR_V2),
> +		SCATTERED_F(AMD_LBR_PMC_FREEZE),
>  	);

[Severity: High]
Will this feature remain advertised to the guest even when prerequisite
features like mediated PMU or LBR virtualization are disabled?

Looking at svm_hardware_setup() in arch/x86/kvm/svm/svm.c,
X86_FEATURE_AMD_LBR_V2 is dynamically cleared when prerequisites are missin=
g:

if (!lbrv || !enable_mediated_pmu ||
    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
        kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);

If X86_FEATURE_AMD_LBR_PMC_FREEZE is not cleared similarly, a guest might
see the feature in CPUID and attempt to use it. If the host administrator
configured KVM with lbrv=3D0, svm_set_msr() silently ignores writes to
MSR_IA32_DEBUGCTLMSR without injecting a #GP, which could break guest PMU
functionality.

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 01dae3828a7aa..105a71d69d68a 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -784,7 +784,9 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
> =20
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +#define DEBUGCTL_LBR_PMC_FREEZE_BITS	(DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |	\
> +					 DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI)
> +#define DEBUGCTL_RESERVED_BITS	(~(DEBUGCTLMSR_LBR | DEBUGCTL_LBR_PMC_FRE=
EZE_BITS))

[Severity: High]
Does modifying this macro globally allow an L1 hypervisor to bypass CPUID
capability checks for its L2 guest?

In arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save(), VMCB12's dbgctl
is masked directly against DEBUGCTL_RESERVED_BITS:

vmcb02->save.dbgctl &=3D ~DEBUGCTL_RESERVED_BITS;

By unreserving the freeze bits globally here, an unprivileged L1 hypervisor
with LBRV enabled could write DEBUGCTL_LBR_PMC_FREEZE_BITS into its
vmcb12->save.dbgctl. Since KVM copies this to L2's VMCB without checking if
L1 actually possesses the X86_FEATURE_AMD_LBR_PMC_FREEZE capability, this
appears to allow a nested capability bypass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724195040.6304=
68-1-shivansh.dhiman@amd.com?part=3D6
