Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A6264614
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572869; cv=none; b=X9TWbZHr2oR4Is9yt8uOy4aDD/tji3IWyTudKIZArugmyn45iuy+n0nk1J3d8Mi5ND+1o2nqCsxhs6Ty69DvRp7LbwhtwAwnihpEpikoRCO4yxkxjaCKmawyQWaippHYAd9Vd6yYG/AxA46FOcWfc6LhM4CWGp2gpNYlWaoOmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572869; c=relaxed/simple;
	bh=9otNHqRfzLKCETvZjssYInFHVhp9y8Lfok+dsBsHh70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLzIejFdB1aHW7UyfLVAdshfHRInEuUnyVN1ib/Pxv4T4bSn8aDXfQlMPamdAFYjZr6Ug4xnWKEzPtlk4ReBNqXufFK9lDH4NBOBmNljUfAC3K78SVe9wtCzNvrvPhHhVNBRPnOkCQQ+cPxOECSSzPO4BqmVgLnNqMAWz7mfCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnJAZ/82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnJAZ/82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB3A1F000E9;
	Tue, 16 Jun 2026 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572868;
	bh=DMyD/EjUCFJsR/DwrpSXnp+09YkcT38Su9Pn4KLN558=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnJAZ/82DscQFO/haKCsr8+vLXEphkHuJQqPFKyqddhn4Jr8EpzFkf2u1db3XBTVj
	 pUVNnpiJ77t6jsemGfgq/4kF7gSsypyg8cx1kTdYTVAfMHQDUJrZhF3k0WbpKnCZMq
	 5FUCeLiF8eRE0O0aCuHBEjOGnwkRXGaH84H0Pu3CsuIrIxUH4CTXL2Ff9xlIkVMcuG
	 pynY7enHDlR4T+QgB2I5YOVzLnTUJBjsg3Hp34Oq3S0PKz1TDrTl1cwEzrrrXULkMH
	 PG0tLcvIbDD0GZrT9Vvm27/c8GZ007671KlGm39Hm6s90rOPR1pZ6sLzxZ2ZAT1Q4R
	 36JKQ1WFWrcNg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 25/25] DO NOT MERGE: Add nested_tlb_force_flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616004155.1435766-26-yosry@kernel.org>
References: <20260616004155.1435766-26-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:21:07 +0000
Message-Id: <20260616012108.4AB3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] State Desynchronization (ASID tracking) / Isolation Breach
- [High] Weakened Flush Semantics / Stale MMU Roots
- [Medium] Guideline Violation / Mutable State
--

commit 3fa5ceb50c23aa3458e6cdaf0dc109608a8b6192
Author: Yosry Ahmed <yosry@kernel.org>

DO NOT MERGE: Add nested_tlb_force_flush

Purely for testing only, add a knob that brings back unconditional force
flushes (and resync) on nested transitions.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -32,6 +32,9 @@
>  #include "hyperv.h"
>  #include "pmu.h"
> =20
> +static bool nested_tlb_force_flush;
> +module_param(nested_tlb_force_flush, bool, 0644);

[Severity: Medium]
Does this module parameter need to be mutable at runtime (0644)?

KVM guidelines suggest new flags should default to immutable (0444) because
toggling them creates unexpected state-machine transitions that can be
difficult to handle safely.

> [ ... ]
> @@ -691,6 +694,12 @@ static void nested_svm_entry_tlb_flush(struct kvm_vc=
pu *vcpu)
>  	/* Handle pending Hyper-V TLB flush requests */
>  	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> =20
> +	if (nested_tlb_force_flush) {
> +		kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> +		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> +		return;
> +	}

[Severity: Critical]
If this parameter is toggled off at runtime, can it leave
svm->nested.last_asid out of sync?

Because the early return skips updating last_asid, if the feature is later
disabled, KVM might see the stale last_asid matching a newly assigned L1
ASID:

nested_svm_entry_tlb_flush() {
    ...
    if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
        svm->nested.last_asid =3D svm->nested.ctl.asid;
        new_asid =3D true;
    }
    ...
}

Would this incorrectly evaluate new_asid to false and skip the required
flush, allowing the L2 guest to run with mappings from a different context?

[Severity: High]
Does returning early here bypass the full guest flush guarantees?

When replacing KVM_REQ_TLB_FLUSH_GUEST with KVM_REQ_MMU_SYNC and
KVM_REQ_TLB_FLUSH_CURRENT, it appears to skip synchronizing the previous
mmu roots (via kvm_mmu_sync_prev_roots) and guest-specific flush logic.

If L1 explicitly requests a full TLB flush, could a guest switching CR3
to a cached previous root end up using stale shadow page tables?

>  	if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
>  		svm->nested.last_asid =3D svm->nested.ctl.asid;
>  		new_asid =3D true;
> [ ... ]
> @@ -726,6 +735,12 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcp=
u *vcpu)
> =20
>  	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> =20
> +	if (nested_tlb_force_flush) {
> +		kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> +		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> +		return;
> +	}

[Severity: High]
Could this early return on VM-Exit similarly replace an explicit
TLB_CONTROL_FLUSH_ALL_ASID request with a weaker current-only flush?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.1435=
766-1-yosry@kernel.org?part=3D25
