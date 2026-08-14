Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BC356766
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724391; cv=none; b=aHCY4D2n1uminUNu9CFSJFyx3oKneLGUjzPYF9vtoAHNZzaiU6H5RBiHfpJp9tIXSGdtGZNQFV81iMLSaWbh1PF7GZHXH/V+KUq41j7btjmbeubtEwJZ6ivPFMvO+pz8lGu+OJ0hLKszApNfWWvhfwa3+fHqQeUUW3cdWXvzFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724391; c=relaxed/simple;
	bh=rnpgzI3T32Lapc99tzCMZ9KwSphlTA7cUs/U6m83Zao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ju21vmZVr1yI5yuqIXXGCWr8V3l07zv6sBBxqwzDVzYWac7bJ4t5GzZP6saalJYVxlIww1TcuNeIaJzY4VJnDtdmsdI+9JziCx8Wh1WoTrpylq4kvnIGFNd2JPAd8j+qvnbHHGlKoqSgQxd278u/prOdLuNHnOEg/kAqeQkqfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovM/rxp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovM/rxp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136041F000E9;
	Fri, 14 Aug 2026 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786724390;
	bh=4Cwo0VwwVUrH3c1Bjav6EvEBmzynNZLGLAXugv6EgIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovM/rxp9Dx1VKi0564IWq3OEzffFBRVUUuhWZEtKbDS1gOJAiN3PhYsIiyjkTW/ZE
	 3fXRhREGj2Tl180nv07X/60bXIsQPRFMt0hXLYhkoiYFuLR4ODTlfmtxIEFWxVXr0G
	 6qHA5X5zyM0L7k0P27lJV6XcVdM2f+2hIv4efLfyvV+wVRMX/ZXSCXJyBiRxUSyKUe
	 pJZ5sxy5F8z4m4+S2hDiSnhgdUv+P5axnngBio2dT9/Vyow3ZBMhzRlqX0lNievvGe
	 TBtba++5jDDlkbcqqnBC3PGBgYNLcl9pqTze4DvmTBIsNBT4kAucJQqlGO7k5HnRsT
	 E7fjcJgaWQOpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814161129.2177118-4-seanjc@google.com>
References: <20260814161129.2177118-1-seanjc@google.com>
 <20260814161129.2177118-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:19:49 +0000
Message-Id: <20260814161950.136041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] The function `vmx_needs_pi_wakeup()` was not renamed to `vt_needs_p=
i_wakeup()`.
- [Low] The shared inline API `__vmx_deliver_posted_interrupt()` was not re=
named to `__vt_deliver_posted_interrupt()`.
- [Low] A comment inside `vt_can_use_vtd_pi()` references the old `vmx_pi_s=
tart_bypass()` function name.
--

--- Patch [3]: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from =
"vmx" to "vt" ---
commit 735ede2af83c20ffbbfab70a4d63203f6ab6beab
Author: Sean Christopherson <seanjc@google.com>

KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"

Rename all common posted interrupt APIs that use a "vmx" prefix to instead
use a "vt" prefix to capture that they are used for both VMX and TDX vCPUs.

[Severity: Low]
This isn't a bug, but should __vmx_deliver_posted_interrupt() in
arch/x86/kvm/vmx/common.h also be renamed? It appears to be a common API
used by TDX code (tdx_deliver_interrupt() in arch/x86/kvm/vmx/tdx.c).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>

> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_int=
r.c
> index 24221ba553be1..7a6a445870442 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c

[ ... ]

> @@ -146,7 +146,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  		pi_set_on(pi_desc);
>  }
> =20
> -static bool vmx_can_use_vtd_pi(struct kvm *kvm)
> +static bool vt_can_use_vtd_pi(struct kvm *kvm)
>  {
>  	/*
>  	 * Note, reading the number of possible bypass IRQs can race with a

[Severity: Low]
This isn't a bug, but the comment just below this line still references the
old name: "vmx_pi_start_bypass() ensures blockng vCPUs will see...". Should
this be updated to vt_pi_start_bypass()?

[ ... ]

> @@ -219,10 +219,10 @@ static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vc=
pu)
>  	 * back to the pi_wakeup_handler() function.
>  	 */
>  	return (vmx_can_use_ipiv(vcpu) && !is_td_vcpu(vcpu)) ||
> -		vmx_can_use_vtd_pi(vcpu->kvm);
> +		vt_can_use_vtd_pi(vcpu->kvm);
>  }

[Severity: Low]
This isn't a bug, but should vmx_needs_pi_wakeup() also be renamed to
vt_needs_pi_wakeup()? It explicitly handles both VMX and TDX cases by
checking is_td_vcpu(vcpu).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814161129.2177=
118-1-seanjc@google.com?part=3D3
